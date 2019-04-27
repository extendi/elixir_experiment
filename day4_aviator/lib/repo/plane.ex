defmodule Day4Aviator.Repo.Plane do
  use Ecto.Schema
  alias Day4Aviator.Repo.Flight

  schema "planes" do
    field(:name, :string)
    field(:model, :string)
    has_many(:flights, Flight)
  end
end
