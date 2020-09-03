defmodule RobotGame.GameStateTest do
  use ExUnit.Case, async: true

  alias RobotGame.GameState

  test "game initialises with default board size" do
    assert GameState.board_size == %{x: 5, y: 5}
  end

  test "game initialises with no placement" do
    assert GameState.report == %{}
  end

  test "place/1 receives a map and updates state" do
    new_placement = %{x: 0, y: 2, direction: "SOUTH"}
    GameState.place(new_placement)

    assert GameState.report == new_placement
  end
end