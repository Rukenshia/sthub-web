defmodule StHub.Repo.Migrations.CreateBattles do
  use Ecto.Migration

  def change do
    create table(:battles) do
      add :status, :string
      add :started_at, :utc_datetime
      add :finished_at, :utc_datetime
      add :has_results_screen, :boolean, default: false, null: false
      add :team_id, :integer
      add :winner_team_id, :integer
      add :in_division, :boolean, default: false, null: false
      add :battle_type, :string
      add :duration, :float
      add :place_in_team, :integer
      add :is_win, :boolean, default: false, null: false
      add :survived, :boolean, default: false, null: false
      add :kills, :integer
      add :damage_sum, :integer
      add :damage_fire, :integer
      add :damage_flooding, :integer
      add :damage_ramming, :integer
      add :floods_caused, :integer
      add :ships_detected, :integer
      add :lifetime, :float
      add :planes_killed, :integer
      add :distance_covered, :float
      add :economics_credits, :integer
      add :economics_base_xp, :integer
      add :ammo_torpedo_damage, :integer
      add :ammo_plane_bomb_damage, :integer
      add :ammo_plane_rocket_damage, :integer
      add :ammo_main_battery_ap_damage, :integer
      add :ammo_main_battery_sap_damage, :integer
      add :ammo_main_battery_he_damage, :integer
      add :ammo_secondary_ap_damage, :integer
      add :ammo_secondary_sap_damage, :integer
      add :ammo_secondary_he_damage, :integer
      add :ammo_torpedo_shots, :integer
      add :ammo_plane_bomb_shots, :integer
      add :ammo_plane_rocket_shots, :integer
      add :ammo_main_battery_ap_shots, :integer
      add :ammo_main_battery_sap_shots, :integer
      add :ammo_main_battery_he_shots, :integer
      add :ammo_secondary_ap_shots, :integer
      add :ammo_secondary_sap_shots, :integer
      add :ammo_secondary_he_shots, :integer
      add :ammo_torpedo_hits, :integer
      add :ammo_plane_bomb_hits, :integer
      add :ammo_plane_rocket_hits, :integer
      add :ammo_main_battery_ap_hits, :integer
      add :ammo_main_battery_sap_hits, :integer
      add :ammo_main_battery_he_hits, :integer
      add :ammo_secondary_ap_hits, :integer
      add :ammo_secondary_sap_hits, :integer
      add :ammo_secondary_he_hits, :integer
      add :user_id, references(:users, on_delete: :delete_all)
      add :ship_id, references(:wows_ships, on_delete: :delete_all)

      timestamps()
    end

    create index(:battles, [:user_id])
    create index(:battles, [:ship_id])
  end
end
