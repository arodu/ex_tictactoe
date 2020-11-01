# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :tictactoe, TictactoeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "n7DPu7OMjtXvuC0Ej7+5NpBGKDIEu3dzu78wMBnhvhiv92A7l0lFYdARnxJHDWoU",
  check_origin: ["https://ex-tictactoe.herokuapp.com", "http://ex-tictactoe.herokuapp.com", "//https://ex-tictactoe.herokuapp.com", "wss://ex-tictactoe.herokuapp.com/"],
  render_errors: [view: TictactoeWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Tictactoe.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [
    signing_salt: "C+5Rnj2Z+fhcfVj/RQz8ICxEhZ4Q5kg7"
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
