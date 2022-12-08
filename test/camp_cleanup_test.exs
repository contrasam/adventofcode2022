defmodule CampCleanupTest do
  use ExUnit.Case
  doctest CampCleanup

  setup_all do
    {:ok, contents} = File.read("test/test-data/actual_camp_assignment.in")
    {:ok, contents: contents |> String.split("\n")}
  end

  test "find if range is contained in another range" do
    range1 = {2, 4}
    range2 = {1, 6}
    assert CampCleanup.contains?(range1, range2) == true
  end

  test "find contained ranges from actual input", state do
    out =
      state[:contents]
      |> Enum.map(&CampCleanup.parse_raw_pair(&1))
      |> Enum.map(&List.to_tuple(&1))
      |> Enum.map(fn {range1, range2} -> CampCleanup.contains?(range1, range2) end)
      |> Enum.filter(& &1)

    assert length(out) == 431
  end

  test "find overlapped ranges from actual input", state do
    out =
      state[:contents]
      |> Enum.map(&CampCleanup.parse_raw_pair(&1))
      |> Enum.map(&List.to_tuple(&1))
      |> Enum.map(fn {range1, range2} -> CampCleanup.overlaps?(range1, range2) end)
      |> Enum.filter(& &1)

    assert length(out) == 823
  end
end
