defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    Enum.filter(candidates, &anagram?(&1, base))
  end

  defp anagram?(candidate, word) do
    normalize = fn s ->
      s
      |> String.downcase()
      |> String.graphemes()
      |> Enum.sort()
    end
    String.downcase(candidate) != String.downcase(word) and normalize.(candidate) == normalize.(word)
  end
end
