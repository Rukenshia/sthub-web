defmodule StHub.StatisticsTest do
  use StHub.DataCase

  alias StHub.Statistics

  describe "battles" do
    alias StHub.Statistics.Battle

    @valid_attrs %{ammo_main_battery_he_damage: 42, is_win: true, team_id: 42, damage_sum: 42, economics_base_xp: 42, battle_type: "some battle_type", distance_covered: 120.5, survived: true, ammo_plane_rocket_hits: 42, ammo_main_battery_he_shots: 42, ammo_main_battery_ap_hits: 42, ammo_plane_bomb_damage: 42, ships_detected: 42, started_at: "2010-04-17T14:00:00Z", ammo_main_battery_he_hits: 42, ammo_secondary_sap_shots: 42, lifetime: 120.5, ammo_plane_rocket_damage: 42, ammo_main_battery_ap_shots: 42, ammo_plane_rocket_shots: 42, ammo_secondary_sap_damage: 42, duration: 120.5, ammo_secondary_he_hits: 42, has_results_screen: true, ammo_main_battery_sap_shots: 42, damage_ramming: 42, ammo_plane_bomb_shots: 42, ammo_main_battery_sap_damage: 42, damage_fire: 42, status: "some status", place_in_team: 42, planes_killed: 42, economics_credits: 42, in_division: true, ammo_plane_bomb_hits: 42, winner_team_id: 42, ammo_secondary_he_damage: 42, ammo_torpedo_hits: 42, ammo_secondary_ap_shots: 42, ammo_main_battery_sap_hits: 42, finished_at: "2010-04-17T14:00:00Z", ammo_torpedo_shots: 42, floods_caused: 42, kills: 42, damage_flooding: 42, ammo_secondary_ap_hits: 42, ammo_secondary_he_shots: 42, ammo_secondary_sap_hits: 42, ammo_secondary_ap_damage: 42, ammo_torpedo_damage: 42, ...}
    @update_attrs %{ammo_main_battery_he_damage: 43, is_win: false, team_id: 43, damage_sum: 43, economics_base_xp: 43, battle_type: "some updated battle_type", distance_covered: 456.7, survived: false, ammo_plane_rocket_hits: 43, ammo_main_battery_he_shots: 43, ammo_main_battery_ap_hits: 43, ammo_plane_bomb_damage: 43, ships_detected: 43, started_at: "2011-05-18T15:01:01Z", ammo_main_battery_he_hits: 43, ammo_secondary_sap_shots: 43, lifetime: 456.7, ammo_plane_rocket_damage: 43, ammo_main_battery_ap_shots: 43, ammo_plane_rocket_shots: 43, ammo_secondary_sap_damage: 43, duration: 456.7, ammo_secondary_he_hits: 43, has_results_screen: false, ammo_main_battery_sap_shots: 43, damage_ramming: 43, ammo_plane_bomb_shots: 43, ammo_main_battery_sap_damage: 43, damage_fire: 43, status: "some updated status", place_in_team: 43, planes_killed: 43, economics_credits: 43, in_division: false, ammo_plane_bomb_hits: 43, winner_team_id: 43, ammo_secondary_he_damage: 43, ammo_torpedo_hits: 43, ammo_secondary_ap_shots: 43, ammo_main_battery_sap_hits: 43, finished_at: "2011-05-18T15:01:01Z", ammo_torpedo_shots: 43, floods_caused: 43, kills: 43, damage_flooding: 43, ammo_secondary_ap_hits: 43, ammo_secondary_he_shots: 43, ammo_secondary_sap_hits: 43, ammo_secondary_ap_damage: 43, ammo_torpedo_damage: 43, ...}
    @invalid_attrs %{ammo_main_battery_he_damage: nil, is_win: nil, team_id: nil, damage_sum: nil, economics_base_xp: nil, battle_type: nil, distance_covered: nil, survived: nil, ammo_plane_rocket_hits: nil, ammo_main_battery_he_shots: nil, ammo_main_battery_ap_hits: nil, ammo_plane_bomb_damage: nil, ships_detected: nil, started_at: nil, ammo_main_battery_he_hits: nil, ammo_secondary_sap_shots: nil, lifetime: nil, ammo_plane_rocket_damage: nil, ammo_main_battery_ap_shots: nil, ammo_plane_rocket_shots: nil, ammo_secondary_sap_damage: nil, duration: nil, ammo_secondary_he_hits: nil, has_results_screen: nil, ammo_main_battery_sap_shots: nil, damage_ramming: nil, ammo_plane_bomb_shots: nil, ammo_main_battery_sap_damage: nil, damage_fire: nil, status: nil, place_in_team: nil, planes_killed: nil, economics_credits: nil, in_division: nil, ammo_plane_bomb_hits: nil, winner_team_id: nil, ammo_secondary_he_damage: nil, ammo_torpedo_hits: nil, ammo_secondary_ap_shots: nil, ammo_main_battery_sap_hits: nil, finished_at: nil, ammo_torpedo_shots: nil, floods_caused: nil, kills: nil, damage_flooding: nil, ammo_secondary_ap_hits: nil, ammo_secondary_he_shots: nil, ammo_secondary_sap_hits: nil, ammo_secondary_ap_damage: nil, ammo_torpedo_damage: nil, ...}

    def battle_fixture(attrs \\ %{}) do
      {:ok, battle} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Statistics.create_battle()

      battle
    end

    test "list_battles/0 returns all battles" do
      battle = battle_fixture()
      assert Statistics.list_battles() == [battle]
    end

    test "get_battle!/1 returns the battle with given id" do
      battle = battle_fixture()
      assert Statistics.get_battle!(battle.id) == battle
    end

    test "create_battle/1 with valid data creates a battle" do
      assert {:ok, %Battle{} = battle} = Statistics.create_battle(@valid_attrs)
      assert battle.ammo_main_battery_ap_damage == 42
      assert battle.ammo_torpedo_damage == 42
      assert battle.ammo_secondary_ap_damage == 42
      assert battle.ammo_secondary_sap_hits == 42
      assert battle.ammo_secondary_he_shots == 42
      assert battle.ammo_secondary_ap_hits == 42
      assert battle.damage_flooding == 42
      assert battle.kills == 42
      assert battle.floods_caused == 42
      assert battle.ammo_torpedo_shots == 42
      assert battle.finished_at == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert battle.ammo_main_battery_sap_hits == 42
      assert battle.ammo_secondary_ap_shots == 42
      assert battle.ammo_torpedo_hits == 42
      assert battle.ammo_secondary_he_damage == 42
      assert battle.winner_team_id == 42
      assert battle.ammo_plane_bomb_hits == 42
      assert battle.in_division == true
      assert battle.economics_credits == 42
      assert battle.planes_killed == 42
      assert battle.place_in_team == 42
      assert battle.status == "some status"
      assert battle.damage_fire == 42
      assert battle.ammo_main_battery_sap_damage == 42
      assert battle.ammo_plane_bomb_shots == 42
      assert battle.damage_ramming == 42
      assert battle.ammo_main_battery_sap_shots == 42
      assert battle.has_results_screen == true
      assert battle.ammo_secondary_he_hits == 42
      assert battle.duration == 120.5
      assert battle.ammo_secondary_sap_damage == 42
      assert battle.ammo_plane_rocket_shots == 42
      assert battle.ammo_main_battery_ap_shots == 42
      assert battle.ammo_plane_rocket_damage == 42
      assert battle.lifetime == 120.5
      assert battle.ammo_secondary_sap_shots == 42
      assert battle.ammo_main_battery_he_hits == 42
      assert battle.started_at == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert battle.ships_detected == 42
      assert battle.ammo_plane_bomb_damage == 42
      assert battle.ammo_main_battery_ap_hits == 42
      assert battle.ammo_main_battery_he_shots == 42
      assert battle.ammo_plane_rocket_hits == 42
      assert battle.survived == true
      assert battle.distance_covered == 120.5
      assert battle.battle_type == "some battle_type"
      assert battle.economics_base_xp == 42
      assert battle.damage_sum == 42
      assert battle.team_id == 42
      assert battle.is_win == true
      assert battle.ammo_main_battery_he_damage == 42
    end

    test "create_battle/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Statistics.create_battle(@invalid_attrs)
    end

    test "update_battle/2 with valid data updates the battle" do
      battle = battle_fixture()
      assert {:ok, %Battle{} = battle} = Statistics.update_battle(battle, @update_attrs)
      assert battle.ammo_main_battery_ap_damage == 43
      assert battle.ammo_torpedo_damage == 43
      assert battle.ammo_secondary_ap_damage == 43
      assert battle.ammo_secondary_sap_hits == 43
      assert battle.ammo_secondary_he_shots == 43
      assert battle.ammo_secondary_ap_hits == 43
      assert battle.damage_flooding == 43
      assert battle.kills == 43
      assert battle.floods_caused == 43
      assert battle.ammo_torpedo_shots == 43
      assert battle.finished_at == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert battle.ammo_main_battery_sap_hits == 43
      assert battle.ammo_secondary_ap_shots == 43
      assert battle.ammo_torpedo_hits == 43
      assert battle.ammo_secondary_he_damage == 43
      assert battle.winner_team_id == 43
      assert battle.ammo_plane_bomb_hits == 43
      assert battle.in_division == false
      assert battle.economics_credits == 43
      assert battle.planes_killed == 43
      assert battle.place_in_team == 43
      assert battle.status == "some updated status"
      assert battle.damage_fire == 43
      assert battle.ammo_main_battery_sap_damage == 43
      assert battle.ammo_plane_bomb_shots == 43
      assert battle.damage_ramming == 43
      assert battle.ammo_main_battery_sap_shots == 43
      assert battle.has_results_screen == false
      assert battle.ammo_secondary_he_hits == 43
      assert battle.duration == 456.7
      assert battle.ammo_secondary_sap_damage == 43
      assert battle.ammo_plane_rocket_shots == 43
      assert battle.ammo_main_battery_ap_shots == 43
      assert battle.ammo_plane_rocket_damage == 43
      assert battle.lifetime == 456.7
      assert battle.ammo_secondary_sap_shots == 43
      assert battle.ammo_main_battery_he_hits == 43
      assert battle.started_at == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert battle.ships_detected == 43
      assert battle.ammo_plane_bomb_damage == 43
      assert battle.ammo_main_battery_ap_hits == 43
      assert battle.ammo_main_battery_he_shots == 43
      assert battle.ammo_plane_rocket_hits == 43
      assert battle.survived == false
      assert battle.distance_covered == 456.7
      assert battle.battle_type == "some updated battle_type"
      assert battle.economics_base_xp == 43
      assert battle.damage_sum == 43
      assert battle.team_id == 43
      assert battle.is_win == false
      assert battle.ammo_main_battery_he_damage == 43
    end

    test "update_battle/2 with invalid data returns error changeset" do
      battle = battle_fixture()
      assert {:error, %Ecto.Changeset{}} = Statistics.update_battle(battle, @invalid_attrs)
      assert battle == Statistics.get_battle!(battle.id)
    end

    test "delete_battle/1 deletes the battle" do
      battle = battle_fixture()
      assert {:ok, %Battle{}} = Statistics.delete_battle(battle)
      assert_raise Ecto.NoResultsError, fn -> Statistics.get_battle!(battle.id) end
    end

    test "change_battle/1 returns a battle changeset" do
      battle = battle_fixture()
      assert %Ecto.Changeset{} = Statistics.change_battle(battle)
    end
  end
end
