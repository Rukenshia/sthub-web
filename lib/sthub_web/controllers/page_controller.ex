defmodule StHubWeb.PageController do
  use StHubWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
