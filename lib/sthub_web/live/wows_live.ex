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

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :ships, get_ships())}
  end

  def handle_event("update_ships", _value, socket) do
    ships = refresh_ships()
    {:noreply, assign(socket, :ships, ships)}
  end

  defp refresh_ships() do
    :ok = StHub.Wows.update_ship_database()

    get_ships()
  end
end
