defmodule Day4Aviator.Repo.Flight do
  use Ecto.Schema
  alias Day4Aviator.Repo.Plane

  schema "flights" do
    field(:name, :string)
    field(:iata_from_id, :string)
    field(:iata_to_id, :string)
    field(:altitude, :integer)
    belongs_to(:plane, Plane)
    timestamps()
  end
end
