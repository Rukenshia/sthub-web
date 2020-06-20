defmodule StHubWeb.ShipIterationControllerTest do
  use StHubWeb.ConnCase

  alias StHub.Wows

  @create_attrs %{active: true, iteration: 42}
  @update_attrs %{active: false, iteration: 43}
  @invalid_attrs %{active: nil, iteration: nil}

  def fixture(:ship_iteration) do
    {:ok, ship_iteration} = Wows.create_ship_iteration(@create_attrs)
    ship_iteration
  end

  describe "index" do
    test "lists all wows_ship_iterations", %{conn: conn} do
      conn = get(conn, Routes.ship_iteration_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Wows ship iterations"
    end
  end

  describe "new ship_iteration" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.ship_iteration_path(conn, :new))
      assert html_response(conn, 200) =~ "New Ship iteration"
    end
  end

  describe "create ship_iteration" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.ship_iteration_path(conn, :create), ship_iteration: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.ship_iteration_path(conn, :show, id)

      conn = get(conn, Routes.ship_iteration_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Ship iteration"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.ship_iteration_path(conn, :create), ship_iteration: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Ship iteration"
    end
  end

  describe "edit ship_iteration" do
    setup [:create_ship_iteration]

    test "renders form for editing chosen ship_iteration", %{conn: conn, ship_iteration: ship_iteration} do
      conn = get(conn, Routes.ship_iteration_path(conn, :edit, ship_iteration))
      assert html_response(conn, 200) =~ "Edit Ship iteration"
    end
  end

  describe "update ship_iteration" do
    setup [:create_ship_iteration]

    test "redirects when data is valid", %{conn: conn, ship_iteration: ship_iteration} do
      conn = put(conn, Routes.ship_iteration_path(conn, :update, ship_iteration), ship_iteration: @update_attrs)
      assert redirected_to(conn) == Routes.ship_iteration_path(conn, :show, ship_iteration)

      conn = get(conn, Routes.ship_iteration_path(conn, :show, ship_iteration))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, ship_iteration: ship_iteration} do
      conn = put(conn, Routes.ship_iteration_path(conn, :update, ship_iteration), ship_iteration: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Ship iteration"
    end
  end

  describe "delete ship_iteration" do
    setup [:create_ship_iteration]

    test "deletes chosen ship_iteration", %{conn: conn, ship_iteration: ship_iteration} do
      conn = delete(conn, Routes.ship_iteration_path(conn, :delete, ship_iteration))
      assert redirected_to(conn) == Routes.ship_iteration_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.ship_iteration_path(conn, :show, ship_iteration))
      end
    end
  end

  defp create_ship_iteration(_) do
    ship_iteration = fixture(:ship_iteration)
    %{ship_iteration: ship_iteration}
  end
end
