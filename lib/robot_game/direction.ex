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

  def shift_index(index, "RIGHT") do
    do_shift_index(index + 1)
  end
  def shift_index(index, "LEFT") do
    do_shift_index(index - 1)
  end

  defp do_shift_index(index) do
    cond do
      index_exceeded_max?(index) -> first_item_index()
      index_exceeded_min?(index) -> last_item_index()
      true -> index
    end
  end

  defp index_exceeded_max?(index) do
    index >= directions_count()
  end

  defp index_exceeded_min?(index) do
    index < 0
  end

  defp first_item_index, do: 0

  defp last_item_index do
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