defmodule RobotGame.ToyRobot do
  import RobotGame.PlacementValidation

  alias RobotGame.{GameState, Direction}

  def perform_command({:place, [x, y, direction]}) do
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

  def perform_command(:left), do: turn(:left)
  def perform_command(:right), do: turn(:right)

  def perform_command(:move) do
    case GameState.report do
      %{direction: _} = placement ->
        placement
        |> update_coordinates
        |> set_placement
      _ ->
        :noop
    end
  end

  def perform_command(:report) do
    case GameState.report do
      %{direction: _, x: _, y: _} = placement ->
        {:reply, format_placement(placement)}
      _ ->
        :noop
    end
  end

  def perform_command({:error, command}) do
    {:reply, "Unknown command: #{command}"}
  end

  def perform_command(_) do
    {:reply, "Unknown command"}
  end

  defp turn(side) do
    case GameState.report do
      %{direction: current_direction} = placement ->
        Direction.next_direction(current_direction, side)
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
    perform_command({:place, [placement.x, placement.y, placement.direction]})
  end

  defp format_placement(placement) do
    "#{placement.x},#{placement.y},#{placement.direction}"
  end
end