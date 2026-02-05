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
    do_numeral(number, @roman_map, [])
    |> Enum.reverse()
    |> IO.iodata_to_binary()
  end

  defp do_numeral(0, _rules, acc), do: acc
  defp do_numeral(number, [{value, symbol} | tail], acc) do
    case number >= value do
      true -> do_numeral(number - value, [{value, symbol} | tail], [symbol | acc])
      false -> do_numeral(number, tail, acc)
    end
  end
end
