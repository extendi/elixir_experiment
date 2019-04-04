defmodule SplittingCamel do
  def split(string) do
    string
    |> String.split(~r{[A-Z]}, include_captures: true, trim: true)
    |> Enum.chunk_every(2)
    |> Enum.map(fn x -> Enum.join(x) end)
  end

  def split_upcase(string) do
    string
    |> String.codepoints()
    |> Enum.map(fn x ->
      {x == String.upcase(x), x}
    end)
    |> Enum.map(fn
      {true, " "} ->
        ""

      {true, x} ->
        " #{x}"

      {false, x} ->
        x
    end)
    |> Enum.join()
    |> String.trim()
  end

  def split_regexp(string) do
    string
    |> String.codepoints()
    |> Enum.map(fn x ->
      {x =~ ~r/^\p{Lu}$/u, x}
    end)
    |> Enum.map(fn
      {true, " "} ->
        ""

      {true, x} ->
        " #{x}"

      {false, x} ->
        x
    end)
    |> Enum.join()
    |> String.trim()
  end

  def generate_string(max_len) when is_number(max_len) do
    0..max_len
    |> Enum.map(fn _ ->
      [:small, :small, :small, :small, :small, :small, :small, :small, :capital, :space]
      |> Enum.random()
      |> generate_char
    end)
    |> List.to_string()
  end

  def generate_char(type) do
    type
    |> random_range
    |> Enum.random()
  end

  def random_range(:small) do
    ?a..?z
  end

  def random_range(:capital) do
    ?A..?Z
  end

  def random_range(:space) do
    [" "]
  end
end
