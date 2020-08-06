defmodule StHubWeb.ShipLive do
  require Logger
  use Phoenix.LiveView
  use Phoenix.HTML

  alias StHub.Repo
  alias StHubWeb.Router.Helpers, as: Routes

  alias StHub.Wows
  alias StHub.Wows.Ship

  def mount(_, %{"ship_id" => ship_id, "user_id" => user_id}, socket) do
    user =
      case user_id do
        nil ->
          nil

        id ->
          StHub.UserManager.get_user!(id)
      end

    {:ok,
     socket
     |> assign(:current_user, user)
     |> assign(
       :ship,
       Wows.get_ship!(ship_id) |> Repo.preload(iterations: [changes: [:parameter]])
     )}
  end

  def handle_event("update_status", %{"ship_status" => ship_status}, socket) do
    params =
      case ship_status do
        "released" ->
          %{
            "credited_to_testers" => false,
            "released" => true,
            "released_at" => NaiveDateTime.utc_now()
          }

        "unreleased" ->
          %{"credited_to_testers" => false, "released" => false, "released_at" => nil}

        "credited" ->
          %{"credited_to_testers" => true, "released" => false, "released_at" => nil}
      end

    ship =
      socket.assigns[:ship]
      |> Ship.changeset(params)
      |> Repo.update!()

    {:noreply, socket |> assign(:ship, ship)}
  end

  def user_can_change_status(%StHub.UserManager.User{role: role}) do
    case role do
      "administrator" ->
        true

      "contributor" ->
        true

      _ ->
        false
    end
  end

  def user_can_change_status(_) do
    false
  end

  def user_can_create_iteration(%StHub.UserManager.User{role: role}) do
    case role do
      "administrator" ->
        true

      "contributor" ->
        true

      _ ->
        false
    end
  end

  def user_can_create_iteration(_) do
    false
  end

  def user_can_update_iteration(%StHub.UserManager.User{role: role}) do
    case role do
      "administrator" ->
        true

      "contributor" ->
        true

      _ ->
        false
    end
  end

  def user_can_update_iteration(_) do
    false
  end

  def user_can_view_ship_statistics(%StHub.UserManager.User{role: role}) do
    case role do
      "administrator" ->
        true

      "contributor" ->
        true

      "tester" ->
        true

      _ ->
        false
    end
  end

  def user_can_view_ship_statistics(_) do
    false
  end

  def change_dot_color(change) do
    case change.type do
      "buff" ->
        "bg-green-400"

      "nerf" ->
        "bg-red-400"

      _ ->
        "bg-gray-200"
    end
  end

  def ship_status_text(ship) do
    cond do
      ship.released ->
        "released"

      ship.credited_to_testers ->
        "credited to testers"

      !ship.released && !ship.credited_to_testers ->
        "in development"
    end
  end
end
