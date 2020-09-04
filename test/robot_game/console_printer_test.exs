defmodule RobotGame.ConsolePrinterTest do
  use ExUnit.Case, async: true
  import ExUnit.CaptureIO

  alias RobotGame.ConsolePrinter

  test "print/1 outputs message when match occurs" do
    assert capture_io(fn -> ConsolePrinter.print({:reply, "Hello there!"}) end) == "Hello there!\n"
  end

  test "print/1 outputs message when no match occurs" do
    assert capture_io(fn -> ConsolePrinter.print(:noop) end) == ""
  end
end