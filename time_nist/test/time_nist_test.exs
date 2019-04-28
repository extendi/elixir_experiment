defmodule TimeNistTest do
  use ExUnit.Case, async: false
  doctest TimeNist

  import Mox

  setup :set_mox_global
  setup :verify_on_exit!

  setup do
    {:ok, fake_server} = start_supervised(TimeNist.FakeServer)

    TimeNist.ClientMock
    |> expect(:request, fn _ -> {:ok, TimeNist.FakeServer.get_daytime(fake_server)} end)

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

  test "multiple request" do
    times =
      1..100
      |> Enum.map(fn _ -> TimeNist.Client.daytime() end)

    assert Enum.count(times) == 100
    assert times |> Enum.filter(fn e -> String.length(e) > 0 end) |> Enum.count() == 100
  end
end
