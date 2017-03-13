use Mix.Config

config :eventstore, EventStore.Storage,
  serializer: Commanded.Serialization.JsonSerializer,
  username: "ben",
  password: "meow123",
  database: "eventstore_dev",
  hostname: "localhost",
  pool_size: 10
