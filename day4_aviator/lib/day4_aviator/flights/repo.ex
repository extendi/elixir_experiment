defmodule Day4Aviator.Flights.Repo do
  use Ecto.Repo,
    otp_app: :day4_aviator,
    adapter: Ecto.Adapters.Postgres
end
