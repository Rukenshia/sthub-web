defmodule StHub.Repo.Migrations.CreateWowsShips do
  use Ecto.Migration

  def change do
    create table(:wows_ships, primary_key: false) do
      add :id, :bigint, primary_key: true
      add :name, :string
      add :nation, :string
      add :tier, :integer
      add :type, :string
      add :additional_data, :map

      timestamps()
    end
  end
end
