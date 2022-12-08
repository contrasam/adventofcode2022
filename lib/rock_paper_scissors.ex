defmodule RockPaperScissors do
  @spec play_round({:rock | :paper | :scissors, :rock | :paper | :scissors}) ::
          {integer(), integer()}
  def play_round({x, y}) do
    case {x, y} do
      {:rock, :rock} -> {4, 4}
      {:rock, :paper} -> {1, 8}
      {:rock, :scissors} -> {7, 3}
      {:paper, :rock} -> {8, 1}
      {:paper, :paper} -> {5, 5}
      {:paper, :scissors} -> {2, 9}
      {:scissors, :rock} -> {3, 7}
      {:scissors, :paper} -> {9, 2}
      {:scissors, :scissors} -> {6, 6}
    end
  end

  @spec play_rounds(list({:rock | :paper | :scissors, :rock | :paper | :scissors})) :: %{
          opponent: integer(),
          me: integer()
        }
  def play_rounds(rounds) when is_list(rounds) do
    rounds
    |> Enum.map(&play_round(&1))
    |> Enum.reduce(%{opponent: 0, me: 0}, fn {x, y}, totals ->
      %{opponent: totals[:opponent] + x, me: totals[:me] + y}
    end)
  end

  @spec parse_shape(String.t()) :: :paper | :rock | :scissors
  def parse_shape(alpha) do
    cond do
      alpha == "X" or alpha == "A" -> :rock
      alpha == "Y" or alpha == "B" -> :paper
      alpha == "Z" or alpha == "C" -> :scissors
    end
  end
end
