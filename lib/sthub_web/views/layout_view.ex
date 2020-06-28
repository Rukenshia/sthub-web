defmodule StHubWeb.LayoutView do
  use StHubWeb, :view
  require Logger
  alias Phoenix.Controller

  def page_title(conn) do
    case title_name(conn) do
      nil ->
        "StHub"

      name ->
        {:safe, "#{name} &centerdot; StHub"}
    end
  end

  defp title_name(conn) do
    view = Map.get(conn.private, :phoenix_view)

    if Kernel.function_exported?(view, :title, 2) do
      view.title(Phoenix.Controller.action_name(conn), conn.assigns)
    else
      nil
    end
  end

  def navitem(conn, view, path, action) do
    current_title =
      case title_name(conn) do
        nil ->
          "StHub"

        name ->
          name
      end

    link_title =
      case view.title(action, %{}) do
        nil ->
          "StHub"

        name ->
          name
      end

    render("navitem.html",
      conn: conn,
      is_active: current_title == link_title,
      name: link_title,
      path: path
    )
  end
end
