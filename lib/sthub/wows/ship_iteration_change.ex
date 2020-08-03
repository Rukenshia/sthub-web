defmodule StHub.Wows.ShipIterationChange do
  use Ecto.Schema
  import Ecto.Changeset

  schema "wows_ship_iteration_changes" do
    belongs_to(:ship_iteration, StHub.Wows.ShipIteration)
    belongs_to(:parameter, StHub.Wows.ShipParameter)
    field :type, :string
    field :from, :string
    field :to, :string
    field :additional_info, :string
    field :full_change_text, :string

    # For live view usage
    field :temp_id, :integer, virtual: true

    timestamps()
  end

  @doc false
  def changeset(ship_iteration_change, attrs) do
    ship_iteration_change
    |> cast(attrs, [:parameter_id, :type, :from, :to, :additional_info, :full_change_text])
    |> validate_required([:parameter_id, :type, :full_change_text])
  end
end
