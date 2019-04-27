defmodule Day4AviatorTest.DB do
  use ExUnit.Case, async: true

  alias Day4Aviator.Flights.Repo
  alias Day4Aviator.Repo.{Flight, Plane}

  setup do
    {:ok, plane_stored} = %Plane{name: "Okido", model: "Typhon"} |> Repo.insert()

    [
      plane: %Plane{name: "Marvel", model: "Hurricane1"},
      plane_stored: plane_stored,
    ]
  end

  test "I can insert a Flight", %{plane: plane} do
    {:ok, flight} =
      %Flight{name: "AX1", iata_from_id: "FLR", iata_to_id: "RM", plane: plane}
      |> Repo.insert()

    assert flight.inserted_at > 0
  end

  test "I can insert a Plane", %{plane: plane} do
    {:ok, new_plane} =
      plane
      |> Repo.insert()
    assert plane.name == new_plane.name
  end

  test "insert plane then the flight", %{plane_stored: plane_stored} do
    {:ok, flight} =
      %Flight{name: "AX1", iata_from_id: "FLR", iata_to_id: "RM", plane: plane_stored}
      |> Repo.insert()

    plane_stored = Repo.preload plane_stored, :flights
    assert Enum.count(plane_stored.flights) > 0
  end

end
