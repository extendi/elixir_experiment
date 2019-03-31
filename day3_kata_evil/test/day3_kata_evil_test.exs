defmodule Day3KataEvilTest do
  use ExUnit.Case
  doctest Day3KataEvil

  describe "Replace blacklisted words" do
    test "works if we don't have any blacklisted words" do
      assert Day3KataEvil.blacklist("You are a nice person", []) == "You are a nice person"
    end

    test "works if we don't have any blacklisted words in the text" do
      assert Day3KataEvil.blacklist("You are a nice person", ["apple"]) == "You are a nice person"
    end

    test "works if we don't have a single blacklisted word" do
      assert Day3KataEvil.blacklist("You are a nice person", ["nice"]) == "You are a XXXX person"
    end

    test "works if we don't have a single blacklisted word (but different)" do
      assert Day3KataEvil.blacklist("You are a nice person", ["nicex"]) == "You are a nice person"
    end

  end
end
