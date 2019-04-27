defmodule Day4Aviator.Fetcher do
  alias Day4Aviator.{Client, Extractor}

  def flights_by_altitude(meters \\ 10_000) do
    with {:ok, flights} <- Client.get_flights() do
      Extractor.extract(flights, fn %{"geography" => %{"altitude" => altitude}} ->
        altitude > meters
      end)
    else
      _ -> {:error, "no geo"}
    end
  end
end
