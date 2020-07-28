defmodule StHub.UserManager.EnsureContributor do
  import Plug.Conn
  alias Phoenix.Controller

  def init(default), do: default

  def call(conn, _default) do
    case Guardian.Plug.current_resource(conn) do
      nil ->
        conn
        |> Controller.put_flash(:error, "You are not allowed to view this page")
        |> Controller.redirect(to: "/")
        |> halt()

      user ->
        case user.role do
          "contributor" ->
            conn

          # Administrator overrides contributors
          "administrator" ->
            conn

          _ ->
            conn
            |> Controller.put_flash(:error, "You are not allowed to view this page")
            |> Controller.redirect(to: "/")
            |> halt()
        end
    end
  end
end
