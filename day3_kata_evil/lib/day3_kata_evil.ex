defmodule Day3KataEvil do

  @spec blacklist(String.t, [String.t]) :: String.t
  def blacklist(text, []), do: text

  def blacklist(text, [badword]) do
    anonymize(text, badword)
  end

  ##### PRIVATE #####

  defp anonymize(text, badword) do
    text
    |> String.replace(badword, make_x(badword))
  end

  def make_x(s) do
    String.duplicate("X", String.length(s))
  end
end
