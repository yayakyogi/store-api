defmodule StoreApi.Repo do
  use Ecto.Repo,
    otp_app: :store_api,
    adapter: Ecto.Adapters.Postgres
end
