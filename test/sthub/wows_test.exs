defmodule StHub.WowsTest do
  use StHub.DataCase

  alias StHub.Wows

  describe "wows_ship_iterations" do
    alias StHub.Wows.ShipIteration
    alias StHub.Wows.ShipParameter

    alias StHub.Repo

    @valid_attrs %{active: true}
    @create_attrs_change %{
      active: true,
      changes: [
        %{
          "parameter_id" => 1,
          "full_change_text" => "A change"
        }
      ]
    }
    @update_attrs %{active: false}
    @update_attrs_changes %{
      changes: [
        %{
          "parameter_id" => 1,
          "full_change_text" => "A change"
        }
      ]
    }
    @invalid_attrs %{active: nil, iteration: nil}

    def ship_iteration_fixture(attrs \\ %{}) do
      {:ok, ship_iteration} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Wows.create_ship_iteration()

      ship_iteration
    end

    def ship_parameter_fixture() do
      {:ok, ship_parameter} =
        %ShipParameter{
          id: 1,
          name: "test",
          friendly_name: "Test",
          needs_additional_info: false,
          unit: "m/s",
          value_type: "number"
        }
        |> Repo.insert()

      ship_parameter
    end

    test "list_wows_ship_iterations/0 returns all wows_ship_iterations" do
      ship_iteration = ship_iteration_fixture()
      assert Wows.list_wows_ship_iterations() == [ship_iteration]
    end

    test "get_ship_iteration!/1 returns the ship_iteration with given id" do
      ship_iteration = ship_iteration_fixture()
      assert Wows.get_ship_iteration!(ship_iteration.id) == ship_iteration
    end

    test "create_ship_iteration/1 with valid data creates a ship_iteration" do
      assert {:ok, %ShipIteration{} = ship_iteration} = Wows.create_ship_iteration(@valid_attrs)
      assert ship_iteration.active == true
    end

    test "create_ship_iteration/1 with embedded change data creates a ship_iteration" do
      ship_parameter = ship_parameter_fixture()

      assert {:ok, %ShipIteration{} = ship_iteration} =
               Wows.create_ship_iteration(@create_attrs_change)

      ship_iteration =
        ship_iteration
        |> Repo.preload(:changes)

      assert ship_iteration.active == true
      assert ship_iteration.changes |> length() == 1

      assert ship_iteration.changes
             |> Enum.at(0)
             |> Repo.preload(:parameter)
             |> Map.get(:parameter) == ship_parameter
    end

    test "create_ship_iteration/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Wows.create_ship_iteration(@invalid_attrs)
    end

    test "update_ship_iteration/2 with valid data updates the ship_iteration" do
      ship_iteration = ship_iteration_fixture()

      assert {:ok, %ShipIteration{} = ship_iteration} =
               Wows.update_ship_iteration(ship_iteration, @update_attrs)

      assert ship_iteration.active == false
    end

    test "update_ship_iteration/2 with invalid data returns error changeset" do
      ship_iteration = ship_iteration_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Wows.update_ship_iteration(ship_iteration, @invalid_attrs)

      assert ship_iteration == Wows.get_ship_iteration!(ship_iteration.id)
    end

    test "update_ship_iteration/2 with an embedded change updates the ship_iteration" do
      ship_iteration =
        ship_iteration_fixture()
        |> Repo.preload(:changes)

      _ship_parameter = ship_parameter_fixture()

      assert {:ok, %ShipIteration{} = ship_iteration} =
               Wows.update_ship_iteration(ship_iteration, @update_attrs_changes)

      ship_iteration = Repo.preload(ship_iteration, :changes)

      assert ship_iteration.changes |> length() == 1
    end

    test "delete_ship_iteration/1 deletes the ship_iteration" do
      ship_iteration = ship_iteration_fixture()
      assert {:ok, %ShipIteration{}} = Wows.delete_ship_iteration(ship_iteration)
      assert_raise Ecto.NoResultsError, fn -> Wows.get_ship_iteration!(ship_iteration.id) end
    end

    test "change_ship_iteration/1 returns a ship_iteration changeset" do
      ship_iteration = ship_iteration_fixture()
      assert %Ecto.Changeset{} = Wows.change_ship_iteration(ship_iteration)
    end
  end
end
