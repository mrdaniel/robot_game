defmodule RobotGame.GameState do
  use GenServer

  @default_board_size 5

  def start_link(_args) do
    GenServer.start_link(__MODULE__, @default_board_size, name: __MODULE__)
  end

  @impl true
  def init(default) do
    state = %{
      board: %{x: default, y: default},
      placement: %{}
    }

    {:ok, state}
  end

  def board do
    GenServer.call(__MODULE__, :board)
  end

  def report do
    GenServer.call(__MODULE__, :report)
  end

  def place(%{} = placement) do
    GenServer.cast(__MODULE__, {:place, placement})
  end

  @impl true
  def handle_call(:board, _from, state) do
    {:reply, state.board, state}
  end

  @impl true
  def handle_call(:report, _from, state) do
    {:reply, state.placement, state}
  end

  @impl true
  def handle_cast({:place, placement}, state) do
    {:noreply, %{state | placement: placement}}
  end
end