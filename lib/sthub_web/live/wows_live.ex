defmodule StHubWeb.WowsLive do
  require Logger
  use Phoenix.LiveView
  import Ecto.Query
  import Phoenix.LiveView.Helpers, only: [live_redirect: 2]

  alias StHub.Repo
  alias StHubWeb.Endpoint
  alias StHubWeb.Router.Helpers, as: Routes

  defp get_ships() do
    from(s in StHub.Wows.Ship, order_by: [desc: s.inserted_at])
    |> Repo.all()
  end

  def mount(_params, %{"user_id" => user_id}, socket) do
    user =
      case user_id do
        nil ->
          nil

        id ->
          StHub.UserManager.get_user!(id)
      end

    {:ok,
     socket
     |> assign(:current_user, user)
     |> assign(:ships, get_ships())}
  end

  def handle_event("update_ships", _value, socket) do
    ships = refresh_ships()
    {:noreply, assign(socket, :ships, ships)}
  end

  defp refresh_ships() do
    :ok = StHub.Wows.update_ship_database()

    get_ships()
  end

  def user_can_refresh_ships(%StHub.UserManager.User{role: "administrator"}) do
    true
  end

  def user_can_refresh_ships(%StHub.UserManager.User{role: "contributor"}) do
    true
  end

  def user_can_refresh_ships(_) do
    false
  end
end
