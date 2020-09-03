defmodule RobotGame.GameState do
  use GenServer

  def start_link(_args) do
    default_board_size = 5
    GenServer.start_link(__MODULE__, default_board_size, name: __MODULE__)
  end

  @impl true
  def init(default_board_size) do
    state = %{
      board: %{x: default_board_size, y: default_board_size}
    }

    {:ok, state}
  end

  def board_size do
    GenServer.call(__MODULE__, :board_size)
  end

  @impl true
  def handle_call(:board_size, _from, state) do
    {:reply, state.board, state}
  end
end