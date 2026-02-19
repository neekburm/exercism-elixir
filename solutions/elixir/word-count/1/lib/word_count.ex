defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    words = get_cleaned_words(sentence)
    Enum.reduce(words, %{}, fn word, acc ->
      case Map.get(acc, word) do
        nil -> Map.put(acc, word, 1)
        count -> Map.put(acc, word, count + 1)
      end
    end)
  end

  def get_cleaned_words(sentence) do
    sentence
    |> String.replace(~r/[_,]/u, " ")
    |> String.replace(~r/[^\p{L}\p{N}\s']/u, "")
    |> String.replace(~r/(?<!\p{L})'|'(?!\p{L})/u, "")
    |> String.downcase()
    |> String.split(~r/\s+/u, trim: true)
  end
end
