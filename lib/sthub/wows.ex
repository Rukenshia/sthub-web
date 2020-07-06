defmodule StHub.Wows do
  @moduledoc """
  The Wows context.
  """
  require Logger

  import Ecto.Query, warn: false
  alias StHub.Repo

  alias StHub.Wows.ShipIteration
  alias StHub.Wows.ShipIterationChange
  alias StHub.Wows.Ship

  @doc """
  Upserts all Wows Warships from the
  official WoWS API into the StHub database
  """
  def update_ship_database do
    StHub.Wows.Api.get_warships()
    |> Map.values()
    |> Enum.each(fn c ->
      case Repo.get(StHub.Wows.Ship, c["ship_id"]) do
        nil ->
          %StHub.Wows.Ship{
            id: c["ship_id"],
            released: false,
            credited_to_testers: false,
          }
          |> StHub.Wows.Ship.changeset(%{
            name: c["name"],
            nation: c["nation"],
            tier: c["tier"],
            type: c["type"],
            additional_data: c
          })
          |> Repo.insert!()

        v ->
          v
          |> StHub.Wows.Ship.changeset(%{
            name: c["name"],
            nation: c["nation"],
            tier: c["tier"],
            type: c["type"],
            additional_data: c
          })
          |> Repo.update!()
      end
    end)
  end

  @doc """
  Returns the list of wows_ship.

  ## Examples

      iex> list_wows_ships()
      [%ShipIteration{}, ...]

  """
  def list_wows_ships do
    Repo.all(Ship)
  end

  @doc """
  Gets a single ship.

  Raises `Ecto.NoResultsError` if the Ship iteration does not exist.

  ## Examples

      iex> get_ship!(123)
      %ShipIteration{}

      iex> get_ship!(456)
      ** (Ecto.NoResultsError)

  """
  def get_ship!(id), do: Repo.get!(Ship, id)

  @doc """
  Returns the list of wows_ship_iterations.

  ## Examples

      iex> list_wows_ship_iterations()
      [%ShipIteration{}, ...]

  """
  def list_wows_ship_iterations do
    Repo.all(ShipIteration)
  end

  @doc """
  Gets a single ship_iteration.

  Raises `Ecto.NoResultsError` if the Ship iteration does not exist.

  ## Examples

      iex> get_ship_iteration!(123)
      %ShipIteration{}

      iex> get_ship_iteration!(456)
      ** (Ecto.NoResultsError)

  """
  def get_ship_iteration!(id), do: Repo.get!(ShipIteration, id)

  @doc """
  Creates a ship_iteration.

  ## Examples

      iex> create_ship_iteration(%{field: value})
      {:ok, %ShipIteration{}}

      iex> create_ship_iteration(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_ship_iteration(attrs \\ %{}) do
    %ShipIteration{}
    |> ShipIteration.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a ship_iteration.

  ## Examples

      iex> update_ship_iteration(ship_iteration, %{field: new_value})
      {:ok, %ShipIteration{}}

      iex> update_ship_iteration(ship_iteration, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_ship_iteration(%ShipIteration{} = ship_iteration, attrs) do
    ship_iteration
    |> ShipIteration.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a ship_iteration.

  ## Examples

      iex> delete_ship_iteration(ship_iteration)
      {:ok, %ShipIteration{}}

      iex> delete_ship_iteration(ship_iteration)
      {:error, %Ecto.Changeset{}}

  """
  def delete_ship_iteration(%ShipIteration{} = ship_iteration) do
    Repo.delete(ship_iteration)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking ship_iteration changes.

  ## Examples

      iex> change_ship_iteration(ship_iteration)
      %Ecto.Changeset{data: %ShipIteration{}}

  """
  def change_ship_iteration(%ShipIteration{} = ship_iteration, attrs \\ %{}) do
    ShipIteration.changeset(ship_iteration, attrs)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking ship_iteration_change changes.

  ## Examples

      iex> change_ship_iteration_change(ship_iteration_change)
      %Ecto.Changeset{data: %ShipIteration{}}

  """
  def change_ship_iteration_change(%ShipIterationChange{} = ship_iteration_change, attrs \\ %{}) do
    ShipIterationChange.changeset(ship_iteration_change, attrs)
  end
end
