defmodule RobotGame do
  alias RobotGame.{InputParser, ToyRobot, ConsolePrinter}

  def instructions do
    """

    ------------------------------------------------------
    Welcome to the toy robot game!
    Initialised default 5x5 square board

    Available commands:
    * PLACE X,Y,DIRECTION (to start the game)
    * LEFT
    * RIGHT
    * MOVE
    * REPORT
    ------------------------------------------------------
    """
  end

  def await_user_input do
    input = IO.gets ""

    input
    |> InputParser.parse
    |> ToyRobot.perform_command()
    |> ConsolePrinter.print

    await_user_input()
  end
end