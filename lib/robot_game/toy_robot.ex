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
        new_direction = Direction.turn(current_direction, side)
        perform_command("PLACE", {placement.x, placement.y, new_direction})
      _ ->
        :noop
    end
  end

  defp format_placement(placement) do
    "#{placement.x},#{placement.y},#{placement.direction}"
  end
end