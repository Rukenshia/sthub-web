defmodule StHub.Repo.Migrations.CreateShipParameters do
  use Ecto.Migration

  def change do
    create table(:wows_ship_parameters) do
      add :name, :string
      add :friendly_name, :string
      add :value_type, :string
      add :unit, :string, null: true
      add :needs_additional_info, :boolean

      timestamps()
    end
  end
end
