defmodule Lagerbehandler.Repo do
  use Ecto.Repo,
    otp_app: :lagerbehandler,
    adapter: Ecto.Adapters.Postgres
end
