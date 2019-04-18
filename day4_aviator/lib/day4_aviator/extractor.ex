defmodule Day4Aviator.Extractor do

  def extract(flights, predicate) when is_function(predicate) do
    flights
    |> Enum.filter(predicate)
  end

end
