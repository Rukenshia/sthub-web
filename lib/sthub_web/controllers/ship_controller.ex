defmodule StHubWeb.ShipController do
  use StHubWeb, :controller

  alias StHub.Repo
  alias StHub.Wows

  def show(conn, %{"ship_id" => ship_id}) do
    render(conn, "show.html", ship_id: ship_id)
  end
end
