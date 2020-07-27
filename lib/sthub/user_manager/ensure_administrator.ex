defmodule StHub.UserManager.EnsureAdministrator do
  import Plug.Conn
  alias Phoenix.Controller

  def init(default), do: default

  def call(conn, _default) do
    case Guardian.Plug.current_resource(conn) do
      nil ->
        conn
        |> Controller.redirect(to: "/")

      user ->
        case user.role do
          "administrator" ->
            conn

          _ ->
            conn
            |> Controller.redirect(to: "/")
        end
    end
  end
end
