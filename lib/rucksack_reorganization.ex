defmodule RucksackReorganization do
  defp find_matches({left, right}) do
    left
    |> String.split("", trim: true)
    |> Enum.uniq()
    |> Enum.filter(fn l1 -> String.contains?(right, l1) end)
  end

  @spec find_score(String.t()) :: integer()
  def find_score(alpha) do
    lower_case_map =
      ?a..?z |> Enum.with_index(1) |> Enum.map(fn {c, s} -> {to_string([c]), s} end) |> Map.new()

    upper_case_map =
      ?A..?Z |> Enum.with_index(27) |> Enum.map(fn {c, s} -> {to_string([c]), s} end) |> Map.new()

    score_map = Map.merge(lower_case_map, upper_case_map)

    case score_map[alpha] do
      nil -> 0
      x -> x
    end
  end

  def find_shared_items(contents) do
    contents
    |> String.split_at(round(String.length(contents) / 2))
    |> find_matches()
  end

  @spec find_common_item_in_group(String.t(), String.t(), String.t()) :: list
  def find_common_item_in_group(one, two, three) do
    one
    |> String.split("", trim: true)
    |> Enum.uniq()
    |> Enum.filter(fn x -> String.contains?(two, x) and String.contains?(three, x) end)
  end
end
