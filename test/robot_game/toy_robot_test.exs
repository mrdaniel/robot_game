defmodule RobotGame.ToyRobotTest do
  use ExUnit.Case, async: true

  alias RobotGame.{GameState, ToyRobot}

  setup do
    start_supervised(GameState)
    :ok
  end

  test "PLACE command with valid arguments" do
    ToyRobot.perform_command({"PLACE", {3, 4, "SOUTH"}})

    assert ToyRobot.perform_command("REPORT") == {:ok, "3,4,SOUTH"}
  end

  test "PLACE command with invalid position" do
    ToyRobot.perform_command({"PLACE", {-2, 4, "SOUTH"}})

    assert ToyRobot.perform_command("REPORT") == :noop
  end

  test "PLACE command with invalid direction" do
    ToyRobot.perform_command({"PLACE", {0, 4, "SPACE"}})

    assert ToyRobot.perform_command("REPORT") == :noop
  end

  test "LEFT command when no placement present" do
    assert ToyRobot.perform_command("LEFT") == :noop
  end

  test "LEFT command when placement present" do
    ToyRobot.perform_command({"PLACE", {3, 4, "SOUTH"}})
    ToyRobot.perform_command("LEFT")

    assert ToyRobot.perform_command("REPORT") == {:ok, "3,4,EAST"}
  end

  test "RIGHT command when no placement present" do
    assert ToyRobot.perform_command("RIGHT") == :noop
  end

  test "RIGHT command when placement present" do
    ToyRobot.perform_command({"PLACE", {3, 4, "SOUTH"}})
    ToyRobot.perform_command("RIGHT")

    assert ToyRobot.perform_command("REPORT") == {:ok, "3,4,WEST"}
  end

  test "MOVE command when valid" do
    ToyRobot.perform_command({"PLACE", {0, 0, "EAST"}})
    ToyRobot.perform_command("MOVE")

    assert ToyRobot.perform_command("REPORT") == {:ok, "1,0,EAST"}
  end

  test "MOVE command when invalid" do
    ToyRobot.perform_command({"PLACE", {4, 4, "NORTH"}})
    ToyRobot.perform_command("MOVE")

    assert ToyRobot.perform_command("REPORT") == {:ok, "4,4,NORTH"}
  end

  test "REPORT command when robot hasn't been placed" do
    assert ToyRobot.perform_command("REPORT") == :noop
  end

  test "REPORT command when robot has been placed" do
    GameState.place(%{x: 0, y: 5, direction: "NORTH"})
    assert ToyRobot.perform_command("REPORT") == {:ok, "0,5,NORTH"}
  end

  describe "instruction examples" do
    test "example a" do
      ToyRobot.perform_command({"PLACE", {0, 0, "NORTH"}})
      ToyRobot.perform_command("MOVE")

      assert ToyRobot.perform_command("REPORT") == {:ok, "0,1,NORTH"}
    end

    test "example b" do
      ToyRobot.perform_command({"PLACE", {0, 0, "NORTH"}})
      ToyRobot.perform_command("LEFT")

      assert ToyRobot.perform_command("REPORT") == {:ok, "0,0,WEST"}
    end

    test "example c" do
      ToyRobot.perform_command({"PLACE", {1, 2, "EAST"}})
      ToyRobot.perform_command("MOVE")
      ToyRobot.perform_command("MOVE")
      ToyRobot.perform_command("LEFT")
      ToyRobot.perform_command("MOVE")

      assert ToyRobot.perform_command("REPORT") == {:ok, "3,3,NORTH"}
    end
  end
end