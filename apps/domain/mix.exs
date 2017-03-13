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
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger, :commanded],
     mod: {Attend.Domain.Application, []}]
  end

  defp deps do
    [
      {:commanded, "~> 0.9"},
      {:ecto, "~> 2.1"}
    ]
  end
end
