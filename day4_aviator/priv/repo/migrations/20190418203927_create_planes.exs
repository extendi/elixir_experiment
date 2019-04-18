defmodule Day4Aviator.Flights.Repo.Migrations.CreatePlanes do
  use Ecto.Migration

  def change do
    create table(:planes) do
      add :name, :string
      add :model, :string
    end
  end
end
