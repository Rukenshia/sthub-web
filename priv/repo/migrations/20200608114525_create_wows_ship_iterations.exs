defmodule StHub.Repo.Migrations.CreateWowsShipIterations do
  use Ecto.Migration

  def change do
    create table(:wows_ship_iterations) do
      add :iteration, :integer
      add :active, :boolean, default: false, null: false
      add :ship_id, references(:wows_ships, on_delete: :nothing)

      timestamps()
    end

    create index(:wows_ship_iterations, [:ship_id])
  end
end
