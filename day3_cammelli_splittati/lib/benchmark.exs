defmodule BenchmarkSplit do
  list_string =
    0..1_000
    |> Enum.map(fn _ -> SplittingCamel.generate_string(10) end)

  Benchee.run(%{
    "split_upcase" => fn -> list_string |> Enum.map(&SplittingCamel.split_upcase/1) end,
    "split_regex" => fn -> list_string |> Enum.map(&SplittingCamel.split_regexp/1) end
  })
end
