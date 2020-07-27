defmodule StHubWeb.ShipIterationView do
  use StHubWeb, :view

  def title(:new, _params) do
    "Create new iteration"
  end

  def title(:show, _params) do
    "Update iteration"
  end
end
