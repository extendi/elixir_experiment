defmodule Server.Chat do
  use GenServer

  alias Server.State

  @me __MODULE__

  def start_link(_) do
    GenServer.start_link(@me, %State{}, name: @me)
  end

  @impl true
  def init(arg) do
    {:ok, arg}
  end

  ################ API ###

  @spec join(String.t(), String.t()) :: {:ok, String.t(), integer()} | {:error, String.t()}
  def join(room, username) do
    GenServer.call(@me, {:join, self(), room, username})
  end

  def chat(session, message) do
    GenServer.call(@me, {:chat, self(), session, message})
  end

  ################ CALLBACK ###

  def handle_call({:chat, client_pid, session, message}, _from, %State{room_pids: pids} = state) do
    room =
      session
      |> get_room()

    clients =
      pids
      |> Map.get(room)

    clients -- [client_pid]
    |> Enum.each(fn client ->
      send(client, message)
    end)

    {:reply, :ok, state}
  end

  @impl true
  def handle_call({:join, client_pid, room, username}, _from, %State{sessions: sessions, room_pids: pids} = state) do
    my_session = ssid(room, username)

    case Map.get(sessions, my_session) do
      nil ->
        new_state = %{
          state |
          sessions: sessions |> Map.put(my_session, {username, room, 1}),
          room_pids: pids |> Map.update(room, [client_pid], fn list -> [client_pid | list] end)
        }
        {:reply, {:ok, my_session, 0}, new_state}

      {^username, ^room, counter} ->
        new_state = %{
          state
          | sessions: Map.put(sessions, my_session, {username, room, counter + 1})
        }

        {:reply, {:ok, my_session, counter}, new_state}

      _ ->
        {:reply, {:error, "bad session"}, state}
    end
  end

  ################ PRIVATE ###

  @spec ssid(String.t(), String.t()) :: String.t()
  defp ssid(room, username) do
    "s_#{room}_#{username}"
  end

  defp get_room(session) do
    session
    |> String.split("_")
    |> Enum.at(1)
  end
end
