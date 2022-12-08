defmodule CampCleanup do
  @spec contains?({integer(), integer()}, {integer(), integer()}) :: boolean()
  def contains?({a, b}, {c, d}) do
    (a >= c and b <= d) or (c >= a and d <= b)
  end

  @spec overlaps?({integer(), integer()}, {integer(), integer()}) :: boolean()
  def overlaps?({a, b}, {c, d}) do
    not Range.disjoint?(a..b, c..d)
  end

  @spec parse_raw_pair(String.t()) :: list({integer(), integer()})
  def parse_raw_pair(pair_line) do
    pair_line
    |> String.split(",")
    |> Enum.map(fn range ->
      range |> String.split("-") |> Enum.map(&String.to_integer(&1)) |> List.to_tuple()
    end)
  end
end
