defmodule StHubWeb.Router do
  use StHubWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :put_root_layout, {StHubWeb.LayoutView, :root}
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", StHubWeb do
    pipe_through :browser

    get "/", PageController, :index

    scope "/wows" do
      scope "/ships" do
        get("/", WowsController, :index)

        scope "/:ship_id" do
          get "/", ShipController, :show

          scope "/iterations" do
            get "/new", ShipIterationController, :new
            get "/:iteration_id", ShipIterationController, :show
          end
        end
      end
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", StHubWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: StHubWeb.Telemetry
    end
  end
end
