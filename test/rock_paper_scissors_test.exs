defmodule RockPaperScissorsTest do
  use ExUnit.Case
  doctest RockPaperScissors

  setup_all do
    {:ok, contents} = File.read("test/test-data/actual_rps_guide.in")
    {:ok, contents: contents |> String.split("\n")}
  end

  test "play rounds to calculate score", state do
    scores =
      state[:contents]
      |> Enum.map(fn line ->
        String.split(line) |> Enum.map(&RockPaperScissors.parse_shape(&1))
      end)
      |> Enum.map(&List.to_tuple(&1))
      |> RockPaperScissors.play_rounds()

    assert scores == %{opponent: 11170, me: 13565}
  end

  test "play rounds to calculate score with new strategy", state do
    apply_new_elf_strategy = fn [x, y] ->
      case [x, y] do
        ["A", "X"] -> ["A", "Z"]
        ["C", "X"] -> ["C", "Y"]
        ["A", "Y"] -> ["A", "X"]
        ["C", "Y"] -> ["C", "Z"]
        ["A", "Z"] -> ["A", "Y"]
        ["C", "Z"] -> ["C", "X"]
        _ -> [x, y]
      end
    end

    scores =
      state[:contents]
      |> Enum.map(fn line ->
        String.split(line)
        |> apply_new_elf_strategy.()
        |> Enum.map(&RockPaperScissors.parse_shape(&1))
      end)
      |> Enum.map(&List.to_tuple(&1))
      |> RockPaperScissors.play_rounds()

    assert scores == %{opponent: 12019, me: 12424}
  end
end
