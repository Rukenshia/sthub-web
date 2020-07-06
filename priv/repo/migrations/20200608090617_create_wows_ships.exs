defmodule StHub.Repo.Migrations.CreateWowsShips do
  use Ecto.Migration

  def change do
    create table(:wows_ships, primary_key: false) do
      add :id, :bigint, primary_key: true
      add :name, :string
      add :nation, :string
      add :tier, :integer
      add :type, :string

      # test ship data
      add :released, :boolean
      add :released_at, :naive_datetime
      add :credited_to_testers, :boolean

      # wows api data
      add :additional_data, :map

      timestamps()
    end
  end
end
