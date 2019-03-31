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

    test "works if we don't have a single blacklisted word (repeated)" do
      assert Day3KataEvil.blacklist("You are a nice person, so nice!", ["nice"]) ==
               "You are a XXXX person, so XXXXX"
    end

    test "works in case of multiple blacklisted words" do
      assert Day3KataEvil.blacklist("You are a nice person", ["nice", "person"]) ==
               "You are a XXXX XXXXXX"
    end

    test "works in case of empty badwords" do
      assert Day3KataEvil.blacklist("You are a nice person, but not so nicer", ["nice", ""]) ==
               "You are a XXXX person, but not so XXXXX"
    end

    test "works with long listed words" do
      assert(
        Day3KataEvil.blacklist("Such a nice day with a bright sun, makes me happy", [
          "nice",
          "pony",
          "sun",
          "light",
          "fun",
          "happy",
          "funny",
          "joy",
          "others"
        ]) == "Such a XXXX day with a bright XXX, makes me XXXXX"
      )
    end
  end

  describe "Replace blacklisted (prefix) words" do
    test "blacklist the entire word in case of that word start with a blacklisted words" do
      assert Day3KataEvil.blacklist("You are so friendly!", ["friend"]) == "You are so XXXXXXXXX"
    end
  end
end
