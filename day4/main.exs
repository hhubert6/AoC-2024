defmodule Day4 do
  def search(filename) do
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
end

Day4.search("input.txt")
|> IO.inspect()
