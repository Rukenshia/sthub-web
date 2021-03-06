defmodule StHub.UserManager.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :sthub,
    error_handler: StHub.UserManager.ErrorHandler,
    module: StHub.UserManager.Guardian

  # If there is a session token, restrict it to an access token and validate it
  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  # If there is an authorization header, restrict it to an access token and validate it
  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  # Load the user if either of the verifications worked
  plug Guardian.Plug.LoadResource, allow_blank: true

  plug :set_current_user

  def set_current_user(conn, _opts) do
    user = Guardian.Plug.current_resource(conn)

    conn
    |> assign(:current_user, user)
  end
end
