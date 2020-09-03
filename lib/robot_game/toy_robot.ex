defmodule RobotGame.ToyRobot do
  alias RobotGame.GameState

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