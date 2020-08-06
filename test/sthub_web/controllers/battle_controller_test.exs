defmodule StHubWeb.BattleControllerTest do
  use StHubWeb.ConnCase

  alias StHub.Statistics
  alias StHub.Statistics.Battle

  @create_attrs %{
    ammo_main_battery_ap_damage: 42,
    ammo_torpedo_damage: 42,
    ammo_secondary_ap_damage: 42,
    ammo_secondary_sap_hits: 42,
    ammo_secondary_he_shots: 42,
    ammo_secondary_ap_hits: 42,
    damage_flooding: 42,
    kills: 42,
    floods_caused: 42,
    ammo_torpedo_shots: 42,
    finished_at: "2010-04-17T14:00:00Z",
    ammo_main_battery_sap_hits: 42,
    ammo_secondary_ap_shots: 42,
    ammo_torpedo_hits: 42,
    ammo_secondary_he_damage: 42,
    winner_team_id: 42,
    ammo_plane_bomb_hits: 42,
    in_division: true,
    economics_credits: 42,
    planes_killed: 42,
    place_in_team: 42,
    status: "some status",
    damage_fire: 42,
    ammo_main_battery_sap_damage: 42,
    ammo_plane_bomb_shots: 42,
    damage_ramming: 42,
    ammo_main_battery_sap_shots: 42,
    has_results_screen: true,
    ammo_secondary_he_hits: 42,
    duration: 120.5,
    ammo_secondary_sap_damage: 42,
    ammo_plane_rocket_shots: 42,
    ammo_main_battery_ap_shots: 42,
    ammo_plane_rocket_damage: 42,
    lifetime: 120.5,
    ammo_secondary_sap_shots: 42,
    ammo_main_battery_he_hits: 42,
    started_at: "2010-04-17T14:00:00Z",
    ships_detected: 42,
    ammo_plane_bomb_damage: 42,
    ammo_main_battery_ap_hits: 42,
    ammo_main_battery_he_shots: 42,
    ammo_plane_rocket_hits: 42,
    survived: true,
    distance_covered: 120.5,
    battle_type: "some battle_type",
    economics_base_xp: 42,
    damage_sum: 42,
    team_id: 42,
    is_win: true,
    ammo_main_battery_he_damage: 42
  }
  @update_attrs %{
    ammo_main_battery_ap_damage: 43,
    ammo_torpedo_damage: 43,
    ammo_secondary_ap_damage: 43,
    ammo_secondary_sap_hits: 43,
    ammo_secondary_he_shots: 43,
    ammo_secondary_ap_hits: 43,
    damage_flooding: 43,
    kills: 43,
    floods_caused: 43,
    ammo_torpedo_shots: 43,
    finished_at: "2011-05-18T15:01:01Z",
    ammo_main_battery_sap_hits: 43,
    ammo_secondary_ap_shots: 43,
    ammo_torpedo_hits: 43,
    ammo_secondary_he_damage: 43,
    winner_team_id: 43,
    ammo_plane_bomb_hits: 43,
    in_division: false,
    economics_credits: 43,
    planes_killed: 43,
    place_in_team: 43,
    status: "some updated status",
    damage_fire: 43,
    ammo_main_battery_sap_damage: 43,
    ammo_plane_bomb_shots: 43,
    damage_ramming: 43,
    ammo_main_battery_sap_shots: 43,
    has_results_screen: false,
    ammo_secondary_he_hits: 43,
    duration: 456.7,
    ammo_secondary_sap_damage: 43,
    ammo_plane_rocket_shots: 43,
    ammo_main_battery_ap_shots: 43,
    ammo_plane_rocket_damage: 43,
    lifetime: 456.7,
    ammo_secondary_sap_shots: 43,
    ammo_main_battery_he_hits: 43,
    started_at: "2011-05-18T15:01:01Z",
    ships_detected: 43,
    ammo_plane_bomb_damage: 43,
    ammo_main_battery_ap_hits: 43,
    ammo_main_battery_he_shots: 43,
    ammo_plane_rocket_hits: 43,
    survived: false,
    distance_covered: 456.7,
    battle_type: "some updated battle_type",
    economics_base_xp: 43,
    damage_sum: 43,
    team_id: 43,
    is_win: false,
    ammo_main_battery_he_damage: 43
  }
  @invalid_attrs %{ammo_main_battery_he_damage: nil, is_win: nil, team_id: nil, damage_sum: nil, economics_base_xp: nil, battle_type: nil, distance_covered: nil, survived: nil, ammo_plane_rocket_hits: nil, ammo_main_battery_he_shots: nil, ammo_main_battery_ap_hits: nil, ammo_plane_bomb_damage: nil, ships_detected: nil, started_at: nil, ammo_main_battery_he_hits: nil, ammo_secondary_sap_shots: nil, lifetime: nil, ammo_plane_rocket_damage: nil, ammo_main_battery_ap_shots: nil, ammo_plane_rocket_shots: nil, ammo_secondary_sap_damage: nil, duration: nil, ammo_secondary_he_hits: nil, has_results_screen: nil, ammo_main_battery_sap_shots: nil, damage_ramming: nil, ammo_plane_bomb_shots: nil, ammo_main_battery_sap_damage: nil, damage_fire: nil, status: nil, place_in_team: nil, planes_killed: nil, economics_credits: nil, in_division: nil, ammo_plane_bomb_hits: nil, winner_team_id: nil, ammo_secondary_he_damage: nil, ammo_torpedo_hits: nil, ammo_secondary_ap_shots: nil, ammo_main_battery_sap_hits: nil, finished_at: nil, ammo_torpedo_shots: nil, floods_caused: nil, kills: nil, damage_flooding: nil, ammo_secondary_ap_hits: nil, ammo_secondary_he_shots: nil, ammo_secondary_sap_hits: nil, ammo_secondary_ap_damage: nil, ammo_torpedo_damage: nil, ...}

  def fixture(:battle) do
    {:ok, battle} = Statistics.create_battle(@create_attrs)
    battle
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all battles", %{conn: conn} do
      conn = get(conn, Routes.battle_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create battle" do
    test "renders battle when data is valid", %{conn: conn} do
      conn = post(conn, Routes.battle_path(conn, :create), battle: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.battle_path(conn, :show, id))

      assert %{
               "id" => id,
               "ammo_plane_rocket_damage" => 42,
               "ammo_secondary_sap_shots" => 42,
               "ammo_plane_bomb_damage" => 42,
               "battle_type" => "some battle_type",
               "damage_ramming" => 42,
               "duration" => 120.5,
               "ammo_main_battery_he_hits" => 42,
               "ammo_secondary_sap_damage" => 42,
               "in_division" => true,
               "ammo_main_battery_sap_hits" => 42,
               "ammo_plane_bomb_shots" => 42,
               "ammo_main_battery_ap_damage" => 42,
               "economics_base_xp" => 42,
               "ammo_main_battery_he_shots" => 42,
               "damage_fire" => 42,
               "ammo_main_battery_sap_damage" => 42,
               "status" => "some status",
               "ammo_main_battery_ap_shots" => 42,
               "economics_credits" => 42,
               "ammo_plane_bomb_hits" => 42,
               "floods_caused" => 42,
               "ammo_torpedo_damage" => 42,
               "damage_flooding" => 42,
               "ammo_main_battery_he_damage" => 42,
               "ammo_secondary_he_damage" => 42,
               "ships_detected" => 42,
               "ammo_main_battery_ap_hits" => 42,
               "ammo_secondary_ap_hits" => 42,
               "ammo_main_battery_sap_shots" => 42,
               "planes_killed" => 42,
               "lifetime" => 120.5,
               "ammo_torpedo_hits" => 42,
               "ammo_secondary_ap_damage" => 42,
               "has_results_screen" => true,
               "started_at" => "2010-04-17T14:00:00Z",
               "place_in_team" => 42,
               "ammo_plane_rocket_hits" => 42,
               "ammo_secondary_he_hits" => 42,
               "is_win" => true,
               "ammo_torpedo_shots" => 42,
               "distance_covered" => 120.5,
               "finished_at" => "2010-04-17T14:00:00Z",
               "survived" => true,
               "ammo_secondary_sap_hits" => 42,
               "ammo_secondary_he_shots" => 42,
               "ammo_plane_rocket_shots" => 42,
               "winner_team_id" => 42,
               "kills" => 42,
               "damage_sum" => 42,
               "team_id" => 42,
               "ammo_secondary_ap_shots" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.battle_path(conn, :create), battle: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update battle" do
    setup [:create_battle]

    test "renders battle when data is valid", %{conn: conn, battle: %Battle{id: id} = battle} do
      conn = put(conn, Routes.battle_path(conn, :update, battle), battle: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.battle_path(conn, :show, id))

      assert %{
               "id" => id,
               "ammo_plane_rocket_damage" => 43,
               "ammo_secondary_sap_shots" => 43,
               "ammo_plane_bomb_damage" => 43,
               "battle_type" => "some updated battle_type",
               "damage_ramming" => 43,
               "duration" => 456.7,
               "ammo_main_battery_he_hits" => 43,
               "ammo_secondary_sap_damage" => 43,
               "in_division" => false,
               "ammo_main_battery_sap_hits" => 43,
               "ammo_plane_bomb_shots" => 43,
               "ammo_main_battery_ap_damage" => 43,
               "economics_base_xp" => 43,
               "ammo_main_battery_he_shots" => 43,
               "damage_fire" => 43,
               "ammo_main_battery_sap_damage" => 43,
               "status" => "some updated status",
               "ammo_main_battery_ap_shots" => 43,
               "economics_credits" => 43,
               "ammo_plane_bomb_hits" => 43,
               "floods_caused" => 43,
               "ammo_torpedo_damage" => 43,
               "damage_flooding" => 43,
               "ammo_main_battery_he_damage" => 43,
               "ammo_secondary_he_damage" => 43,
               "ships_detected" => 43,
               "ammo_main_battery_ap_hits" => 43,
               "ammo_secondary_ap_hits" => 43,
               "ammo_main_battery_sap_shots" => 43,
               "planes_killed" => 43,
               "lifetime" => 456.7,
               "ammo_torpedo_hits" => 43,
               "ammo_secondary_ap_damage" => 43,
               "has_results_screen" => false,
               "started_at" => "2011-05-18T15:01:01Z",
               "place_in_team" => 43,
               "ammo_plane_rocket_hits" => 43,
               "ammo_secondary_he_hits" => 43,
               "is_win" => false,
               "ammo_torpedo_shots" => 43,
               "distance_covered" => 456.7,
               "finished_at" => "2011-05-18T15:01:01Z",
               "survived" => false,
               "ammo_secondary_sap_hits" => 43,
               "ammo_secondary_he_shots" => 43,
               "ammo_plane_rocket_shots" => 43,
               "winner_team_id" => 43,
               "kills" => 43,
               "damage_sum" => 43,
               "team_id" => 43,
               "ammo_secondary_ap_shots" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, battle: battle} do
      conn = put(conn, Routes.battle_path(conn, :update, battle), battle: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete battle" do
    setup [:create_battle]

    test "deletes chosen battle", %{conn: conn, battle: battle} do
      conn = delete(conn, Routes.battle_path(conn, :delete, battle))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.battle_path(conn, :show, battle))
      end
    end
  end

  defp create_battle(_) do
    battle = fixture(:battle)
    %{battle: battle}
  end
end
