defmodule StHub.Repo.Migrations.AddBattlesShipIterationId do
  use Ecto.Migration

  def change do
    alter table(:battles) do
      add :ship_iteration_id, references(:wows_ship_iterations, on_delete: :delete_all)
    end

    create index(:battles, [:ship_iteration_id])
  end
end
