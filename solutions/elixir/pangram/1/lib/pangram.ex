defmodule Pangram do
  @letters MapSet.new(?a..?z)
  @doc """
  Determines if a word or sentence is a pangram.
  A pangram is a sentence using every letter of the alphabet at least once.

  Returns a boolean.

    ## Examples

      iex> Pangram.pangram?("the quick brown fox jumps over the lazy dog")
      true

  """


  @spec pangram?(String.t()) :: boolean
  def pangram?(sentence) do
    found =
      sentence
      |> String.downcase()
      |> String.to_charlist()
      |> Enum.reduce(MapSet.new(), fn ch, acc ->
        if ch in ?a..?z, do: MapSet.put(acc, ch), else: acc
      end)
    MapSet.subset?(@letters, found)
  end
end
