defmodule StHub.Repo.Migrations.ChangeWowsShipIterationsOnDelete do
  use Ecto.Migration

  def change do
    execute "ALTER TABLE wows_ship_iteration_changes DROP CONSTRAINT wows_ship_iteration_changes_ship_iteration_id_fkey"

    execute "ALTER TABLE wows_ship_iteration_changes DROP CONSTRAINT wows_ship_iteration_changes_parameter_id_fkey"

    alter table(:wows_ship_iteration_changes) do
      modify(:ship_iteration_id, references(:wows_ship_iterations, on_delete: :delete_all))
      modify(:parameter_id, references(:wows_ship_parameters, on_delete: :delete_all))
    end
  end
end
