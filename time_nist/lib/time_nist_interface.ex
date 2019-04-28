defmodule TimeNist.Interface do
  @callback request(String.t()) :: {:ok, String.t()} | {:error, any()}
end
