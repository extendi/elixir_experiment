defmodule Server.ChatState do
  defstruct(
    # %{ users => [ room1, room2 ] }
    users: %{},
    # %{ room => {[ msg ], [ pid ]} }
    rooms: %{},
    # %{ session => {user, room} }
    sessions: %{}
  )
end
