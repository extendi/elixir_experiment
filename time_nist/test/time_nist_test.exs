defmodule TimeNistTest do
  use ExUnit.Case
  doctest TimeNist

  setup :verify_on_exit!

  setup do
    {:ok, client} = start_supervised(TimeNist.Client)
    [time_server: client]
  end

  test "the GenServer is Up & Running", %{time_server: client} do
    assert Process.whereis(TimeNist.Client) == client
  end

  test "Get a daytime" do
    date = TimeNist.Client.daytime()
    assert String.length(date) > 0
  end

  test "Get a valid daytime" do
    date = TimeNist.Client.daytime()
    now = Time.utc_now()
    assert String.contains?(date, "#{now.hour}:#{now.minute}") == true
  end
end
