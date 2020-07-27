defmodule StHubWeb.ShipIterationLive do
  require Logger
  use Phoenix.LiveView
  use Phoenix.HTML
  import StHubWeb.ErrorHelpers

  alias StHub.Repo
  alias StHubWeb.Router.Helpers, as: Routes

  alias StHub.Wows
  alias StHub.Wows.ShipParameter
  alias StHub.Wows.ShipIteration
  alias StHub.Wows.ShipIterationChange

  def mount(_, %{"ship_id" => _ship_id, "iteration_id" => iteration_id}, socket) do
    ship_iteration =
      StHub.Wows.get_ship_iteration!(iteration_id)
      |> Repo.preload(:ship)
      |> Repo.preload(changes: [:parameter])

    {:ok,
     socket
     |> assign(:ship_iteration, ship_iteration)
     |> assign(
       :changeset,
       Wows.change_ship_iteration(ship_iteration)
     )
     |> assign(:parameters, Repo.all(ShipParameter))}
  end

  def mount(_, %{"ship_id" => ship_id}, socket) do
    ship =
      StHub.Wows.get_ship!(ship_id)
      |> Repo.preload(:iterations)

    next_iteration_id =
      case ship.iterations do
        [] ->
          1

        iterations ->
          List.last(iterations).iteration + 1
      end

    ship_iteration = %ShipIteration{
      ship_id: ship_id,
      iteration: next_iteration_id,
      changes: []
    }

    {:ok,
     socket
     |> assign(:ship_iteration, ship_iteration)
     |> assign(
       :changeset,
       Wows.change_ship_iteration(ship_iteration, %{})
     )
     |> assign(:parameters, Repo.all(ShipParameter))}
  end

  def handle_event("save", _value, socket) do
    {:ok, iteration} =
      Repo.insert_or_update(socket.assigns.changeset,
        on_conflict: :replace_all,
        conflict_target: :id
      )

    {:noreply,
     socket
     |> put_flash(:info, "Iteration created or updated")
     |> redirect(to: Routes.ship_path(StHubWeb.Endpoint, :show, iteration.ship_id))}
  end

  def handle_event("add_change", _value, socket) do
    changes =
      [
        StHub.Wows.change_ship_iteration_change(
          %ShipIterationChange{
            temp_id: get_random_id(),
            type: "change"
          },
          %{"parameter_id" => "1"}
        )
      ] ++
        socket.assigns.ship_iteration.changes ++
        Map.get(socket.assigns.changeset.changes, :changes, [])

    changeset =
      socket.assigns.changeset
      |> Ecto.Changeset.put_assoc(:changes, changes)

    {:noreply,
     socket
     |> assign(:changeset, changeset)}
  end

  def handle_event("validate", %{"ship_iteration" => params}, socket) do
    changeset =
      socket.assigns.ship_iteration
      |> ShipIteration.changeset(params)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def get_parameter(parameters, changeset) do
    parameter_id =
      case changeset.data.parameter_id do
        nil ->
          case Map.has_key?(changeset.params, "parameter_id") do
            true ->
              changeset.params["parameter_id"]
              |> String.to_integer()

            false ->
              changeset.source.changes.parameter_id
          end

        value ->
          value
      end

    case Enum.find(parameters, fn p -> p.id == parameter_id end) do
      nil ->
        Logger.debug("not found")
        {:not_found, nil}

      parameter ->
        Logger.debug("found")
        {:ok, parameter}
    end
  end

  def get_random_id() do
    min = String.to_integer("100000", 36)
    max = String.to_integer("ZZZZZZ", 36)

    max
    |> Kernel.-(min)
    |> :rand.uniform()
    |> Kernel.+(min)
    |> Integer.to_string(36)
  end
end
