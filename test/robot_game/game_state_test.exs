defmodule RobotGame.GameStateTest do
  use ExUnit.Case, async: true

  alias RobotGame.GameState

  test "game initialises with default board size" do
    assert GameState.board == %{x: 5, y: 5}
  end

  test "place/1 receives a map and updates state" do
    assert GameState.report == %{}

    new_placement = %{x: 0, y: 2, direction: "SOUTH"}
    GameState.place(new_placement)

    assert GameState.report == new_placement
  end
end