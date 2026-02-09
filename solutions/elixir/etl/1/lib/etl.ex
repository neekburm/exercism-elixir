defmodule ETL do
  @doc """
  Transforms an old Scrabble score system to a new one.

  ## Examples

    iex> ETL.transform(%{1 => ["A", "E"], 2 => ["D", "G"]})
    %{"a" => 1, "d" => 2, "e" => 1, "g" => 2}
  """
  @spec transform(map) :: map
  def transform(input) do
    output_map = %{}
    Map.to_list(input)
    |> Enum.reduce(%{}, fn {score, letters}, acc ->
      Enum.reduce(letters, acc, fn letter, acc2 -> Map.put(acc2, String.downcase(letter), score) end)
    end)
  end
end
