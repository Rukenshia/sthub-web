defmodule StHubWeb.ShipController do
  use StHubWeb, :controller

  alias StHub.Repo
  alias StHub.Wows

  import Ecto.Query, only: [from: 2]

  def show(conn, %{"ship_id" => ship_id}) do
    render(conn, "show.html", ship: Wows.get_ship!(ship_id))
  end

  def api_index_testships(conn, _params) do
    render(conn, "index.json",
      ships: from(s in Wows.Ship, where: s.credited_to_testers == true) |> Repo.all()
    )
  end
end
