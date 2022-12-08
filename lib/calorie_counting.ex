defmodule CalorieCounting do
  @spec max(list(integer())) :: integer()
  def max(elves_calories_list) when is_list(elves_calories_list) do
    elves_calories_list
    |> Enum.map(&Enum.sum(&1))
    |> Enum.max()
  end

  @spec top_max(list(integer()), integer) :: list(integer())
  def top_max(elves_calories_list, count \\ 1) when is_list(elves_calories_list) do
    elves_calories_list
    |> Enum.map(&Enum.sum(&1))
    |> Enum.sort(:desc)
    |> Enum.take(count)
  end

  @spec read_raw(list(String.t())) :: list(integer())
  def read_raw(raw_list) when is_list(raw_list) do
    raw_list
    |> Enum.reduce([[]], fn x, acc ->
      if x == "" do
        [[]] ++ acc
      else
        [y | ys] = acc
        [y ++ [x]] ++ ys
      end
    end)
    |> Enum.map(fn elf_calories ->
      elf_calories |> Enum.map(&String.to_integer(&1))
    end)
  end
end
