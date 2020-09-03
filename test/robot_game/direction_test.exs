defmodule RobotGame.DirectionTest do
  use ExUnit.Case, async: true

  alias RobotGame.Direction

  test "turn 'NORTH' direction 'RIGHT'" do
    assert Direction.next_direction("NORTH", "RIGHT") == "EAST"
  end

  test "turn 'WEST' direction 'RIGHT'" do
    assert Direction.next_direction("WEST", "RIGHT") == "NORTH"
  end

  test "turn 'NORTH' direction 'LEFT'" do
    assert Direction.next_direction("NORTH", "LEFT") == "WEST"
  end

  test "turn 'WEST' direction 'LEFT'" do
    assert Direction.next_direction("WEST", "LEFT") == "SOUTH"
  end
end