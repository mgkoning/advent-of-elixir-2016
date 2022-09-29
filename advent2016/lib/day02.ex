defmodule Advent2016.Day02 do
  def solve(input) do
    instr_lines = read_input(input)
    IO.puts("Part 1:")
    IO.puts(List.to_string(get_code(keypad_1(), instr_lines, {1, 1})))
    IO.puts("Part 2:")
    IO.puts(List.to_string(get_code(keypad_2(), instr_lines, {1, 2})))
  end

  defp keypad_1() do
    %{
      {0,0} => "1", {1,0} => "2", {2,0} => "3",
      {0,1} => "4", {1,1} => "5", {2,1} => "6",
      {0,2} => "7", {1,2} => "8", {2,2} => "9",
    }
  end

  defp keypad_2() do
    %{
                                  {3,0} => "1",
                    {2,1} => "2", {3,1} => "3", {4,1} => "4",
      {1,2} => "5", {2,2} => "6", {3,2} => "7", {4,2} => "8", {5,2} => "9",
                    {2,3} => "A", {3,3} => "B", {4,3} => "C",
                                  {3,4} => "D"
    }
  end

  defp get_code(keypad, instr_lines, start) do
    Enum.reduce(
      instr_lines,
      [],
      fn line, cs ->
        next = Enum.reduce(
          line,
          List.first(cs, start),
          fn i, c -> next_key(i, keypad, c) end)
        [ next | cs] end)
      |> Enum.reverse()
      |> Enum.map(fn i -> Map.fetch!(keypad, i) end)
  end

  defp next_key(instr, keypad, {x, y}) do
    next = case instr do
      "U" -> {x, y-1}
      "D" -> {x, y+1}
      "L" -> {x-1, y}
      "R" -> {x+1, y}
    end
    if Map.has_key?(keypad, next) do next else {x, y} end
  end

  defp read_input(input) do
    String.split(input, "\n")
      |> Enum.map(&String.codepoints/1)
  end
end
