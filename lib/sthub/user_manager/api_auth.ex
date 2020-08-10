defmodule StHub.UserManager.ApiAuth do
  import Plug.Conn
  alias Phoenix.Controller
  require Logger

  import Ecto.Query, only: [from: 2]
  alias StHub.Repo
  alias StHub.UserManager.User

  def init(default), do: default

  @spec call(Plug.Conn.t(), any) :: Plug.Conn.t()
  def call(conn, _default) do
    auth_header = get_req_header(conn, "authorization")

    case auth_header do
      ["Bearer " <> token] ->
        token = token

        if token != :error do
          case from(u in User, where: u.api_token == ^token)
               |> Repo.one() do
            %User{} = user ->
              Logger.debug("ApiAuth user=#{user.id}")

              conn
              |> StHub.UserManager.Guardian.Plug.sign_in(user)
              |> assign(:curent_user, user)

            _ ->
              Logger.warn("Invalid api_token used. api_token=#{token}")
              conn
          end
        else
          conn
          |> send_resp(400, "invalid token format. expected 'Bearer <uuid>'")
          |> halt()
        end

      _ ->
        conn
    end
  end
end
