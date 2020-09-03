defmodule RobotGame.GameStateTest do
  use ExUnit.Case, async: true

  test "game starts with default board size" do
    assert RobotGame.GameState.board_size == %{x: 5, y: 5}
  end
end