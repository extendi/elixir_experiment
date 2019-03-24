defmodule Examples do
  @doc """
  Return the sum of the given array (of number).

  ##    Examples

        iex> Examples.sum([1, 2, 3])
        6
        iex> Examples.sum(10)
        10
  """
  @spec sum([number()] | number()) :: number()
  def sum([]), do: 0

  def sum([h | tail]) do
    h + sum(tail)
  end

  def sum(e) when is_number(e) do
    e
  end

  def sum2(xs) do
    xs
    |> reduce(fn x, acc -> x + acc end)
  end

  def reduce(xs, f) do
    do_reduce(xs, f, 0)
  end

  def do_reduce([], _f, acc), do: acc

  def do_reduce([x | xs], f, acc) do
    do_reduce(xs, f, f.(x, acc))
  end

  def map(xs, f) do
    do_map(xs, f, [])
  end

  defp do_map([], _f, acc) do
    acc
    |> Enum.reverse()
  end

  defp do_map([h | tail], f, acc) do
    do_map(tail, f, [f.(h) | acc])
  end

  # multi map
  def pmap(xs, f) do
    xs
    |> Stream.chunk_every(100)
    |> Stream.map(fn chunk ->
      chunk
      |> Enum.chunk_every(5)
      |> Enum.map(fn x ->
        Task.async(fn -> f.(x) end)
      end)
      |> Enum.map(fn task ->
        Task.await(task)
      end)
    end)
    |> Enum.count()
  end

  @spec main() :: number()
  def main do
    [1, 2, 3, 4, 5]
    |> sum()
  end
end
