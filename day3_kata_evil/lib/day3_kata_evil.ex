defmodule Day3KataEvil do
  @spec blacklist(String.t(), [String.t()]) :: String.t()
  def blacklist(text, []), do: text

  def blacklist(text, badwords) do
    badwords
    |> Enum.reject(&(&1 == ""))
    |> Enum.reduce(text, fn badword, text ->
      anonymize(text, badword)
    end)
  end

  ##### PRIVATE #####

  defp anonymize(text, badword) do
    text
    |> String.split(~r{[\s,\,]}, include_captures: true)
    |> Enum.map(fn token ->
      if String.starts_with?(token, badword) do
        make_x(token)
      else
        token
      end
    end)
    |> Enum.join()
  end

  def make_x(s) do
    String.duplicate("X", String.length(s))
  end
end
