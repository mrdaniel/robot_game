defmodule RobotGame.ToyRobot do
  import RobotGame.PlacementValidation

  alias RobotGame.{GameState, Direction}

  def perform_command("PLACE", {x, y, direction}) do
    board = GameState.board
    direction_list = Direction.list_directions

    with true <- axis_valid?(x, board.x),
         true <- axis_valid?(y, board.y),
         true <- direction_valid?(direction, direction_list)
    do
      GameState.place(%{x: x, y: y, direction: direction})
    else
      _ -> :noop
    end
  end

  def perform_command("LEFT"), do: turn("LEFT")
  def perform_command("RIGHT"), do: turn("RIGHT")

  def perform_command("MOVE") do
    case GameState.report do
      %{direction: _} = placement ->
        placement
        |> update_coordinates
        |> set_placement
      _ ->
        :noop
    end
  end

  def perform_command("REPORT") do
    case GameState.report do
      %{direction: _, x: _, y: _} = placement ->
        {:ok, format_placement(placement)}
      _ ->
        :noop
    end
  end

  defp turn(side) do
    case GameState.report do
      %{direction: current_direction} = placement ->
        Direction.turn(current_direction, side)
        |> update_direction(placement)
        |> set_placement
      _ ->
        :noop
    end
  end

  defp update_coordinates(%{x: x, y: y, direction: direction} = placement) do
    case Direction.as_atom(direction) do
      :move_up    -> %{placement | y: y + 1}
      :move_right -> %{placement | x: x + 1}
      :move_down  -> %{placement | y: y - 1}
      :move_left  -> %{placement | x: x - 1}
    end
  end

  defp update_direction(new_direction, placement) do
    %{placement | direction: new_direction}
  end

  defp set_placement(placement) do
    perform_command("PLACE", {placement.x, placement.y, placement.direction})
  end

  defp format_placement(placement) do
    "#{placement.x},#{placement.y},#{placement.direction}"
  end
end