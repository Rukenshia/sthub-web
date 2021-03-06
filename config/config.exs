# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :sthub,
  namespace: StHub,
  ecto_repos: [StHub.Repo]

config :sthub,
  http_adapter: StHub.Http.Client

config :sthub, StHub.Wows.Api, application: "bf7fb7e1809acb24157245221cca089b"
config :sthub, StHub.Wows.OpenId, application: "bf7fb7e1809acb24157245221cca089b"

# Configures the endpoint
config :sthub, StHubWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "vEPwouEOeUCVNbtQ8PAsNlvbkCzN6QljbWdrP+YMlQP1TtT0FgJa7IlCj+GHUGsB",
  render_errors: [view: StHubWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: StHub.PubSub,
  live_view: [signing_salt: "iVMvdfmu"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Guardian config
config :sthub, StHub.UserManager.Guardian,
  issuer: "sthub",
  secret_key: "WkSn0BKg/qjf5+2tvR3iTl7bGNCq7xSL1d/oZee4CVdkiiINVWqWC3JgVeaEG7Xc"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
