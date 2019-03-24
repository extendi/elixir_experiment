defmodule Chat.Client do
  use GenServer

  @me __MODULE__

  def start_link(_id) do
    GenServer.start_link(@me, %{ name: nil })
  end

  @impl true
  def init(state) do
    {:ok, state}
  end

  ##### API #####

  @spec new(String.t()) :: {:ok, pid()}
  def new(name) do
    {:ok, pid} = DynamicSupervisor.start_child(Day2Chat.ClientSup, {@me, &start_link/1})
    register_name(pid, name)
  end

  def join_room(client_pid, room) do
    GenServer.call(client_pid, {:join_room, room})
  end

  def chat(session_id, message) do
    ChatApi.chat(session_id, message)
  end

  ##### CALLBACK #####

  @impl true
  def handle_call({:register_name, name}, _from, state) do
    {:reply, {:ok, self()}, %{state | name: name}}
  end

  @impl true
  def handle_call({:join_room, room}, _from, %{name: name} = state) do
    {:reply, ChatApi.join_room(name, room, self()), state}
  end

  @impl true
  def handle_info({:new_message, room, {user, message}}, state) do
    IO.puts "[#{user}@#{room}] #{message}"
    {:noreply, state}
  end

  ##### PRIVATE #####

  @spec register_name(pid(), String.t()) :: {:ok, pid()}
  defp register_name(pid, name) do
    GenServer.call(pid, {:register_name, name})
  end
end
