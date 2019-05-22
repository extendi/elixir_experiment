defmodule Poker do

  defmacro gen_comb(fn_name, data) do
    {fun_name, _, _} = fn_name
    {:%{}, _, vals} = data
    first_part = Enum.map(vals, fn {k, v} ->
      quote do
        def unquote(fun_name)(unquote(k)), do: unquote(v)
      end
    end)
    second_part = quote do
      def unquote(fun_name)(x), do: x |> String.to_integer()
    end
    [first_part, second_part]
  end

end
