defmodule RobotGame.InputParser do
  def parse(string) do
    string
    |> String.trim
    |> String.split(" ")
    |> do_parse
  end

  defp do_parse([command]) do
    command |> atomise_command
  end
  defp do_parse([command, arguments]) do
    [x, y, direction] = arguments |> String.split(",")

    {
      atomise_command(command),
      [
        String.to_integer(x),
        String.to_integer(y),
        String.upcase(direction)
      ]
    }
  end

  defp atomise_command(command) do
    try do
      command
      |> String.downcase
      |> String.to_existing_atom
    rescue
      ArgumentError -> {:error, command}
    end
  end
end