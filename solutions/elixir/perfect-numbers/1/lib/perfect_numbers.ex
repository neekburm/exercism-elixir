defmodule PerfectNumbers do
  @doc """
  Determine the aliquot sum of the given `number`, by summing all the factors
  of `number`, aside from `number` itself.

  Based on this sum, classify the number as:

  :perfect if the aliquot sum is equal to `number`
  :abundant if the aliquot sum is greater than `number`
  :deficient if the aliquot sum is less than `number`
  """
  @spec classify(number :: integer) :: {:ok, atom} | {:error, String.t()}
  def classify(number) when number < 1, do: {:error, "Classification is only possible for natural numbers."}
  def classify(number) do
    factors_sum =
      get_factors(number)
      |> Enum.sum()
    cond do
      factors_sum == number -> {:ok, :perfect}
      factors_sum > number -> {:ok, :abundant}
      factors_sum < number -> {:ok, :deficient}
     end
  end

  defp get_factors(n) do
    1..round(:math.sqrt(n))
    |> Enum.filter(fn x -> rem(n, x) == 0 end)
    |> Enum.flat_map(fn i ->
      if div(n, i) == i, do: [i], else: [i, div(n, i)]
    end)
    |> Enum.reject(fn x -> x == n end)
  end
end
