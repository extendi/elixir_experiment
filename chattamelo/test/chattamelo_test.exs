defmodule ChattameloTest do
  use ExUnit.Case
  doctest Chattamelo

  test "greets the world" do
    assert Chattamelo.hello() == :world
  end
end
