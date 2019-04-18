defmodule Day4AviatorTest do
  use ExUnit.Case
  doctest Day4Aviator

  test "verify api url" do
    assert Day4Aviator.Client.full_api_url() ==
             "https://aviation-edge.com/v2/public/flights?key=fea522-148fac"
  end
end
