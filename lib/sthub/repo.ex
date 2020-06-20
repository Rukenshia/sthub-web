defmodule StHub.Repo do
  use Ecto.Repo,
    otp_app: :sthub,
    adapter: Ecto.Adapters.Postgres
end
