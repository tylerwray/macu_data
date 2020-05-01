defmodule MacuData.Repo do
  use Ecto.Repo,
    otp_app: :macu_data,
    adapter: Ecto.Adapters.Postgres
end
