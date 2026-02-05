defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    do_numeral(number, "")
  end

  def do_numeral(0, acc), do: acc
  def do_numeral(remaining_number, acc) do
    cond do
      div(remaining_number, 1000) > 0 ->
        do_numeral(remaining_number - 1000, acc <> "M")
      div(remaining_number, 900) > 0 ->
        do_numeral(remaining_number - 900, acc <> "CM")
      div(remaining_number, 500) > 0 ->
        do_numeral(remaining_number - 500, acc <> "D")
      div(remaining_number, 400) > 0 ->
        do_numeral(remaining_number - 400, acc <> "CD")
      div(remaining_number, 100) > 0 ->
        do_numeral(remaining_number - 100, acc <> "C")
      div(remaining_number, 90) > 0 ->
        do_numeral(remaining_number - 90, acc <> "XC")
      div(remaining_number, 50) > 0 ->
        do_numeral(remaining_number - 50, acc <> "L")
      div(remaining_number, 40) > 0 ->
        do_numeral(remaining_number - 40, acc <> "XL")
      div(remaining_number, 10) > 0 ->
        do_numeral(remaining_number - 10, acc <> "X")
      div(remaining_number, 9) > 0 ->
        do_numeral(remaining_number - 9, acc <> "IX")
      div(remaining_number, 5) > 0 ->
        do_numeral(remaining_number - 5, acc <> "V")
      div(remaining_number, 4) > 0 ->
        do_numeral(remaining_number - 4, acc <> "IV")
      div(remaining_number, 1) > 0 ->
        do_numeral(remaining_number - 1, acc <> "I")
    end
  end
end
