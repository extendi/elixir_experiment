defmodule SplittingCamelTest do
  use ExUnit.Case
  doctest SplittingCamel

  test "split empty in camel case" do
    assert SplittingCamel.split_upcase("") == ""
  end

  test "split two word in camel case" do
    assert SplittingCamel.split_upcase("StringString") == "String String"
  end

  test "split three words in camel case" do
    assert SplittingCamel.split_upcase("IlBudelloDelCane") == "Il Budello Del Cane"
  end

  test "split all small word in camel case" do
    assert SplittingCamel.split_upcase("ilbudello") == "ilbudello"
  end

  test "split two capital letters in camel case" do
    assert SplittingCamel.split_upcase("IlBudelloDITuma") == "Il Budello D I Tuma"
  end

  test "split with spaces in camel case" do
    assert SplittingCamel.split_upcase("IlBudello DITuma") == "Il Budello D I Tuma"
  end
end
