defmodule Day4 do
  def part_one(filename) do
    data =
      File.read!(filename)
      |> String.split("\n", trim: true)
      |> Enum.map(&String.split(&1, "", trim: true))

    data =
      for {row, y} <- Enum.with_index(data),
          {char, x} <- Enum.with_index(row),
          into: %{},
          do: {{y, x}, char}

    Map.keys(data)
    |> Enum.reduce(0, &(&2 + check(data, &1)))
  end

  def part_two(filename) do
    data =
      File.read!(filename)
      |> String.split("\n", trim: true)
      |> Enum.map(&String.split(&1, "", trim: true))

    data =
      for {row, y} <- Enum.with_index(data),
          {char, x} <- Enum.with_index(row),
          into: %{},
          do: {{y, x}, char}

    Map.keys(data)
    |> Enum.count(&(data[&1] == "A" and check_X(data, &1)))
  end

  defp check(data, pos) do
    case data[pos] do
      "X" -> gen_directions() |> Enum.count(&check_dir(data, pos, &1))
      _ -> 0
    end
  end

  defp check_dir(data, {sy, sx}, {dy, dx}) do
    "XMAS" ==
      Stream.iterate({sy, sx}, fn {y, x} -> {y + dy, x + dx} end)
      |> Stream.take(4)
      |> Enum.map(&data[&1])
      |> Enum.join()
  end

  defp gen_directions(),
    do: for(dx <- -1..1, dy <- -1..1, {dx, dy} != {0, 0}, do: {dx, dy})

  defp check_X(data, {y, x}) do
    s1 =
      [data[{y - 1, x - 1}], data[{y, x}], data[{y + 1, x + 1}]]
      |> Enum.join()

    s2 =
      [data[{y + 1, x - 1}], data[{y, x}], data[{y - 1, x + 1}]]
      |> Enum.join()

    (s1 == "MAS" or s1 == "SAM") and (s2 == "SAM" or s2 == "MAS")
  end
end

Day4.part_one("input.txt")
|> IO.inspect()

Day4.part_two("input.txt")
|> IO.inspect()
