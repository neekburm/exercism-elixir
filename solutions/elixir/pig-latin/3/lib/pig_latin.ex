defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split()
    |> Enum.map(&convert_word_to_pig_latin/1)
    |> Enum.join(" ")
  end

  defp convert_word_to_pig_latin(word) do
    chars = String.to_charlist(word)
    [first, second | _rest] = chars

    cond do
      first in ~c"aeiou" ->
        add_ay(word)

      [first, second] == ~c"xr" ->
        add_ay(word)

      [first, second] == ~c"yt" ->
        add_ay(word)

      consonants_then_qu?(word) ->
        shift_qu(word)

        consonants_then_y?(word) ->
        shift_y(word)

      first not in ~c"aeiou" ->
        shift_consonants(word)
        |> add_ay()

    end
  end

  defp vowel?(c) when c in ?a..?z do
    c in ~c"aeiou"
  end

  defp consonants_then_qu?(word) do
    regex = ~r/\A[bcdfghjklmnpqrstvwxz]*qu[a-z]*\z/
    Regex.match?(regex, word)
  end

  defp consonants_then_y?(word) do
    regex = ~r/\A[bcdfghjklmnpqrstvwxz]+y[a-z]*\z/
    Regex.match?(regex, word)
  end

  defp shift_qu(word) do
    [pre_qu, post_qu] = String.split(word, "qu", parts: 2)
    post_qu <> pre_qu <> "quay"
  end

  defp shift_y(word) do
    [pre_y, post_y] = String.split(word, "y", parts: 2)
    "y" <> post_y <> pre_y <> "ay"
  end

  defp add_ay(word) do
    word <> "ay"
  end

  defp shift_consonants(word) do
    chars = String.to_charlist(word)
    split_index = Enum.find_index(chars, &vowel?/1)
    {first_consonants, rest} = Enum.split(chars, split_index)
    [rest | first_consonants]
    |> List.to_string()
  end
end
