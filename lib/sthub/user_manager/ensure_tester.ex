defmodule StHub.UserManager.EnsureTester do
  import Plug.Conn
  alias Phoenix.Controller

  def init(default), do: default

  def call(conn, %{redirect: false}) do
    case Guardian.Plug.current_resource(conn) do
      nil ->
        conn
        |> send_resp(401, "no authorization present")
        |> halt()

      user ->
        case user.role do
          "tester" ->
            conn

          "contributor" ->
            conn

          "administrator" ->
            conn

          _ ->
            conn
            |> send_resp(401, "not authorized")
            |> halt()
        end
    end
  end

  def call(conn) do
    case Guardian.Plug.current_resource(conn) do
      nil ->
        conn
        |> Controller.put_flash(:error, "You are not allowed to view this page")
        |> Controller.redirect(to: "/")
        |> halt()

      user ->
        case user.role do
          "tester" ->
            conn

          "contributor" ->
            conn

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
