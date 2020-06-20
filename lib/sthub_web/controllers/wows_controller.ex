defmodule StHubWeb.WowsController do
  use StHubWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
