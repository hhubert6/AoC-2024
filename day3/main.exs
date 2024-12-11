defmodule Day3 do
  def scan(filename) do
    ~r/mul\((\d{1,3}),(\d{1,3})\)/
    |> Regex.scan(File.read!(filename))
    |> Enum.map(fn [_, x, y] -> String.to_integer(x) * String.to_integer(y) end)
    |> Enum.sum()
    |> IO.inspect()
  end
end

Day3.scan("input.txt")
