defmodule Day4Aviator.Plane do
  use Ecto.Schema

  schema "planes" do
    field :name, :string
    field :model, :string
    has_many :flights, Day4Aviator.Flight
  end
end
