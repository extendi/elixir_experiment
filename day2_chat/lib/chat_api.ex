defmodule ChatApi do
  @type session_id :: String.t()
  @type user_id :: String.t()
  @type message :: String.t()
  @type chat_msg :: {user_id, message}

  @spec join_room(user_id, String.t(), pid()) ::
          {:ok, session_id} | {:error, String.t()}
  def join_room(user_id, room, pid) do
    Server.Chat.join_room(user_id, room, pid)
  end

  @spec chat(session_id, String.t()) :: {:ok, any()} | {:error, String.t()}
  def chat(session_id, message) do
    Server.Chat.chat(session_id, message)
  end

  @spec leave(session_id) :: :ok
  def leave(_session_id) do
    :ok
  end
end
