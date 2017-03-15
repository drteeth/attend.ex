use Mix.Config

config :eventstore, EventStore.Storage,
  serializer: Commanded.Serialization.JsonSerializer,
  username: "ben",
  password: "meow123",
  database: "eventstore_test",
  hostname: "localhost",
  pool_size: 10

config :domain, Attend.Repo,
  ecto_repos: [Attend.Repo],
  adapter: Ecto.Adapters.Postgres,
  database: "attend_test",
  username: "ben",
  password: "meow123",
  hostname: "localhost",
  port: "5432"
