defmodule StHub.Repo.Migrations.AddUsersWowsInfo do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :last_testship_check, :naive_datetime
    end
  end
end
