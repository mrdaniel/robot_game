defmodule RobotGame.ToyRobotTest do
  use ExUnit.Case, async: false

  alias RobotGame.{GameState, ToyRobot}

  setup do
    start_supervised(GameState)
    :ok
  end

  test "PLACE command with valid arguments" do
    ToyRobot.perform_command("PLACE", {3, 4, "SOUTH"})

    assert ToyRobot.perform_command("REPORT") == {:ok, "3,4,SOUTH"}
  end

  test "PLACE command with invalid position" do
    ToyRobot.perform_command("PLACE", {-2, 4, "SOUTH"})

    assert ToyRobot.perform_command("REPORT") == :noop
  end

  test "PLACE command with invalid direction" do
    ToyRobot.perform_command("PLACE", {0, 4, "SPACE"})

    assert ToyRobot.perform_command("REPORT") == :noop
  end

  test "REPORT command when robot hasn't been placed" do
    assert ToyRobot.perform_command("REPORT") == :noop
  end

  test "REPORT command when robot has been placed" do
    GameState.place(%{x: 0, y: 5, direction: "NORTH"})
    assert ToyRobot.perform_command("REPORT") == {:ok, "0,5,NORTH"}
  end

end