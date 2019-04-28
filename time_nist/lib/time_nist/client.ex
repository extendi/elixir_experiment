defmodule TimeNist.Client do
  # Task:
  # - define the state
  # - define the argument of the init & start_link
  # - make a requet to the server every 7s (see handle_info)
  use GenServer

  @me __MODULE__
  @api_nist Application.get_env(:time_nist, :nist_api)
  @target_server "time.nist.gov"

  def start_link(_) do
    GenServer.start_link(@me, @target_server, name: @me)
  end

  @impl true
  def init(target_server) do
    refresh()
    {:ok, %{daytime: get_daytime(target_server), server: target_server}}
  end

  ############ API ###############

  @spec daytime() :: {:ok, String.t()} | {:error, any()}
  def daytime do
    GenServer.call(@me, :daytime)
  end

  ########## CALLBACK ############

  @impl true
  def handle_call(:daytime, _from, %{daytime: daytime} = state) do
    {:reply, daytime, state}
  end

  @impl true
  def handle_info(:refresh, %{server: server} = state) do
    refresh()
    IO.puts("refresh")
    {:noreply, %{state | daytime: get_daytime(server)}}
  end

  ########### PRIVATE ############

  defp refresh do
    Process.send_after(self(), :refresh, 7_000)
  end

  @spec get_daytime(String.t()) :: String.t()
  defp get_daytime(host) do
    case @api_nist.request(host) do
      {:ok, val} ->
        val

      _ ->
        ""
    end
  end
end
