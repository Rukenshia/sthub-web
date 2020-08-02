defmodule StHubWeb.PageView do
  use StHubWeb, :view

  alias StHub.Wows.Ship

  def title(:index, _assigns) do
    "Dashboard"
  end

  def title(_, _) do
    "StHub"
  end
end
