defmodule StHub.SeedHelper do
  alias StHub.Wows.ShipParameter

  def ship_param(friendly_name, value_type, options \\ []) do
    default_options = [unit: nil, needs_additional_info: false]
    options = Keyword.merge(default_options, options) |> Enum.into(%{})
    %{unit: unit, needs_additional_info: needs_additional_info} = options

    %ShipParameter{
      name:
        friendly_name
        |> String.downcase()
        |> String.replace(~r/[^a-z0-9\-_\.]/, "_"),
      friendly_name: friendly_name,
      value_type: value_type,
      unit: unit,
      needs_additional_info: needs_additional_info
    }
  end
end
