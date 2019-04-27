defmodule TimeNistTest do
  use ExUnit.Case
  doctest TimeNist

  setup do
    {:ok, pid} = start_supervised(TimeNist.Server)
    [time_server: pid]
  end

  test "the GenServer is Up & Running", %{time_server: pid} do
    assert Process.whereis(TimeNist.Server) == pid
  end

  test "Get a daytime" do
    date = TimeNist.Server.daytime()
    assert String.length(date) > 0
  end

  test "Get a valid daytime" do
    date = TimeNist.Server.daytime()
    now = Time.utc_now
    assert String.contains?(date, "#{now.hour}:#{now.minute}") == true
  end
end
