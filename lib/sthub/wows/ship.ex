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
    |> cast(attrs, [
      :name,
      :nation,
      :tier,
      :type,
      :released,
      :released_at,
      :credited_to_testers,
      :additional_data
    ])
    |> validate_required([:name, :nation, :tier, :type, :additional_data])
  end

  def tier_name(ship) do
    case ship.additional_data["tier"] do
      1 -> "I"
      2 -> "II"
      3 -> "III"
      4 -> "IV"
      5 -> "V"
      6 -> "VI"
      7 -> "VII"
      8 -> "VIII"
      9 -> "IX"
      10 -> "X"
      _ -> "?"
    end
  end

  def nation_name(ship) do
    case ship.additional_data["nation"] do
      "ussr" -> "USSR"
      "germany" -> "German"
      "usa" -> "U.S."
      "europe" -> "European"
      "japan" -> "Japanese"
      v -> v
    end
  end

  def class_name(ship) do
    case ship.additional_data["type"] do
      "AirCarrier" -> "CV"
      v -> v
    end
  end
end
