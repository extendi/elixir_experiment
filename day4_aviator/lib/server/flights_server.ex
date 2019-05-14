defmodule Day4Aviator.Server.Flights do
  use GenServer

  # Alias for Day4Aviator.Server.Flights
  @me __MODULE__

  def start_link(name) do
    GenServer.start_link(@me, name)
  end

  @impl GenServer
  def init(name) do
    {:ok, _} = Registry.register(Registry.Aviator, name, self())
    {:ok, %{calls: 0}}
  end

  ### PUBLIC API ###

  def save_flights(name) do
    case lookup_pid(name) do
      {:ok, pid} -> GenServer.cast(pid, {:fetch})
      error -> error
    end
  end

  def get_calls(name) do
    case lookup_pid(name) do
      {:ok, pid} -> GenServer.call(pid, {:get_calls})
      error -> error
    end
  end

  @impl GenServer
  def handle_cast({:fetch}, %{calls: calls} = state) do
    {:noreply, %{state | calls: calls + 1}}
  end

  @impl GenServer
  def handle_call({:get_calls}, _from, %{calls: calls} = state) do
    {:reply, calls, state}
  end

  defp lookup_pid(name) do
    case Registry.lookup(Registry.Aviator, name) do
      [{_, pid}] -> {:ok, pid}
      _ -> {:error, :not_found}
    end
  end
end
