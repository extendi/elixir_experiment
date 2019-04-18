defmodule Day4Aviator.Flight do
  use Ecto.Schema

  schema "flights" do
    field :name, :string
    field :iata_from_id, :string
    field :iata_to_id, :string
    field :altitude, :integer
    belongs_to :plane, Day4Aviator.Plane
    timestamps()
  end
end
