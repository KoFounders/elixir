defmodule WeberTest do
  use ExUnit.Case
  doctest Weber

  test "greets the world" do
    assert Weber.hello() == :world
  end
end
