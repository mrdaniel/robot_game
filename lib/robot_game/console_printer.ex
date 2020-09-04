defmodule RobotGame.ConsolePrinter do
  def print(output) do
    case output do
      {:reply, msg} -> IO.puts msg
      _ -> :noop
    end
  end
end