# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :event_sourcing,
  ecto_repos: [EventSourcing.Repo]

# Configures the endpoint
config :event_sourcing, EventSourcingWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "LQl61+Pus7e/THGyOlRSrNXhyKvtfDsEaTgh7PDr78wdLjnnUpYWFt0ANbSQ2YYR",
  render_errors: [view: EventSourcingWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: EventSourcing.PubSub,
  live_view: [signing_salt: "0FZ64gKF"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :eventstore,
  column_data_type: "jsonb"

config :event_sourcing, EventSourcing.EventStoreApplication,
  event_store: [
    adapter: Commanded.EventStore.Adapters.EventStore,
    event_store: EventSourcing.EventStore
  ],
  pubsub: :local,
  registry: :local

config :event_sourcing, event_stores: [EventSourcing.EventStore]

config :event_sourcing, EventSourcing.EventStore,
  serializer: Commanded.Serialization.JsonSerializer,
  username: "postgres",
  password: "postgres",
  database: "eventstore_dev",
  hostname: "localhost",
  port: 8001,
  pool_size: 10
