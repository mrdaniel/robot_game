defmodule RobotGame.Supervisor do
  use Supervisor

  def start_link(_opts) do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  @impl true
  def init([]) do
    children = []

    Supervisor.init(children, strategy: :one_for_one)
  end
end