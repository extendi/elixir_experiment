defmodule Day4Aviator.Client do

  @api_url "https://aviation-edge.com/v2/public/flights"

  def get_flights() do
    full_api_url()
    |> HTTPoison.get
    |> parse_flights

  end

  def api_key do
    Application.get_env(:day4_aviator, :api_key)
  end

  def full_api_url do
    "#{@api_url}?key=#{api_key()}"
  end

  def parse_flights({:ok, %HTTPoison.Response{status_code: 200, body: body}}) do
    body
    |> Jason.decode
  end

  def parse_flights({:error, %HTTPoison.Error{reason: reason}}) do
    IO.puts(reason)
    :error
  end

end

