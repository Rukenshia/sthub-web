defmodule StHubWeb.PageView do
  use StHubWeb, :view

  def title(:index, _assigns) do
    "Dashboard"
  end
end
