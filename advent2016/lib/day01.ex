defmodule Advent2016.Day01 do
  defmodule Instruction, do: defstruct [:lr, :distance]

  defimpl String.Chars, for: Instruction do
    @spec to_string(%Advent2016.Day01.Instruction{}) :: binary
    def to_string(value) do
      %{lr: lr, distance: distance} = value
      "#{lr}#{distance}"
    end
  end

  @spec solve(binary) :: :ok
  def solve(input) do
    instructions = read_input(input)
    start = {0, 0}
    facing = {0, -1}
    {{x, y}, _, visited} = instructions
      |> Enum.reduce({start, facing, [start]}, &next_location/2)
    IO.puts("Part 1:")
    IO.puts(abs(x) + abs(y))
    IO.puts("Part 2:")
    case first_duplicate(visited) do
      {:ok, {x, y}} -> IO.puts(abs(x) + abs(y))
      {:error, _cause} -> IO.puts("No match?")
    end
  end

  defp first_duplicate(values) do
    # can't nest defp, so using a work around (passing the recursing function as argument)
    first_duplicate_inner = fn
      ([head | rest], seen, recur) ->
        if MapSet.member?(seen, head) do
          {:ok, head}
        else
          recur.(rest, MapSet.put(seen, head), recur)
        end
      ([], _seen, _) -> {:error, "None matched"}
    end
    first_duplicate_inner.(values, MapSet.new(), first_duplicate_inner)
  end

  defp next_location(i, acc) do
    %{lr: lr, distance: distance} = i
    {{x, y}, facing, visited} = acc
    new_facing = case {lr, facing} do
      {"R", {0, -1}} -> {1, 0}
      {"R", {1, 0}} -> {0, 1}
      {"R", {0, 1}} -> {-1, 0}
      {"R", {-1, 0}} -> {0, -1}
      {"L", {0, -1}} -> {-1, 0}
      {"L", {1, 0}} -> {0, -1}
      {"L", {0, 1}} -> {1, 0}
      {"L", {-1, 0}} -> {0, 1}
    end
    {dx, dy} = new_facing
    new_visited = Enum.map(1..distance, fn d -> {x + dx * d, y + dy * d} end)
    {List.last(new_visited), new_facing, visited ++ new_visited}
  end

  defp read_input(input), do: String.split(input) |> Enum.map(&to_instruction/1)

  defp to_instruction(value) do
    {lr, distance} = String.trim(value, ",") |> String.split_at(1)
    %Instruction{lr: lr, distance: String.to_integer(distance)}
  end

end
