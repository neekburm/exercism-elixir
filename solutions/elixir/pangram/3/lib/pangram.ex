defmodule Pangram do
  import Bitwise
  @letters (1 <<< 26) - 1
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
    sentence
    |> String.downcase()
    |> String.to_charlist()
    |> Enum.reduce_while(0, fn ch, mask ->
      if ch in ?a..?z do
        bit = 1 <<< (ch - ?a)
        mask2 = mask ||| bit
        if mask2 == @letters, do: {:halt, mask2}, else: {:cont, mask2}
      else
        {:cont, mask}
      end
    end)
    |> Kernel.==(@letters)
  end
end
