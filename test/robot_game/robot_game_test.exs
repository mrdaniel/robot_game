defmodule RobotGameTest do
  use ExUnit.Case, async: true
  import ExUnit.CaptureIO

  alias RobotGame.{GameState, InputParser, ToyRobot, ConsolePrinter}

  setup do
    start_supervised(GameState)
    :ok
  end

  describe "instruction examples" do
    test "example a" do
      "PLACE 0,0,NORTH" |> InputParser.parse |> ToyRobot.perform_command
      "MOVE" |> InputParser.parse |> ToyRobot.perform_command

      assert capture_io(fn ->
        "REPORT"
        |> InputParser.parse
        |> ToyRobot.perform_command
        |> ConsolePrinter.print
      end) == "0,1,NORTH\n"
    end

    test "example b" do
      "PLACE 0,0,NORTH" |> InputParser.parse |> ToyRobot.perform_command
      "LEFT" |> InputParser.parse |> ToyRobot.perform_command

      assert capture_io(fn ->
        "REPORT"
        |> InputParser.parse
        |> ToyRobot.perform_command
        |> ConsolePrinter.print
      end) == "0,0,WEST\n"
    end

    test "example c" do
      "PLACE 1,2,EAST" |> InputParser.parse |> ToyRobot.perform_command
      "MOVE" |> InputParser.parse |> ToyRobot.perform_command
      "MOVE" |> InputParser.parse |> ToyRobot.perform_command
      "LEFT" |> InputParser.parse |> ToyRobot.perform_command
      "MOVE" |> InputParser.parse |> ToyRobot.perform_command

      assert capture_io(fn ->
        "REPORT"
        |> InputParser.parse
        |> ToyRobot.perform_command
        |> ConsolePrinter.print
      end) == "3,3,NORTH\n"
    end
  end
end