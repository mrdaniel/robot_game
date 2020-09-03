defmodule RobotGame.PlacementValidationTest do
  use ExUnit.Case, async: true

  alias RobotGame.PlacementValidation

  test "direction_valid?/2 with valid direction" do
    directions = ["NORTH", "EAST"]
    assert PlacementValidation.direction_valid?("NORTH", directions) == true
  end

  test "direction_valid?/2 with invalid direction" do
    directions = ["NORTH", "EAST"]
    assert PlacementValidation.direction_valid?("WEST", directions) == false
  end

  test "axis_valid?/2 with valid integer" do
    assert PlacementValidation.axis_valid?(3, 5) == true
  end

  test "axis_valid?/2 with invalid integer" do
    assert PlacementValidation.axis_valid?(5, 5) == false
  end
end