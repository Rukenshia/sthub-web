defmodule StHubWeb.Router do
  use StHubWeb, :router

  pipeline :auth do
    plug StHub.UserManager.Pipeline
  end

  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  pipeline :ensure_admin do
    plug StHub.UserManager.EnsureAdministrator
  end

  pipeline :ensure_contributor do
    plug StHub.UserManager.EnsureContributor
  end

  pipeline :api_ensure_admin do
    plug StHub.UserManager.EnsureAdministrator, %{redirect: false}
  end

  pipeline :api_ensure_tester do
    plug StHub.UserManager.EnsureTester, %{redirect: false}
  end

  pipeline :api_authorize_user_id do
    plug StHub.UserManager.AuthorizeUserId, %{redirect: false}
  end

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

  pipeline :api_auth do
    plug :fetch_session
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug StHub.UserManager.ApiAuth
  end

  scope "/api", StHubWeb do
    pipe_through :api

    scope "/wows" do
      scope "/testing" do
        get "/game_version", WowsController, :api_show_wows_version
        get "/ships", ShipController, :api_index_testships
      end

      scope "/battles" do
        pipe_through [:api_auth, :api_ensure_admin]

        get "/", BattleController, :index
      end
    end

    scope "/users/:user_id/ships/:ship_id" do
      pipe_through [:api_auth, :api_ensure_tester, :api_authorize_user_id]

      get "/battles", BattleController, :index
    end
  end

  scope "/", StHubWeb do
    pipe_through [:browser, :auth]

    get "/", PageController, :index

    get "/login", SessionController, :new
    post "/login", SessionController, :login
    get "/logout", SessionController, :logout

    scope "/wows" do
      scope "/accounts" do
        get "/login/:realm", PageController, :start_login
        get "/login/:realm/callback", PageController, :login_callback
      end

      scope "/ships" do
        get("/", WowsController, :index)

        scope "/:ship_id" do
          get "/", ShipController, :show

          scope "/iterations" do
            pipe_through [:ensure_contributor]

            get "/new", ShipIterationController, :new
            get "/:iteration_id", ShipIterationController, :show
          end
        end
      end
    end

    scope "/admin" do
      pipe_through [:ensure_auth, :ensure_admin]

      resources "/users", UserController
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
