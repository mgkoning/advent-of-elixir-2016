defmodule Advent2016 do
  def main(args) do
    case determine_day(args) do
      {:error, reason} -> IO.puts(reason)
      {:ok, day} -> run_day(day)
    end
  end

  @days %{
    1 => &Advent2016.Day01.solve/1,
    2 => &Advent2016.Day02.solve/1
  }

  defp run_day(day) do
    case Map.get(@days, day) do
      nil -> IO.puts("Day #{day} not (yet) supported")
      runner ->
        dayStr = String.pad_leading("#{day}", 2, "0")
        file_name = "../input/day#{dayStr}.txt"
        case File.read(file_name) do
          {:ok, input} -> runner.(input)
          {:error, reason} ->
            IO.puts("Could not run due to: ")
            IO.puts(:file.format_error(reason))
        end
    end
  end

  defp determine_day(args) do
    case args do
      [] -> case DateTime.now("Europe/Amsterdam", Tz.TimeZoneDatabase) do
        {:ok, %DateTime{day: day}} -> {:ok, day}
        other -> other
      end
      [hd | _] -> case Integer.parse(hd) do
        {i, _} -> {:ok, i}
        :error -> {:error, "Please supply a day as the first argument"}
      end
    end
  end
end
