defmodule StHub.Repo.Migrations.AddUsersApiToken do
  use Ecto.Migration
  alias StHub.Repo

  def up do
    execute "CREATE EXTENSION IF NOT EXISTS \"pgcrypto\";"

    alter table(:users) do
      add :api_token, :binary_id, default: fragment("gen_random_uuid()")
    end
  end

  def down do
    alter table(:users) do
      remove :api_token
    end
  end
end
