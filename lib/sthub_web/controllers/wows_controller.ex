defmodule StHubWeb.WowsController do
  use StHubWeb, :controller

  alias StHub.Wows.Api

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def api_show_wows_version(conn, _params) do
    render(conn, "version.json", version: Api.get_game_version)
  end
end
