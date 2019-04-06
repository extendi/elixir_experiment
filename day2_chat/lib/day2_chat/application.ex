defmodule Day2Chat.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: Day2Chat.Worker.start_link(arg)
      {Server.Chat, []},
      {DynamicSupervisor, strategy: :one_for_one, name: Day2Chat.RoomSup},
      {DynamicSupervisor, strategy: :one_for_one, name: Day2Chat.ClientSup}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Day2Chat.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
