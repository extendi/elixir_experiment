defmodule TimeNist do

  @spec request(String.t()) :: {:ok, String.t()} | {:error, any()}
  def request(host) do
    {:ok, socket} = connect(host)
    data = :gen_tcp.recv(socket, 0)
    :gen_tcp.close(socket)
    data
  end

  defp connect(host) do
    :gen_tcp.connect(host |> to_charlist(), 13, [:binary, {:active, false}])
  end
end
