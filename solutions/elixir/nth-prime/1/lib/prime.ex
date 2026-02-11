defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(n) when is_integer(n) and n >= 1 do
    {prime, _primes, _count} =
      Stream.iterate(2, &next_candidate/1)
      |> Enum.reduce_while({nil, [], 0}, fn cand, {_, primes, count} ->
        if prime_with_known?(cand, primes) do
          next_count = count + 1
          updated_primes = [cand | primes]

          if next_count == n do
            {:halt, {cand, updated_primes, next_count}}
          else
            {:cont, {nil, updated_primes, next_count}}
          end
        else
          {:cont, {nil, primes, count}}
        end
      end)
    prime
  end

  def nth(_), do: raise(ArgumentError, "n must be >= 1")

  defp next_candidate(2), do: 3
  defp next_candidate(x), do: x + 2

  defp prime_with_known?(2, _), do: true
  defp prime_with_known?(x, _) when x < 2 or rem(x, 2) == 0, do: false

  defp prime_with_known?(x, primes) do
    primes
    |> Enum.reverse()
    |> Enum.reduce_while(true, fn p, _ ->
      cond do
        p * p > x -> {:halt, true}
        rem(x, p) == 0 -> {:halt, false}
        true -> {:cont, true}
      end
    end)
  end
end
