defmodule StHub.Wows.ShipParameter do
  use Ecto.Schema
  import Ecto.Changeset

  schema "wows_ship_parameters" do
    field :friendly_name, :string
    field :name, :string
    field :value_type, :string
    field :unit, :string
    field :needs_additional_info, :boolean

    timestamps()
  end

  @doc false
  def changeset(ship_parameter, attrs) do
    ship_parameter
    |> cast(attrs, [:name, :friendly_name, :value_type, :unit, :needs_additional_info])
    |> validate_required([:name, :friendly_name, :value_type, :needs_additional_info])
  end
end
