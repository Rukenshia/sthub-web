defmodule StHub.Wows.Ship do
  use Ecto.Schema
  import Ecto.Changeset

  schema "wows_ships" do
    field :name, :string
    field :nation, :string
    field :tier, :integer
    field :type, :string

    # test ship info
    field :released, :boolean
    field :released_at, :naive_datetime
    field :credited_to_testers, :boolean

    # wows data dump from the api
    field :additional_data, :map

    timestamps()

    has_many(:iterations, StHub.Wows.ShipIteration)
  end

  @doc false
  def changeset(ship, attrs) do
    ship
    |> cast(attrs, [:name, :nation, :tier, :type, :released, :released_at, :credited_to_testers, :additional_data])
    |> validate_required([:name, :nation, :tier, :type, :additional_data])
  end
end
