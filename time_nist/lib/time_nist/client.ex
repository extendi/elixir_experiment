defmodule TimeNist.Server do
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
    # {:ok, ...}
  end

  ############ API ###############

  @spec daytime() :: {:ok, String.t()} | {:error, any()}
  def daytime do
    GenServer.call(@me, :daytime)
  end

  ########## CALLBACK ############

  ########### PRIVATE ############
end
