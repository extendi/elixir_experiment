defmodule Server.Room do
  use GenServer

  @me __MODULE__

  def start_link(room_name) do
    GenServer.start_link(
      @me,
      [],
      name: {:via, Registry, {Registry.Room, gen_id(room_name)}}
    )
  end

  def init(_) do
    # the state is the list of the clients present in the room
    {:ok, []}
  end

  ##### API #####

  @spec create_room(String.t()) :: {:ok, pid()} | {:error, String.t()}
  def create_room(room_name) do
    room_name
    |> lookup()
    |> create_if_notexists()
  end

  ##### CALLBACK #####

  ##### PRIVATE #####

  defp create_if_notexists({:error, room_name, :not_present}) do
    DynamicSupervisor.start_child(Day2Chat.RoomSup, {@me, room_name})
  end

  defp create_if_notexists({:ok, _pid} = process), do: process

  @spec gen_id(String.t()) :: atom()
  defp gen_id(room_name) do
    String.to_atom("room_#{room_name}")
  end

  defp lookup(room_name) do
    case Registry.lookup(Registry.Room, gen_id(room_name)) do
      [{pid, _}] -> {:ok, pid}
      _ -> {:error, room_name, :not_present}
    end
  end
end
