defmodule StHub.Repo.Migrations.RemoveWowsShipIterationActiveFlag do
  use Ecto.Migration

  def change do
    alter table(:wows_ship_iterations) do
      remove :active
    end
  end
end
