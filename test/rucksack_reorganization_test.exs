defmodule RucksackReorganizationTest do
  use ExUnit.Case
  doctest RucksackReorganization

  setup_all do
    {:ok, contents} = File.read("test/test-data/actual_rucksack_contents.in")
    {:ok, contents: contents |> String.split("\n")}
  end

  test "find shared items and calculate score", state do
    sum_of_scores =
      state[:contents]
      |> Enum.flat_map(&RucksackReorganization.find_shared_items(&1))
      |> Enum.map(&RucksackReorganization.find_score(&1))
      |> Enum.sum()

    assert sum_of_scores == 8109
  end

  test "find common items in elf group and calculate score", state do
    sum_of_scores =
      state[:contents]
      |> Enum.chunk_every(3)
      |> Enum.flat_map(fn [one, two, three] ->
        RucksackReorganization.find_common_item_in_group(one, two, three)
      end)
      |> Enum.map(&RucksackReorganization.find_score(&1))
      |> Enum.sum()

    assert sum_of_scores == 2738
  end
end
