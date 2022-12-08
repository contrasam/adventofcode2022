defmodule CalorieCountingTest do
  use ExUnit.Case
  doctest CalorieCounting

  setup_all do
    {:ok, contents} = File.read("test/test-data/actual_calories.in")
    {:ok, contents: contents |> String.split("\n")}
  end

  test "top 3 max calories of actual input", state do
    top_max_elf_calories =
      state[:contents]
      |> CalorieCounting.read_raw()
      |> CalorieCounting.top_max(3)

    assert top_max_elf_calories == [75501, 70096, 69997]
  end

  test "max calories of actual input", state do
    max_elf_calories =
      state[:contents]
      |> CalorieCounting.read_raw()
      |> CalorieCounting.max()

    assert max_elf_calories == 75501
  end
end
