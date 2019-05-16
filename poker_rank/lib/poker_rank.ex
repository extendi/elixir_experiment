# https://www.codewars.com/kata/ranking-poker-hands/train/elixir

defmodule PokerRank do
  def check_consecutive_straight([]), do: false
  def check_consecutive_straight([x | xs]) do
    do_check_consecutive_straight(xs, x)
  end

  def is_straight_point(hand) do
    hand
    |> Enum.map(fn {v, _} -> v end)
    |> Enum.sort
    |> check_consecutive_straight
  end

  def is_poker_point(hand) do
      hand
      |> Enum.reduce(%{}, fn {val, _suite}, acc ->
        Map.update(acc, val, 1, &(&1 + 1))
      end)
      |> Enum.any?(fn
        {_, 4} -> true
        _ -> false
      end)
  end

  def parse_card(""), do: []

  def parse_card(card) do
    [value, suite] =
      card
      |> String.split("", trim: true)

    {parse_value(value), parse_suite(suite)}
  end

  def parse_hand(hand) do
    hand
    |> String.split(" ")
    |> Enum.map(&parse_card/1)
  end

  ##############

  defp parse_value("A"), do: 14
  defp parse_value("K"), do: 13
  defp parse_value("Q"), do: 12
  defp parse_value("J"), do: 11
  defp parse_value("T"), do: 10
  defp parse_value(n), do: String.to_integer(n)

  defp parse_suite("S"), do: :spades
  defp parse_suite("H"), do: :hearts
  defp parse_suite("D"), do: :diamonds
  defp parse_suite("C"), do: :clubs

  defp do_check_consecutive_straight([], _x), do: true
  defp do_check_consecutive_straight([h | t], x) do
    if h == x + 1 do
      do_check_consecutive_straight(t, h)
    else
      false
    end
  end
end
