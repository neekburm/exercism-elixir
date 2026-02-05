defmodule RomanNumerals do
  @roman_map [
    {1000, "M"},
    {900, "CM"},
    {500, "D"},
    {400, "CD"},
    {100, "C"},
    {90, "XC"},
    {50, "L"},
    {40, "XL"},
    {10, "X"},
    {9, "IX"},
    {5, "V"},
    {4, "IV"},
    {1, "I"}
  ]
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    reduce_to_roman_numerals(number)
  end

  defp reduce_to_roman_numerals(number) do
    {result, _} =
      Enum.reduce(@roman_map, {[], number}, fn {value, symbol}, {acc, remaining_number} ->
        count = div(remaining_number, value)
        acc = List.duplicate(symbol, count) ++ acc
        {acc, rem(remaining_number, value)}
      end)

    result
    |> Enum.reverse()
    |> IO.iodata_to_binary()
  end
end
