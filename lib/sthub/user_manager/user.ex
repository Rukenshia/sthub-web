defmodule StHub.UserManager.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :username, :string
    field :role, :string
    field :last_testship_check, :naive_datetime
    field :api_token, Ecto.UUID

    timestamps()
  end

  @doc false

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:id, :username, :role, :last_testship_check])
  end
end
