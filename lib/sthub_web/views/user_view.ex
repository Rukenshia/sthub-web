defmodule StHubWeb.UserView do
  use StHubWeb, :view

  def title(:index, _) do
    "Users"
  end

  def title(:show, _) do
    "You should not be here"
  end

  def title(:new, _) do
    "Create user"
  end

  def title(:edit, _) do
    "Change user"
  end
end
