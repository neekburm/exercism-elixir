defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    energy_point_series = Enum.map(factors, fn f -> create_series(limit, f) end)
    |> List.flatten()
    |> MapSet.new()
    |> Enum.sum()
  end

  defp create_series(limit, factor) when factor < 1, do: [0]
  defp create_series(limit, factor) do
    Enum.filter(1..limit - 1, fn x -> rem(x, factor) == 0 end)
  end
end
