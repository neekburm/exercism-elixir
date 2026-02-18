defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number) do
    do_factors(number, 2, [])
  end

  defp do_factors(1, _divisor, acc), do: Enum.reverse(acc)
  defp do_factors(n, divisor, acc) when divisor * divisor > n do
    Enum.reverse([n | acc])
  end
  defp do_factors(n, divisor, acc) when rem(n, divisor) == 0 do
    do_factors(div(n, divisor), divisor, [divisor | acc])
  end
  defp do_factors(n, 2, acc) do
    do_factors(n, 3, acc)
  end
  defp do_factors(n, divisor, acc) do
    do_factors(n, divisor + 2, acc)
  end
end
