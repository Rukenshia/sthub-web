defmodule StHub.Release do
  @app :sthub

  import Ecto.Query, only: [from: 2]
  alias StHub.Repo
  require Logger

  def migrate do
    load_app()

    for repo <- repos() do
      {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :up, all: true))
    end
  end

  def seed do
    load_app()
    Application.ensure_all_started(@app)

    seed_ship_parameters()

    StHub.Wows.update_ship_database()

    _user =
      %StHub.UserManager.User{
        role: "administrator"
      }
      |> StHub.UserManager.User.changeset(%{
        "username" => "test",
        "password" => "test"
      })
      |> Repo.insert!()
  end

  def seed_ship_parameters() do
    import StHub.SeedHelper

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

      # Torpedoes
      ship_param("Torpedo Firing Range", "float", unit: "km"),
      ship_param("Torpedo Damage", "float"),
      ship_param("Torpedo Tubes Reload Time", "float", unit: "s"),

      # Manouverability
      ship_param("Rudder Shift Time", "float", unit: "s"),
      ship_param("Maximum Speed", "float", unit: "kts"),
      ship_param("Turning Circle Radius", "integer", unit: "m"),

      # Detectability
      ship_param("Air Concealment", "integer", unit: "m"),
      ship_param("Sea Concealment", "integer", unit: "m"),
      ship_param("Smoke Concealment After Firing", "integer", unit: "m"),

      # Consumables
      ship_param("Consumable Reloads", "integer", needs_additional_info: true),
      ship_param("Consumable Action Time", "integer", needs_additional_info: true),
      ship_param("Consumable (Other)", "string", needs_additional_info: true)
    ]
    |> Enum.each(&find_or_insert_ship_param/1)
  end

  defp find_or_insert_ship_param(param) do
    case from(p in StHub.Wows.ShipParameter, where: p.name == ^param.name) |> Repo.one() do
      nil ->
        Repo.insert!(param)

      _ ->
        Logger.debug("Skipping parameter #{param.name}, it already exists")
    end
  end

  def rollback(repo, version) do
    load_app()
    {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :down, to: version))
  end

  defp repos do
    Application.fetch_env!(@app, :ecto_repos)
  end

  defp load_app do
    Application.load(@app)
  end
end
