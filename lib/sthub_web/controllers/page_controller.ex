defmodule StHubWeb.PageController do
  use StHubWeb, :controller
  require Logger

  def title(conn, _assigns) do
    Logger.debug("#{inspect(conn)}")
    "Home"
  end

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def protected(conn, _) do
    user = Guardian.Plug.current_resource(conn)
    render(conn, "protected.html", current_user: user)
  end
end
