defmodule StHub.Repo.Migrations.AddWowsShipIterationGameVersion do
  use Ecto.Migration

  def change do
    alter table(:wows_ship_iterations) do
      add :game_version, :string
    end
  end
end
