defmodule StHub.Wows.ShipIteration do
  use Ecto.Schema
  import Ecto.Changeset

  schema "wows_ship_iterations" do
    field :iteration, :integer
    field :game_version, :string
    belongs_to :ship, StHub.Wows.Ship
    has_many :changes, StHub.Wows.ShipIterationChange

    timestamps()
  end

  def changeset(ship_iteration, attrs) do
    ship_iteration
    |> cast(attrs, [:game_version])
    |> cast_assoc(:changes, with: &StHub.Wows.ShipIterationChange.changeset/2)
    |> validate_required([:game_version])
  end
end
