# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     StHub.Repo.insert!(%StHub.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias StHub.Repo
alias StHub.Wows.ShipParameter

defmodule SeedHelper do

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
      needs_additional_info: needs_additional_info,
    }
  end

  def get_ship_parameters() do
    [
      # General
      ship_param("Other", "string", needs_additional_info: true),
      ship_param("Tier", "integer"),
      ship_param("Name", "string"),

      # Survivability
      ship_param("Health Pool", "integer"),

      ship_param("Bow Plating", "integer", unit: "mm"),
      ship_param("Stern Plating", "integer", unit: "mm"),
      ship_param("Deck Plating", "integer", unit: "mm"),
      ship_param("Armor Plating (Other)", "integer", unit: "mm"),

      ship_param("Fire Duration", "integer", unit: "s"),
      ship_param("Flooding Duration", "integer", unit: "s"),

      # CV Parameters
      ship_param("Attack Height", "more_less"),
      ship_param("Sight Alignment Time", "more_less"),
      ship_param("Attack Time Preparation", "float", unit: "s"),
      ship_param("Attack Time", "integer", unit: "s"),

      ship_param("AP Rocket Damage", "integer"),
      ship_param("AP Rocket Flight Time", "more_less"),
      ship_param("AP Rocket Ricochet Angle", "integer", unit: "°"),

      ship_param("HE Rocket Damage", "integer"),
      ship_param("HE Rocket Flight Time", "more_less"),

      ship_param("AP Bomb Damage", "integer"),
      ship_param("AP Bomb Flight Time", "more_less"),

      ship_param("HE Bomb Damage", "integer"),
      ship_param("HE Bomb Flight Time", "more_less"),

      # Anti Aircraft
      ship_param("Continous AA Damage", "integer"),
      ship_param("Short-range AA Damage", "integer"),
      ship_param("Medium-range AA Damage", "integer"),
      ship_param("Long-range AA Damage", "integer"),
      ship_param("Number of AA shell explosions", "integer"),

      # Main Armament
      ship_param("Main Battery Reload Time", "float", unit: "s"),
      ship_param("Turret Traverse Speed", "float", unit: "°/s"),

      ship_param("Sigma", "float"),
      ship_param("Maximum Dispersion", "integer", unit: "m"),

      ship_param("AP Shell Damage", "integer"),
      ship_param("AP Shell Velocity", "integer", unit: "m/s"),
      ship_param("AP Ricochet Angle", "integer", unit: "°"),

      ship_param("SAP Shell Damage", "integer"),
      ship_param("SAP Shell Velocity", "integer", unit: "m/s"),
      ship_param("SAP Ricochet Angle", "integer", unit: "°"),

      ship_param("HE Shell Damage", "integer"),
      ship_param("HE Shell Velocity", "integer", unit: "m/s"),
      ship_param("HE Shell Penetration", "integer", unit: "mm"),
      ship_param("HE Shell Fire Chance", "integer", unit: "%"),

      ship_param("Shell Balistics", "more_less"),

      # Secondary Armament
      ship_param("Secondary Firing Range", "float", unit: "km"),
      ship_param("Secondary Reload Time", "float", unit: "s"),
      ship_param("Secondary Battery Accuracy", "more_less"),

      # Manouverability
      ship_param("Rudder Shift Time", "float", unit: "s"),
      ship_param("Maximum Speed", "float", unit: "kts"),
      ship_param("Turning Circle Radius", "integer", unit: "m"),

      # Detectability
      ship_param("Air Concealment", "integer", unit: "m"),
      ship_param("Sea Concealment", "integer", unit: "m"),
      ship_param("Smoke Concealment After Firing", "integer", unit: "m"),

      # Consumables
      ship_param("Consumable Reloads", "number", needs_additional_info: true)
    ]
  end
end

SeedHelper.get_ship_parameters()
|> Enum.each(&Repo.insert!/1)

StHub.Wows.update_ship_database()
