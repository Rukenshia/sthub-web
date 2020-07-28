defmodule StHubWeb.PageController do
  use StHubWeb, :controller
  require Logger

  import Ecto.Query, only: [from: 2]
  alias StHub.Repo

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
end
