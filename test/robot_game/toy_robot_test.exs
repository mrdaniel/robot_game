defmodule RobotGame.ToyRobotTest do
  use ExUnit.Case, async: false

  alias RobotGame.{GameState, ToyRobot}

  setup do
    start_supervised(GameState)
    :ok
  end

  test "REPORT command when robot hasn't been placed" do
    assert ToyRobot.perform_command("REPORT") == :noop
  end

  test "REPORT command when robot has been placed" do
    GameState.place(%{x: 0, y: 5, direction: "NORTH"})
    assert ToyRobot.perform_command("REPORT") == {:ok, "0,5,NORTH"}
  end

end