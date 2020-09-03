defmodule RobotGame.Direction do
  @directions ["NORTH", "EAST", "SOUTH", "WEST"]
  
  def list_directions do
    @directions
  end

  def directions_count do
    @directions |> Enum.count
  end

  def turn(current_direction, side) do
    current_direction
    |> find_index
    |> shift_index(side)
    |> select_direction
  end

  def find_index(current_direction) do
    @directions |> Enum.find_index(&(&1 == current_direction))
  end

  def shift_index(index, "RIGHT") do
    do_shift_index(index + 1)
  end
  def shift_index(index, "LEFT") do
    do_shift_index(index - 1)
  end

  defp do_shift_index(index) do
    cond do
      index == directions_count() -> 0
      index < 0 -> directions_count() - 1
      true -> index
    end
  end

  def select_direction(index) do
    @directions |> Enum.at(index)
  end
end