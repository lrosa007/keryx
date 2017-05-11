# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :keryx,
  ecto_repos: [Keryx.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :keryx, Keryx.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "bE8I0omojtuyZdebt1y4IRicbbYslP/bODx87Hq25UnqGginKd3eewRndmOhDQpC",
  render_errors: [view: Keryx.Web.ErrorView, accepts: ~w(json)],
  pubsub: [name: Keryx.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
