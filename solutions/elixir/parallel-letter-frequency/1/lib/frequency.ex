defmodule Frequency do

  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t()], pos_integer) :: map
  def frequency(texts, workers) do
   count_batched_quick(texts, workers)
  end

  defp count_string(str) do
    str
    |> get_cleaned_words()
    |> String.graphemes()
    |> Enum.frequencies()
  end

  defp get_cleaned_words(sentence) do
    sentence
    |> String.downcase()
    |> String.replace(~r/[\p{N}\p{P}\s]/u, "")
  end

  defp count_batched_quick(texts, workers) do
    texts
    |> Task.async_stream(&count_string/1,
      max_concurrency: workers,
      ordered: false,
      timeout: 30_000
    )
    |> Enum.reduce(%{}, fn {:ok, m}, acc -> Map.merge(acc, m, fn _k, v1, v2 -> v1 + v2 end) end)
  end
end
