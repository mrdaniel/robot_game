defmodule RobotGame.Direction do
  @directions [
    {"NORTH", :move_up},
    {"EAST",  :move_right},
    {"SOUTH", :move_down},
    {"WEST",  :move_left}
  ]

  def list_directions do
    @directions |> Enum.map(fn {k, _v} -> k end)
  end

  def directions_count do
    list_directions() |> Enum.count
  end

  def next_direction(current_direction, side) do
    current_direction
    |> find_index
    |> shift_index(side)
    |> select_direction
  end

  def find_index(current_direction) do
    list_directions() |> Enum.find_index(&(&1 == current_direction))
  end

  def shift_index(index, :right) do
    do_shift_index(index + 1)
  end
  def shift_index(index, :left) do
    do_shift_index(index - 1)
  end

  defp do_shift_index(index) do
    cond do
      index_exceeded?(index, :max) -> direction_index(:first)
      index_exceeded?(index, :min) -> direction_index(:last)
      true -> index
    end
  end

  defp index_exceeded?(index, :max) do
    index >= directions_count()
  end
  defp index_exceeded?(index, :min) do
    index < 0
  end

  defp direction_index(:first), do: 0
  defp direction_index(:last) do
    directions_count() - 1
  end

  def select_direction(index) do
    list_directions() |> Enum.at(index)
  end

  def as_atom(direction) do
    {_direction, atom} =
      @directions
      |> Enum.find(fn {key, _val} ->
        key == direction
      end)

    atom
  end
end