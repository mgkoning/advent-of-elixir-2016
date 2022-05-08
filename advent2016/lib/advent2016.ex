defmodule Advent2016 do
  def main(_args) do
    case File.read("../input/day01.txt") do
      {:ok, input} -> Advent2016.Day01.solve(input)
      {:error, reason} ->
        IO.puts("Could not run due to: ")
        IO.puts(:file.format_error(reason))
    end
  end
end
