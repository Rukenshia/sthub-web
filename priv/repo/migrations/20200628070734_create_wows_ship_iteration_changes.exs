defmodule StHub.Repo.Migrations.CreateWowsShipIterationChanges do
  use Ecto.Migration

  def change do
    create table(:wows_ship_iteration_changes) do
      add :ship_iteration_id, references(:wows_ship_iterations, on_delete: :nothing)
      add :parameter_id, references(:wows_ship_parameters)
      add :type, :string
      add :from, :string, null: true
      add :to, :string, null: true
      add :additional_info, :string, null: true
      add :full_change_text, :string

      timestamps()
    end

    create index(:wows_ship_iteration_changes, [:ship_iteration_id])
  end
end
