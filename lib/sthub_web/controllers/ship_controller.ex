defmodule StHubWeb.ShipController do
  use StHubWeb, :controller

  alias StHub.Repo
  alias StHub.Wows

  def show(conn, %{"ship_id" => ship_id}) do
    ship =
      Wows.get_ship!(ship_id)
      |> Repo.preload(iterations: [changes: [:parameter]])

    render(conn, "show.html", ship: ship)
  end
end
