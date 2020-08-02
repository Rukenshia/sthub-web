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

  def assign_user(socket, %{"user_id" => user_id}) do
    socket
    |> assign(:current_user, StHub.UserManager.get_user!(user_id))
  end

  def mount(_, %{"ship_id" => _ship_id, "iteration_id" => iteration_id} = params, socket) do
    ship_iteration =
      StHub.Wows.get_ship_iteration!(iteration_id)
      |> Repo.preload(:ship)
      |> Repo.preload(changes: [:parameter])

    {:ok,
     socket
     |> assign_user(params)
     |> assign(:parameter_search_results, %{})
     |> assign(:parameter_search_inputs, %{})
     |> assign(:ship_iteration, ship_iteration)
     |> assign(
       :changeset,
       Wows.change_ship_iteration(ship_iteration)
     )
     |> assign(:parameters, Repo.all(ShipParameter))}
  end

  def mount(_, %{"ship_id" => ship_id} = params, socket) do
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
     |> assign_user(params)
     |> assign(:parameter_search_results, %{})
     |> assign(:parameter_search_inputs, %{})
     |> assign(:ship_iteration, ship_iteration)
     |> assign(
       :changeset,
       Wows.change_ship_iteration(ship_iteration, %{})
     )
     |> assign(:parameters, Repo.all(ShipParameter))}
  end

  def handle_event("delete", _value, socket) do
    with true <- can_delete_iteration(socket.assigns.current_user) do
      {:ok, _} = Wows.delete_ship_iteration(socket.assigns.ship_iteration)

      {:noreply,
       socket
       |> put_flash(:info, "Iteration has been deleted")
       |> redirect(
         to: Routes.ship_path(StHubWeb.Endpoint, :show, socket.assigns.ship_iteration.ship_id)
       )}
    else
      _ ->
        {:noreply, socket |> put_flash(:error, "Didn't work")}
    end
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
      ]
      |> Enum.concat(
        Map.get(
          socket.assigns.changeset.changes,
          :changes,
          socket.assigns.ship_iteration.changes
        )
      )

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

  def handle_event("search", %{"id" => id, "value" => value}, socket) do
    all_search_results =
      Map.put(
        socket.assigns.parameter_search_results,
        id,
        socket.assigns.parameters
        |> Enum.map(fn p -> {p.id, p.friendly_name} end)
        |> Enum.sort_by(fn {_, v} -> String.jaro_distance(v, value) end, :desc)
        |> Enum.slice(0..5)
      )

    all_search_inputs =
      Map.put(socket.assigns.parameter_search_inputs, String.to_integer(id), {0, value})

    {:noreply,
     socket
     |> assign(:parameter_search_results, all_search_results)
     |> assign(:parameter_search_inputs, all_search_inputs)}
  end

  def handle_event("apply-search", %{"id" => id, "parameter-id" => parameter_id}, socket) do
    parameter =
      Enum.find(socket.assigns.parameters, fn v -> v.id == String.to_integer(parameter_id) end)

    # Update visuals
    all_search_results = Map.delete(socket.assigns.parameter_search_results, id)

    # Update changeset
    old_changes = Map.get(socket.assigns.changeset.changes, :changes, socket.assigns.changeset.data.changes)

    changeset = Ecto.Changeset.put_change(
      socket.assigns.changeset,
      :changes,
      List.replace_at(
        old_changes,
        String.to_integer(id),
        ShipIterationChange.changeset(
          Enum.at(old_changes, String.to_integer(id), nil),
          %{"parameter_id" => "#{parameter.id}"})
      )
    )

    all_search_inputs =
      Map.put(
        socket.assigns.parameter_search_inputs,
        String.to_integer(id),
        {parameter.id, parameter.friendly_name}
      )


    {:noreply,
     socket
     |> assign(:changeset, changeset)
     |> assign(:parameter_search_results, all_search_results)
     |> assign(:parameter_search_inputs, all_search_inputs)}
  end

  def get_parameter(parameters, changeset) do
    parameter_id =
      case Map.has_key?(changeset.params, "parameter_id") do
        true ->
          changeset.params["parameter_id"]
          |> String.to_integer()

        false ->
          case changeset.data.parameter_id do
            nil ->
              changeset.source.changes.parameter_id

            value ->
              value
          end
      end

    case Enum.find(parameters, fn p -> p.id == parameter_id end) do
      nil ->
        {:not_found, nil}

      parameter ->
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

  def can_delete_iteration(user) do
    user != nil && user.role == "administrator"
  end
end
