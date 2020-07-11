defmodule StHubWeb.WowsView do
  use StHubWeb, :view

  def title(:index, _assigns) do
    "Ship database"
  end

  def render("version.json", %{version: version}) do
    %{ version: version }
  end
end
