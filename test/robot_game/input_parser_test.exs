defmodule RobotGame.InputParserTest do
  use ExUnit.Case, async: true

  alias RobotGame.InputParser

  test "parse/1 for single command" do
    assert InputParser.parse("MOVE\n") == "MOVE"
  end

  test "parse/1 for command with arguments" do
    assert InputParser.parse("PLACE 1,0,NORTH\n") == {"PLACE", {1,0,"NORTH"}}
  end
end