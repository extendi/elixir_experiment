defmodule Server.Chat do
  use GenServer
  alias Server.ChatState

  @me __MODULE__
  @server :cip@ripper

  def start_link(arg) do
    GenServer.start_link(@me, arg, name: @me)
  end

  def init(_arg) do
    {:ok, %ChatState{}}
  end

  ##### API #####

  def join_room(user_id, room, pid) do
    GenServer.call({@me, @server}, {:join_room, user_id, room, pid})
  end

  def chat(session_id, message) do
    GenServer.call({@me, @server}, {:chat, session_id, message})
  end

  ##### CALLBACK #####

  def handle_call({:join_room, user_id, room, pid}, _from, %ChatState{users: users} = state) do
    list_rooms = Map.get(users, user_id, [])

    {reply, next_state} =
      if room in list_rooms do
        {{:error, "already joined"}, state}
      else
        uid = gen_uid()

        new_state =
          state
          |> update_sessions(user_id, room, uid)
          |> update_users(user_id, [room | list_rooms])
          |> update_rooms(room, pid)

        {{:ok, uid}, new_state}
      end

    {:reply, reply, next_state}
  end

  def handle_call({:chat, session_id, message}, _from, %ChatState{sessions: sessions} = state) do
    case Map.get(sessions, session_id) do
      nil ->
        {:reply, {:error, "not joined!"}, state}
      {user, room} ->
        {:reply, :delivered, chat_to(room, {user, message}, state)}
    end
  end

  ##### PRIVATE #####

  defp chat_to(room, message, %ChatState{rooms: rooms} = state) do
    {list_msgs, pids} = Map.get(rooms, room, {[], []})

    pids
    |> Enum.each(fn pid ->
      send(pid, {:new_message, room, message})
    end)

    %{state | rooms: Map.put(rooms, room, {[message | list_msgs], pids})}
  end

  @spec gen_uid() :: String.t()
  defp gen_uid, do: UUID.uuid4()

  defp update_sessions(%ChatState{sessions: sessions} = state, user_id, room, uid) do
    %{state | sessions: Map.put(sessions, uid, {user_id, room})}
  end

  defp update_users(%ChatState{users: users} = state, user_id, new_rooms) do
    %{state | users: Map.put(users, user_id, new_rooms)}
  end

  def update_rooms(%ChatState{rooms: rooms} = state, room, pid) do
    rooms_map =
      Map.update(
        rooms,
        room,
        {[], [pid]},
        fn {msgs, pids} ->
          {msgs, [pid | pids]}
        end
      )

    %{state | rooms: rooms_map}
  end
end
