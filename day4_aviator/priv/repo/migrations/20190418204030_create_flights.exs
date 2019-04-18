defmodule Day4Aviator.Flights.Repo.Migrations.CreateFlights do
  use Ecto.Migration

  def change do
    create table(:flights) do
      add :name, :string
      add :iata_from_id, :string
      add :iata_to_id, :string
      add :altitude, :integer
      add :plane_id, references(:planes), null: false
      timestamps()
    end
  end
end
