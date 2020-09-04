defmodule RobotGame.ToyRobotTest do
  use ExUnit.Case, async: true

  alias RobotGame.{GameState, ToyRobot}

  setup do
    start_supervised(GameState)
    :ok
  end

  test "PLACE command with valid arguments" do
    ToyRobot.perform_command({:place, [3, 4, "SOUTH"]})

    assert ToyRobot.perform_command(:report) == {:reply, "3,4,SOUTH"}
  end

  test "PLACE command with invalid position" do
    ToyRobot.perform_command({:place, [-2, 4, "SOUTH"]})

    assert ToyRobot.perform_command(:report) == :noop
  end

  test "PLACE command with invalid direction" do
    ToyRobot.perform_command({:place, [0, 4, "SPACE"]})

    assert ToyRobot.perform_command(:report) == :noop
  end

  test "LEFT command when no placement present" do
    assert ToyRobot.perform_command(:left) == :noop
  end

  test "LEFT command when placement present" do
    ToyRobot.perform_command({:place, [3, 4, "SOUTH"]})
    ToyRobot.perform_command(:left)

    assert ToyRobot.perform_command(:report) == {:reply, "3,4,EAST"}
  end

  test "RIGHT command when no placement present" do
    assert ToyRobot.perform_command(:right) == :noop
  end

  test "RIGHT command when placement present" do
    ToyRobot.perform_command({:place, [3, 4, "SOUTH"]})
    ToyRobot.perform_command(:right)

    assert ToyRobot.perform_command(:report) == {:reply, "3,4,WEST"}
  end

  test "MOVE command when valid" do
    ToyRobot.perform_command({:place, [0, 0, "EAST"]})
    ToyRobot.perform_command(:move)

    assert ToyRobot.perform_command(:report) == {:reply, "1,0,EAST"}
  end

  test "MOVE command when invalid" do
    ToyRobot.perform_command({:place, [4, 4, "NORTH"]})
    ToyRobot.perform_command(:move)

    assert ToyRobot.perform_command(:report) == {:reply, "4,4,NORTH"}
  end

  test "REPORT command when robot hasn't been placed" do
    assert ToyRobot.perform_command(:report) == :noop
  end

  test "REPORT command when robot has been placed" do
    GameState.place(%{x: 0, y: 5, direction: "NORTH"})
    assert ToyRobot.perform_command(:report) == {:reply, "0,5,NORTH"}
  end

  test "Return error message for unkown command" do
    assert ToyRobot.perform_command({:error, "FOOBAR"}) == {:reply, "Unkown command: FOOBAR"}
  end

  test "Return error message for blank command" do
    assert ToyRobot.perform_command("") == {:reply, "Unkown command"}
  end
end