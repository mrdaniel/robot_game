defmodule RobotGame.ConsolePrinter do
  def print(output) do
    case output do
      {:ok, msg} -> IO.puts msg
      _ -> :noop
    end
  end
end