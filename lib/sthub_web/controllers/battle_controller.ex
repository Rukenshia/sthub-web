defmodule StHubWeb.BattleController do
  use StHubWeb, :controller

  alias StHub.Statistics
  alias StHub.Statistics.Battle

  action_fallback StHubWeb.FallbackController

  def index(conn, _params) do
    battles = Statistics.list_battles()
    render(conn, "index.json", battles: battles)
  end

  def create(conn, %{"battle" => battle_params}) do
    with {:ok, %Battle{} = battle} <- Statistics.create_battle(battle_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.battle_path(conn, :show, battle))
      |> render("show.json", battle: battle)
    end
  end

  def show(conn, %{"id" => id}) do
    battle = Statistics.get_battle!(id)
    render(conn, "show.json", battle: battle)
  end

  def update(conn, %{"id" => id, "battle" => battle_params}) do
    battle = Statistics.get_battle!(id)

    with {:ok, %Battle{} = battle} <- Statistics.update_battle(battle, battle_params) do
      render(conn, "show.json", battle: battle)
    end
  end

  def delete(conn, %{"id" => id}) do
    battle = Statistics.get_battle!(id)

    with {:ok, %Battle{}} <- Statistics.delete_battle(battle) do
      send_resp(conn, :no_content, "")
    end
  end
end
