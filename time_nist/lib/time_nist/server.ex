defmodule TimeNist.Server do
  # Task:
  # - define the state
  # - define the argument of the init & start_link
  # - make a requet to the server every 7s (see handle_info)
  use GenServer

  def start_link() do
    # GenServer.start_link ...
  end

  @impl true
  def init() do
    # ...
  end

  ############ API ###############

  @spec get_timedate() :: {:ok, String.t()} | {:error, any()}
  def get_timedate() do
    {:error, :unimplemented}
  end

  ########## CALLBACK ############


  ########### PRIVATE ############

end
