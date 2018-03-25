defmodule CheapoJoeTest do
  use ExUnit.Case
  doctest CheapoJoe

  test "greets the world" do
    assert CheapoJoe.hello() == :world
  end
end
