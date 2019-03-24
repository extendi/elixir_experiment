defmodule PingPong do

  def ping(state) do
    me = self()

    receive do
      {:start, pong_pid} ->
        IO.puts "Starting"
        send(pong_pid, {:ping, me})
        ping(0)
      {:pong, from} ->
        send(from, {:ping, me})
        if state < 1_000_000 do
          ping(state + 1)
        else
          IO.puts "mi avete ammazzato"
          send(from, :halt)
        end
      :halt ->
        IO.puts "ping: HALTed #{state}"
    end
  end

  def pong(state) do
    me = self()
    receive do
      {:ping, from} ->
        send(from, {:pong, me})
        pong(state + 1)
      :halt ->
        IO.puts "pong: HALTed #{state}"
    end
  end

  def start do
    ping_pid = spawn(PingPong, :ping, [0])
    pong_pid = spawn(PingPong, :pong, [0])

    send(ping_pid, {:start, pong_pid})
    Process.sleep 30_000

    send(ping_pid, :halt)
    send(pong_pid, :halt)
  end

end
