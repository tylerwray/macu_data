import Config

config :macu_data,
  ecto_repos: [MacuData.Repo]

config :macu_data, MacuData.Repo,
  database: "macu_data",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"
