defmodule RobotGame.DirectionTest do
  use ExUnit.Case, async: true

  alias RobotGame.Direction

  test "turn 'NORTH' direction 'RIGHT'" do
    assert Direction.next_direction("NORTH", :right) == "EAST"
  end

  test "turn 'WEST' direction 'RIGHT'" do
    assert Direction.next_direction("WEST", :right) == "NORTH"
  end

  test "turn 'NORTH' direction 'LEFT'" do
    assert Direction.next_direction("NORTH", :left) == "WEST"
  end

  test "turn 'WEST' direction 'LEFT'" do
    assert Direction.next_direction("WEST", :left) == "SOUTH"
  end
end