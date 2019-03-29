defmodule ChatApi do
  @type room_type :: String.t()
  @type user_type :: String.t()
  @type session_type :: String.t()

  @spec join(room_type, user_type) :: {:ok, session_type, integer()} | {:error, String.t()}
  defdelegate join(room, user), to: Server.Chat

  @spec chat(session_type, String.t()) :: :ok | :error
  defdelegate chat(session, message), to: Server.Chat
end
