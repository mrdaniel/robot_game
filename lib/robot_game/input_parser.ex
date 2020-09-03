defmodule RobotGame.InputParser do
  def parse(string) do
    string
    |> String.trim
    |> String.upcase
    |> String.split(" ")
    |> do_parse
  end

  defp do_parse([command]), do: command
  defp do_parse([command, arguments]) do
    [x, y, direction] = arguments |> String.split(",")

    {
      command,
      {
        String.to_integer(x),
        String.to_integer(y),
        String.upcase(direction)
      }
    }
  end
end