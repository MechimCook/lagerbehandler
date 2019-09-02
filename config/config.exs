# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :lagerbehandler,
  ecto_repos: [Lagerbehandler.Repo]

# Configures the endpoint
config :lagerbehandler, LagerbehandlerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "wYOaTtxgIcL4rlHgW7PCo4OW7DWC/mVuNNJoTQjRHhRiaodrFUGb47y0dNbwWlQl",
  render_errors: [view: LagerbehandlerWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Lagerbehandler.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [
    signing_salt: "bpMydJdiLJX1C2zrNhdy6UebCoiQGh6E"
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :phoenix, :template_engines, leex: Phoenix.LiveView.Engine

# config :ueberauth, Ueberauth,
#   providers: [
#     auth0: {Ueberauth.Strategy.Auth0, [otp_app: :lagerbehandler]}
#   ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
