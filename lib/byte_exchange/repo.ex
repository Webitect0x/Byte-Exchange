defmodule ByteExchange.Repo do
  use Ecto.Repo,
    otp_app: :byte_exchange,
    adapter: Ecto.Adapters.Postgres
end
