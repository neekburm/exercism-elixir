defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t()) :: boolean
  def isogram?(sentence) do
    sentence_list =
      sentence
      |> String.downcase()
      |> String.to_charlist()
      |> Enum.reject(fn x -> x in [?\-, ?\s] end)
    sentence_set = MapSet.new(sentence_list)
    Enum.count(sentence_list) == Enum.count(sentence_set)
  end
end
