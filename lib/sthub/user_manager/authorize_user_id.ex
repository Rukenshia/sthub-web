defmodule StHub.UserManager.AuthorizeUserId do
  import Plug.Conn
  alias Phoenix.Controller

  def init(default), do: default

  def call(%Plug.Conn{params: %{"user_id" => user_id}} = conn, %{redirect: false}) do
    case Guardian.Plug.current_resource(conn) do
      nil ->
        conn
        |> send_resp(401, "no authorization present")
        |> halt()

      user ->
        if user.id == String.to_integer(user_id) do
          conn
        else
          conn
          |> send_resp(401, "not authorized")
          |> halt()
        end
    end
  end

  def call(%Plug.Conn{params: %{"user_id" => user_id}} = conn, _opts) do
    case Guardian.Plug.current_resource(conn) do
      nil ->
        conn
        |> Controller.put_flash(:error, "You are not allowed to view this page")
        |> Controller.redirect(to: "/")
        |> halt()

      user ->
        if user.id == String.to_integer(user_id) do
          conn
        else
          conn
          |> Controller.put_flash(:error, "You are not allowed to view this page")
          |> Controller.redirect(to: "/")
          |> halt()
        end
    end
  end
end
