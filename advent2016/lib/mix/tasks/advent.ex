defmodule Mix.Tasks.Advent do
  use Mix.Task

  @impl Mix.Task
  def run(args) do
    Advent2016.main(args)
  end
end
