defmodule StHubWeb.BattleView do
  use StHubWeb, :view
  alias StHubWeb.BattleView

  def render("index.json", %{battles: battles}) do
    %{data: render_many(battles, BattleView, "battle.json")}
  end

  def render("show.json", %{battle: battle}) do
    %{data: render_one(battle, BattleView, "battle.json")}
  end

  def render("battle.json", %{battle: battle}) do
    %{id: battle.id,
      status: battle.status,
      started_at: battle.started_at,
      finished_at: battle.finished_at,
      has_results_screen: battle.has_results_screen,
      team_id: battle.team_id,
      winner_team_id: battle.winner_team_id,
      in_division: battle.in_division,
      battle_type: battle.battle_type,
      duration: battle.duration,
      place_in_team: battle.place_in_team,
      is_win: battle.is_win,
      survived: battle.survived,
      kills: battle.kills,
      damage_sum: battle.damage_sum,
      damage_fire: battle.damage_fire,
      damage_flooding: battle.damage_flooding,
      damage_ramming: battle.damage_ramming,
      floods_caused: battle.floods_caused,
      ships_detected: battle.ships_detected,
      lifetime: battle.lifetime,
      planes_killed: battle.planes_killed,
      distance_covered: battle.distance_covered,
      economics_credits: battle.economics_credits,
      economics_base_xp: battle.economics_base_xp,
      ammo_torpedo_damage: battle.ammo_torpedo_damage,
      ammo_plane_bomb_damage: battle.ammo_plane_bomb_damage,
      ammo_plane_rocket_damage: battle.ammo_plane_rocket_damage,
      ammo_main_battery_ap_damage: battle.ammo_main_battery_ap_damage,
      ammo_main_battery_sap_damage: battle.ammo_main_battery_sap_damage,
      ammo_main_battery_he_damage: battle.ammo_main_battery_he_damage,
      ammo_secondary_ap_damage: battle.ammo_secondary_ap_damage,
      ammo_secondary_sap_damage: battle.ammo_secondary_sap_damage,
      ammo_secondary_he_damage: battle.ammo_secondary_he_damage,
      ammo_torpedo_shots: battle.ammo_torpedo_shots,
      ammo_plane_bomb_shots: battle.ammo_plane_bomb_shots,
      ammo_plane_rocket_shots: battle.ammo_plane_rocket_shots,
      ammo_main_battery_ap_shots: battle.ammo_main_battery_ap_shots,
      ammo_main_battery_sap_shots: battle.ammo_main_battery_sap_shots,
      ammo_main_battery_he_shots: battle.ammo_main_battery_he_shots,
      ammo_secondary_ap_shots: battle.ammo_secondary_ap_shots,
      ammo_secondary_sap_shots: battle.ammo_secondary_sap_shots,
      ammo_secondary_he_shots: battle.ammo_secondary_he_shots,
      ammo_torpedo_hits: battle.ammo_torpedo_hits,
      ammo_plane_bomb_hits: battle.ammo_plane_bomb_hits,
      ammo_plane_rocket_hits: battle.ammo_plane_rocket_hits,
      ammo_main_battery_ap_hits: battle.ammo_main_battery_ap_hits,
      ammo_main_battery_sap_hits: battle.ammo_main_battery_sap_hits,
      ammo_main_battery_he_hits: battle.ammo_main_battery_he_hits,
      ammo_secondary_ap_hits: battle.ammo_secondary_ap_hits,
      ammo_secondary_sap_hits: battle.ammo_secondary_sap_hits,
      ammo_secondary_he_hits: battle.ammo_secondary_he_hits}
  end
end
