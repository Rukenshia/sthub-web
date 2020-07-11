defmodule StHubWeb.ShipView do
  use StHubWeb, :view

  def title(:show, _assigns) do
    "View ship"
  end

  def render("index.json", %{ships: ships}) do
    ships
    |> Enum.map(fn s -> render("show.json", ship: s) end)
  end

  def render("show.json", %{ship: ship}) do
    %{
      name: ship.name,
      id: ship.id,
    }
  end
end
