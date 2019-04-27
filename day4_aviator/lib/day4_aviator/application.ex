defmodule Day4Aviator.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    HTTPoison.start()
    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: Day4Aviator.Worker.start_link(arg)
      # {Day4Aviator.Worker, arg}
      {Day4Aviator.Flights.Repo, []}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Day4Aviator.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
