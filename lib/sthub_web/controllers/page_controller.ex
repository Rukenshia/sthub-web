defmodule StHubWeb.PageController do
  use StHubWeb, :controller
  require Logger

  import Ecto.Query, only: [from: 2]
  alias StHub.Repo
  alias StHub.Wows.OpenId

  def title(conn, _assigns) do
    Logger.debug("#{inspect(conn)}")
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
    |> redirect(external: OpenId.get_login_url(realm, Routes.url(conn) <> Routes.page_path(conn, :login_callback)))
    |> halt()
  end

  def login_callback(conn, %{"status" => "ok", "access_token" => access_token, "account_id" => account_id, "nickname" => nickname}) do
    # TODO: Check if test ships are available
    # TODO: Add fields to user for Wows Info
    # TODO: Add wows info to user here
    # TODO: handle if user already has info (what to do?)
    conn
      |> put_flash(:info, "Successfully authenticated as #{nickname}")
      |>redirect(to: Routes.page_path(:index))
  end

  def login_callback(conn, params) do
    Logger.error(inspect(params))
  end
end
