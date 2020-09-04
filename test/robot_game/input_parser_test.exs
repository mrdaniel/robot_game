defmodule RobotGame.InputParserTest do
  use ExUnit.Case, async: true

  alias RobotGame.InputParser

  test "parse/1 for single command" do
    assert InputParser.parse("MOVE\n") == :move
  end

  test "parse/1 for command with valid arguments" do
    assert InputParser.parse("PLACE 1,0,NORTH\n") == {:place, [1, 0, "NORTH"]}
  end

  test "parse/1 for command with invalid arguments" do
    assert InputParser.parse("PLACE 1,2\n") == {:error, "PLACE 1,2"}
  end

  test "parse/1 for single unknown command" do
    assert InputParser.parse("FOOBAR\n") == {:error, "FOOBAR"}
  end

  test "parse/1 for multiple unknown commands" do
    assert InputParser.parse("FOOBAR sdff sdfdf\n") == {:error, "FOOBAR sdff sdfdf"}
  end
end