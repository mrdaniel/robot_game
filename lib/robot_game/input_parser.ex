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
    argument_list = arguments |> String.split(",")

    case arguments_valid?(argument_list) do
      true ->
        [x, y, direction] = argument_list

        {
          atomise_command(command),
          [
            String.to_integer(x),
            String.to_integer(y),
            String.upcase(direction)
          ]
        }
      false ->
        {:error, Enum.join([command, arguments], " ")}
    end
  end
  defp do_parse(list) do
    {:error, Enum.join(list, " ")}
  end

  defp arguments_valid?(arguments) do
    case arguments do
      [_x, _y, _direction] -> true
      _ -> false
    end
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