defmodule ArmstrongNumber do
  @moduledoc """
  Provides a way to validate whether or not a number is an Armstrong number
  """

  @spec valid?(integer) :: boolean
  def valid?(number) do
    number == armstrong_number(number)
  end

  defp armstrong_number(number) do
    digits = Integer.digits(number)
    count_digits = Enum.count(digits)
    Enum.reduce(digits, 0, fn digit, acc -> acc + Integer.pow(digit, count_digits) end)
  end
end
