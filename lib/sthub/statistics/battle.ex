defmodule StHub.Statistics.Battle do
  use Ecto.Schema
  import Ecto.Changeset

  schema "battles" do
    # general info
    belongs_to(:user, StHub.UserManager.User)
    belongs_to(:ship, StHub.Wows.Ship)
    field :status, :string
    field :has_results_screen, :boolean, default: false
    field :in_division, :boolean, default: false
    field :is_win, :boolean, default: false
    field :survived, :boolean, default: false

    # team info
    field :team_id, :integer
    field :winner_team_id, :integer
    field :place_in_team, :integer

    # timing info
    field :finished_at, :utc_datetime
    field :started_at, :utc_datetime

    # more general stats
    field :duration, :float
    field :lifetime, :float
    field :ships_detected, :integer
    field :distance_covered, :float
    field :battle_type, :string

    # economics
    field :economics_credits, :integer
    field :economics_base_xp, :integer

    # damage
    field :kills, :integer
    field :damage_sum, :integer
    field :damage_flooding, :integer
    field :damage_fire, :integer
    field :damage_ramming, :integer
    field :floods_caused, :integer
    field :planes_killed, :integer

    # stats for ammunition types
    field :ammo_main_battery_ap_damage, :integer
    field :ammo_torpedo_damage, :integer
    field :ammo_secondary_ap_damage, :integer
    field :ammo_secondary_sap_hits, :integer
    field :ammo_secondary_he_shots, :integer
    field :ammo_secondary_ap_hits, :integer
    field :ammo_main_battery_sap_hits, :integer
    field :ammo_secondary_ap_shots, :integer
    field :ammo_torpedo_hits, :integer
    field :ammo_secondary_he_damage, :integer
    field :ammo_plane_bomb_hits, :integer
    field :ammo_secondary_sap_damage, :integer
    field :ammo_plane_rocket_shots, :integer
    field :ammo_main_battery_ap_shots, :integer
    field :ammo_plane_rocket_damage, :integer
    field :ammo_main_battery_sap_damage, :integer
    field :ammo_plane_bomb_shots, :integer
    field :ammo_main_battery_sap_shots, :integer
    field :ammo_plane_bomb_damage, :integer
    field :ammo_main_battery_ap_hits, :integer
    field :ammo_main_battery_he_shots, :integer
    field :ammo_plane_rocket_hits, :integer
    field :ammo_torpedo_shots, :integer
    field :ammo_secondary_he_hits, :integer
    field :ammo_secondary_sap_shots, :integer
    field :ammo_main_battery_he_hits, :integer
    field :ammo_main_battery_he_damage, :integer

    timestamps()
  end

  @doc false
  def changeset(battle, attrs) do
    battle
    |> cast(attrs, [
      :status,
      :started_at,
      :finished_at,
      :has_results_screen,
      :team_id,
      :winner_team_id,
      :in_division,
      :battle_type,
      :duration,
      :place_in_team,
      :is_win,
      :survived,
      :kills,
      :damage_sum,
      :damage_fire,
      :damage_flooding,
      :damage_ramming,
      :floods_caused,
      :ships_detected,
      :lifetime,
      :planes_killed,
      :distance_covered,
      :economics_credits,
      :economics_base_xp,
      :ammo_torpedo_damage,
      :ammo_plane_bomb_damage,
      :ammo_plane_rocket_damage,
      :ammo_main_battery_ap_damage,
      :ammo_main_battery_sap_damage,
      :ammo_main_battery_he_damage,
      :ammo_secondary_ap_damage,
      :ammo_secondary_sap_damage,
      :ammo_secondary_he_damage,
      :ammo_torpedo_shots,
      :ammo_plane_bomb_shots,
      :ammo_plane_rocket_shots,
      :ammo_main_battery_ap_shots,
      :ammo_main_battery_sap_shots,
      :ammo_main_battery_he_shots,
      :ammo_secondary_ap_shots,
      :ammo_secondary_sap_shots,
      :ammo_secondary_he_shots,
      :ammo_torpedo_hits,
      :ammo_plane_bomb_hits,
      :ammo_plane_rocket_hits,
      :ammo_main_battery_ap_hits,
      :ammo_main_battery_sap_hits,
      :ammo_main_battery_he_hits,
      :ammo_secondary_ap_hits,
      :ammo_secondary_sap_hits,
      :ammo_secondary_he_hits
    ])
    |> validate_required([
      :started_at,
      :finished_at,
      :status,
      :has_results_screen,
      :in_division
    ])
  end
end
