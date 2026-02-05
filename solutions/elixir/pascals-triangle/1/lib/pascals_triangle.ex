defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(num) do
    Enum.reduce(1..num, [], fn
      1, _ ->
        [[1]]

      _, [last_row | _] = acc ->
        next_row =
          Enum.zip([0 | last_row], last_row ++ [0])
          |> Enum.map(fn {a, b} -> a + b end)

        [next_row | acc]
    end)
    |> Enum.reverse()
  end
end
