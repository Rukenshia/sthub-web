defmodule StHubWeb.ShipIterationController do
  use StHubWeb, :controller

  alias StHub.Wows
  alias StHub.Wows.ShipIteration
  alias StHub.Repo

  def new(conn, %{"ship_id" => ship_id}) do
    user_id =
      case Guardian.Plug.current_resource(conn) do
        nil ->
          nil

        user ->
          user.id
      end

    ship = Wows.get_ship!(ship_id)

    changeset =
      Wows.change_ship_iteration(%ShipIteration{
        ship_id: ship.id
      })

    render(conn, "new.html", changeset: changeset, ship: ship, current_user_id: user_id)
  end

  def create(conn, %{"ship_iteration" => ship_iteration_params}) do
    case Wows.create_ship_iteration(ship_iteration_params) do
      {:ok, ship_iteration} ->
        conn
        |> put_flash(:info, "Ship iteration created successfully.")
        |> redirect(to: Routes.ship_iteration_path(conn, :show, ship_iteration.id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"iteration_id" => id}) do
    user_id =
      case Guardian.Plug.current_resource(conn) do
        nil ->
          nil

        user ->
          user.id
      end

    ship_iteration =
      Wows.get_ship_iteration!(id)
      |> Repo.preload(:ship)

    render(conn, "show.html", ship_iteration: ship_iteration, current_user_id: user_id)
  end
end
