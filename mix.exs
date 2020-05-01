defmodule MacuData.MixProject do
  use Mix.Project

  def project do
    [
      app: :macu_data,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {MacuData.Application, []}
    ]
  end

  defp deps do
    [
      {:csv, "~> 2.3"},
      {:ecto_enum, "~> 1.4"},
      {:ecto_sql, "~> 3.0"},
      {:money, "~> 1.4"},
      {:postgrex, ">= 0.0.0"}
    ]
  end

  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
