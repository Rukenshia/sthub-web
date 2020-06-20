defmodule StHub.Wows.Ship do
  use Ecto.Schema
  import Ecto.Changeset

  schema "wows_ships" do
    field :additional_data, :map
    field :name, :string
    field :nation, :string
    field :tier, :integer
    field :type, :string

    timestamps()

    has_many(:iterations, StHub.Wows.ShipIteration)
  end

  @doc false
  def changeset(ship, attrs) do
    ship
    |> cast(attrs, [:name, :nation, :tier, :type, :additional_data])
    |> validate_required([:name, :nation, :tier, :type, :additional_data])
  end
end
