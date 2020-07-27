defmodule StHubWeb.ShipIterationController do
  use StHubWeb, :controller

  alias StHub.Wows
  alias StHub.Wows.ShipIteration

  def index(conn, _params) do
    wows_ship_iterations = Wows.list_wows_ship_iterations()
    render(conn, "index.html", wows_ship_iterations: wows_ship_iterations)
  end

  def new(conn, %{"ship_id" => ship_id}) do
    ship = Wows.get_ship!(ship_id)

    changeset =
      Wows.change_ship_iteration(%ShipIteration{
        ship_id: ship.id
      })

    render(conn, "new.html", changeset: changeset, ship: ship)
  end

  def new(conn, %{}) do
    changeset = Wows.change_ship_iteration(%ShipIteration{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"ship_iteration" => ship_iteration_params}) do
    case Wows.create_ship_iteration(ship_iteration_params) do
      {:ok, ship_iteration} ->
        conn
        |> put_flash(:info, "Ship iteration created successfully.")
        |> redirect(to: Routes.ship_iteration_path(conn, :show, ship_iteration))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"iteration_id" => id}) do
    ship_iteration = Wows.get_ship_iteration!(id)
    render(conn, "show.html", ship_iteration: ship_iteration)
  end

  def delete(conn, %{"id" => id}) do
    ship_iteration = Wows.get_ship_iteration!(id)
    {:ok, _ship_iteration} = Wows.delete_ship_iteration(ship_iteration)

    conn
    |> put_flash(:info, "Ship iteration deleted successfully.")
    |> redirect(to: Routes.ship_iteration_path(conn, :index))
  end
end
