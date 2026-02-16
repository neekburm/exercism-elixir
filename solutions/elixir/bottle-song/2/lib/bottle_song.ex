defmodule BottleSong do
  @moduledoc """
  Handles lyrics of the popular children song: Ten Green Bottles
  """

  @spec recite(pos_integer, pos_integer) :: String.t()
  def recite(start_bottle, take_down) do
    start_bottle..start_bottle - take_down + 1//-1
    |> Enum.map(&verse/1)
    |> Enum.join("\n\n")
  end

  defp verse(start_bottle) do
    start_bottle_word = number_to_word(start_bottle)
    next_bottle = number_to_word(start_bottle - 1)
    """
    #{String.capitalize(start_bottle_word)} green #{pluralize_bottle(start_bottle)} hanging on the wall,
    #{String.capitalize(start_bottle_word)} green #{pluralize_bottle(start_bottle)} hanging on the wall,
    And if one green bottle should accidentally fall,
    There'll be #{next_bottle} green #{pluralize_bottle(start_bottle - 1)} hanging on the wall.\
    """
  end

  defp number_to_word(0), do: "no"
  defp number_to_word(1), do: "one"
  defp number_to_word(2), do: "two"
  defp number_to_word(3), do: "three"
  defp number_to_word(4), do: "four"
  defp number_to_word(5), do: "five"
  defp number_to_word(6), do: "six"
  defp number_to_word(7), do: "seven"
  defp number_to_word(8), do: "eight"
  defp number_to_word(9), do: "nine"
  defp number_to_word(10), do: "ten"

  defp pluralize_bottle(1), do: "bottle"
  defp pluralize_bottle(_), do: "bottles"
end
