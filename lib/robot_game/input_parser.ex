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
    case parse_arguments(arguments) do
      {:ok, argument_list} ->
        {atomise_command(command), argument_list}
      _ ->
        {:error, Enum.join([command, arguments], " ")}
    end
  end
  defp do_parse(list) do
    {:error, Enum.join(list, " ")}
  end

  defp parse_arguments(arguments) do
    case String.split(arguments, ",") do
      [x, y, direction] ->
        try do
          argument_list = [
            String.to_integer(x),
            String.to_integer(y),
            String.upcase(direction)
          ]

          {:ok, argument_list}
        rescue
          ArgumentError -> :error
        end
      _argument_list -> :error
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