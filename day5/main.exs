defmodule Day5 do
  def part_one(filename) do
    [rules, updates] =
      File.read!(filename)
      |> String.split("\n\n")
      |> Enum.map(&String.split(&1, "\n", trim: true))

    rules = parse_rules(rules)

    updates
    |> Stream.map(&parse_update/1)
    |> Stream.filter(&validate_update(&1, rules))
    |> Stream.map(&Enum.at(&1, div(length(&1), 2)))
    |> Stream.map(fn {page, _} -> String.to_integer(page) end)
    |> Enum.sum()
  end

  defp parse_rules(rules) do
    rules
    |> Stream.map(&String.split(&1, "|"))
    |> Enum.reduce(%{}, fn [before_page, after_page], acc ->
      Map.update(acc, before_page, MapSet.new([after_page]), fn set ->
        MapSet.put(set, after_page)
      end)
    end)
  end

  defp parse_update(update) do
    {update, _} =
      update
      |> String.split(",")
      |> Enum.map_reduce(MapSet.new(), fn page, acc ->
        {{page, acc}, MapSet.put(acc, page)}
      end)

    update
  end

  defp validate_update(update, rules) do
    update
    |> Enum.all?(fn {page, pages_before} ->
      MapSet.size(MapSet.intersection(pages_before, Map.get(rules, page, MapSet.new()))) == 0
    end)
  end
end

Day5.part_one("input.txt")
|> IO.inspect()
