defmodule StHubWeb.PageController do
  use StHubWeb, :controller
  require Logger

  import Ecto.Query, only: [from: 2]
  alias StHub.Repo
  alias StHub.Wows.OpenId
  alias StHub.Wows.Ship
  alias StHub.UserManager
  alias StHub.UserManager.Guardian

  def title(_action, _assigns) do
    "Home"
  end

  def index(conn, _params) do
    ships =
      from(ship in StHub.Wows.Ship, where: ship.credited_to_testers == true)
      |> Repo.all()

    render(conn, "index.html", ships: ships)
  end

  def start_login(conn, %{"realm" => realm}) do
    conn
    |> redirect(
      external:
        OpenId.get_login_url(
          realm,
          Routes.url(conn) <> Routes.page_path(conn, :login_callback, realm)
        )
    )
    |> halt()
  end

  def login_callback(conn, %{
        "realm" => realm,
        "status" => "ok",
        "access_token" => access_token,
        "account_id" => account_id,
        "nickname" => nickname
      }) do
    # TODO: Add fields to user for Wows Info
    # TODO: Add wows info to user here
    # TODO: handle if user already has info (what to do?)
    # TODO: Unlink accounts that no longer own testships
    user =
      case UserManager.get_user(String.to_integer(account_id)) do
        nil ->
          Logger.debug("Creating new user for account_id=#{account_id}")
          # Create a new user
          {:ok, user} =
            UserManager.create_user(%{
              "id" => String.to_integer(account_id),
              "username" => nickname,
              "role" => "user"
            })

          user

        user ->
          Logger.debug("Existing user logged in with account_id=#{account_id}")
          user
      end

    with :ok <- can_link_players(),
         {:ok, data} <- StHub.Wows.Api.get_player_data(realm, access_token, account_id),
         :ok <- validate_player_data(account_id, data),
         :ok <-
           player_has_testships?(realm, access_token, account_id) do
      {:ok, _} =
        UserManager.update_user(user, %{"last_testship_check" => NaiveDateTime.utc_now()})

      conn
      |> Guardian.Plug.sign_in(user)
      |> put_flash(:info, "Successfully authenticated as #{nickname}")
      |> redirect(to: Routes.page_path(conn, :index))
    else
      :no_testships_owned ->
        conn
        |> Guardian.Plug.sign_in(user)
        |> put_flash(:info, "You are logged in, but do not own any testships")
        |> redirect(to: Routes.page_path(conn, :index))

      :no_testships_available ->
        conn
        |> put_flash(:error, "Sorry, linking accounts is not possible at the moment")
        |> redirect(to: Routes.page_path(conn, :index))

      :no_private_data ->
        conn
        |> put_flash(:error, "Sorry, we could not log you in")
        |> redirect(to: Routes.page_path(conn, :index))

      :api_error ->
        conn
        |> put_flash(:error, "There was an issue talking to the Wargaming API")
        |> redirect(to: Routes.page_path(conn, :index))
    end
  end

  @doc """
    Handles when the login failed or was cancelled by the user
  """
  def login_callback(conn, %{"status" => "error", "code" => code, "message" => message}) do
    conn
    |> put_flash(:error, "Login failed with #{code}: #{message}")
    |> redirect(to: Routes.page_path(conn, :index))
  end

  @doc """
    can_link_players checks whether any test ships are currently
    credited to testers. We use this to detect whether the player
    is part of the testing program and only then unlock special features.

    If no test ships are credited at the moment, we will show a message
    to the user.
  """
  defp can_link_players() do
    ships = from(ship in Ship, where: ship.credited_to_testers == true) |> Repo.all()

    if length(ships) == 0 do
      :no_testships_available
    else
      :ok
    end
  end

  @doc """
    Verifies that the access token for the user works
  """
  defp validate_player_data(account_id, data) do
    with %{"data" => %{^account_id => %{"private" => %{"credits" => _credits}}}} <- data do
      :ok
    else
      _ ->
        :no_private_data
    end
  end

  defp player_has_testships?(realm, access_token, account_id) do
    with {:ok, %{"data" => %{^account_id => player_ships}}} <-
           StHub.Wows.Api.get_player_ship_statistics(realm, access_token, account_id,
             in_garage: 1,
             fields: "ship_id"
           ) do
      ships =
        from(ship in Ship,
          where:
            ship.credited_to_testers == true and
              ship.id in ^Enum.map(player_ships, fn ps -> ps["ship_id"] end)
        )
        |> Repo.all()

      if length(ships) > 0 do
        :ok
      else
        :no_testships_owned
      end
    else
      {:error, res} ->
        Logger.warn(res)
        :api_error
    end
  end
end
