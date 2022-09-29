defmodule Advent2016Test do
  use ExUnit.Case
  doctest Advent2016

  test "non-existent day allowed" do
    assert match?(:ok, Advent2016.main(["0"]))
  end
end
