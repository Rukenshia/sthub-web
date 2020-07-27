defmodule StHubWeb.ShipController do
  use StHubWeb, :controller

  alias StHub.Repo
  alias StHub.Wows

  import Ecto.Query, only: [from: 2]

  def show(conn, %{"ship_id" => ship_id}) do
    user_id =
      case Guardian.Plug.current_resource(conn) do
        nil ->
          nil

        user ->
          user.id
      end

    render(conn, "show.html", ship: Wows.get_ship!(ship_id), current_user_id: user_id)
  end

  def api_index_testships(conn, _params) do
    render(conn, "index.json",
      ships: from(s in Wows.Ship, where: s.credited_to_testers == true) |> Repo.all()
    )
  end
end
