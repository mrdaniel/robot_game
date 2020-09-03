defmodule RobotGame.ToyRobot do
  import RobotGame.PlacementValidation

  alias RobotGame.GameState

  @directions ["NORTH", "EAST", "SOUTH", "WEST"]

  def perform_command("PLACE", {x, y, direction}) do
    board = GameState.board

    with true <- axis_valid?(x, board.x),
         true <- axis_valid?(y, board.y),
         true <- direction_valid?(direction, @directions)
    do
      GameState.place(%{x: x, y: y, direction: direction})
    else
      _ -> :noop
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

  defp format_placement(placement) do
    [
      placement.x |> to_string,
      placement.y |> to_string,
      placement.direction
    ]
    |> Enum.join(",")
  end
end