defmodule RobotGame.Application do
  use Application

  @impl true
  def start(_type, _args) do
    RobotGame.Supervisor.start_link(name: RobotGame.Supervisor)
  end
end