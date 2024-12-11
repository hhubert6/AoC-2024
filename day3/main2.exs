defmodule Day3 do
  def scan(filename) do
    string = File.read!(filename)

    p =
      ~r/mul\(\d{1,3},\d{1,3}\)|do\(\)|don't\(\)/
      |> Regex.scan(string)
      |> Enum.join()

    p =
      Regex.split(~r/don't\(\).*?do\(\)/, p)
      |> Enum.join()

    ~r/mul\((\d{1,3}),(\d{1,3})\)/
    |> Regex.scan(p)
    |> Enum.map(fn [_, x, y] -> String.to_integer(x) * String.to_integer(y) end)
    |> Enum.sum()
    |> IO.inspect()
  end
end

Day3.scan("input.txt")
