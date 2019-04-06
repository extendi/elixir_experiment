defmodule Server.Room do
  use GenServer

  @me __MODULE__

  def start_link(id) do
    GenServer.start_link(@me, name: String.to_atom("room_#{id}"))
  end

  def init(_) do
    {:ok, []}
  end

  ##### API #####

  def new(id) do
    {:ok, pid} = DynamicSupervisor.start_child(Day2Chat.RoomSup, {@me, &start_link/1})
  end

  ##### CALLBACK #####

  ##### PRIVATE #####

end
