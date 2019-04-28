defmodule TimeNist.Server do
  use GenServer

  @me __MODULE__

  def start_link() do
    GenServer.start_link(@me, [])
  end

  @impl true
  def init(_) do
    {:ok, []}
  end

  ### API

  def get_daytime(pid) do
    GenServer.call(pid, :daytime)
  end

  ### CALLBACK

  @impl true
  def handle_call(:daytime, _from, state) do
    {:reply, current_daytime(), state}
  end

  ### PRIVATE

  def current_daytime() do
    now = Timex.now()
    %{year: y, month: m, day: d, hour: h, minute: minutes, second: seconds} = now
    j = Timex.to_julian(now) - 2_400_000
    m_s = m |> to_string |> String.pad_leading(2, "0")
    d_s = d |> to_string |> String.pad_leading(2, "0")
    h_s = h |> to_string |> String.pad_leading(2, "0")
    mt_s = minutes |> to_string |> String.pad_leading(2, "0")
    sec_s = seconds |> to_string |> String.pad_leading(2, "0")
    "#{j} #{y - 2000}-#{m_s}-#{d_s} #{h_s}:#{mt_s}:#{sec_s} 00 0 0 0 UTC(FakeServer) OTM"
  end
end
