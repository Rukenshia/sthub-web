defmodule StHub.Wows.ShipIteration do
  use Ecto.Schema
  import Ecto.Changeset

  schema "wows_ship_iterations" do
    field :active, :boolean, default: false
    field :iteration, :integer
    belongs_to :ship, StHub.Wows.Ship

    timestamps()
  end

  @doc false
  def changeset(ship_iteration, attrs) do
    ship_iteration
    |> cast(attrs, [:iteration, :active])
    |> cast_assoc(:ship)
    |> validate_required([:iteration, :active, :ship_id])
  end
end
