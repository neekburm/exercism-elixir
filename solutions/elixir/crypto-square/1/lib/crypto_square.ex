defmodule CryptoSquare do
  @doc """
  Encode string square methods
  ## Examples

    iex> CryptoSquare.encode("abcd")
    "ac bd"
  """
  @spec encode(String.t()) :: String.t()
  def encode(str) do
    normalized_chars =
      str
      |> normalize_text()
      |> String.to_charlist()
    len = Enum.count(normalized_chars)

    if normalized_chars == [] do
      ""
    else
      columns =
        normalized_chars
        |> Enum.count()
        |> :math.sqrt()
        |> ceil()
      rows = if columns * (columns - 1) >= len, do: columns - 1, else: columns
      padded_chars = pad_to_length(normalized_chars, columns * rows)

      Enum.chunk_every(padded_chars, columns)
      |> Enum.zip()
      |> Enum.map(&Tuple.to_list/1)
      |> Enum.join(" ")
    end
  end

  def normalize_text(text) do
    text
    |> get_cleaned_words()
    |> Enum.join()
  end

  defp get_cleaned_words(sentence) do
    sentence
    |> String.replace(~r/[_,]/u, " ")
    |> String.replace(~r/[^\p{L}\p{N}\s']/u, "")
    |> String.replace(~r/(?<!\p{L})'|'(?!\p{L})/u, "")
    |> String.downcase()
    |> String.split(~r/\s+/u, trim: true)
  end

  def pad_to_length(chars, desired_length) do
    padding = max(desired_length - length(chars), 0)
    chars ++ List.duplicate(?\s, padding)
  end
end
