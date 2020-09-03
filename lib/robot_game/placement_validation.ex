defmodule RobotGame.PlacementValidation do

  def direction_valid?(direction, directions) do
    Enum.member?(directions, direction)
  end

  def axis_valid?(integer, max) do
    integer >= 0 && integer < max
  end
end