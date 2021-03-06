defmodule Attend.Domain.Mixfile do
  use Mix.Project

  def project do
    [app: :domain,
     version: "0.1.0",
     build_path: "../../_build",
     config_path: "../../config/config.exs",
     deps_path: "../../deps",
     lockfile: "../../mix.lock",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases(),
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger, :commanded, :ecto, :postgrex],
     mod: {Attend.Domain.Application, []}]
  end

  defp deps do
    [
      {:commanded, "~> 0.9"},
      {:ecto, "~> 2.1"},
      {:postgrex, "~> 0.11"}
    ]
  end

  defp aliases do
    ["reset": ["event_store.drop", "event_store.create", "ecto.drop", "ecto.create", "ecto.migrate"]]
  end
end
