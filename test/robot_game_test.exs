defmodule RobotGameTest do
  use ExUnit.Case
  doctest RobotGame

  test "greets the world" do
    assert RobotGame.hello() == :world
  end
end
