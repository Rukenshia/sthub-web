defmodule StHubWeb.WowsController do
  use StHubWeb, :controller

  alias StHub.Wows.Api

  def index(conn, _params) do
    user_id =
      case Guardian.Plug.current_resource(conn) do
        nil ->
          nil

        user ->
          user.id
      end

    render(conn, "index.html", current_user_id: user_id)
  end

  def api_show_wows_version(conn, _params) do
    render(conn, "version.json", version: Api.get_game_version())
  end
end
