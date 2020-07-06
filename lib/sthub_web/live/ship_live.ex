defmodule StHubWeb.ShipLive do
  require Logger
  use Phoenix.LiveView
  use Phoenix.HTML
  import StHubWeb.ErrorHelpers

  alias StHub.Repo
  alias StHubWeb.Router.Helpers, as: Routes

  alias StHub.Wows
  alias StHub.Wows.Ship

  def mount(_, %{"ship_id" => ship_id}, socket) do
    {:ok,
     socket
     |> assign(:ship, Wows.get_ship!(ship_id) |> Repo.preload(iterations: [changes: [:parameter]]))}
  end

  def handle_event("update_status", %{"ship_status" => ship_status }, socket) do


    params = case ship_status do
      "released" ->
        %{"credited_to_testers" => false, "released" => true, "released_at" => NaiveDateTime.utc_now() }
      "unreleased" ->
        %{"credited_to_testers" => false, "released" => false, "released_at" => nil }
      "credited" ->
        %{"credited_to_testers" => true, "released" => false, "released_at" => nil}
      end

    ship = socket.assigns[:ship]
    |> Ship.changeset(params)
    |> Repo.update!()

    {:noreply, socket |> assign(:ship, ship) }
  end
end
