# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :pos2gobff, Pos2gobff.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Mpnt8/2PJLvfA/Ey95cwcKHrD1nvvlmtalxEdd/zzTFkL+vPxho27Au60Rseh0Ac",
  render_errors: [view: Pos2gobff.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Pos2gobff.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :pos2gobff,
  api_base_url: "http://webstores.swiftpos.com.au:4000/SwiftApi/api/"


# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
