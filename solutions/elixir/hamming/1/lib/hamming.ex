defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance(~c"AAGTCATA", ~c"TAGCGATC")
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: {:ok, non_neg_integer} | {:error, String.t()}
  def hamming_distance(strand1, strand2) do
    compare_bases(strand1, strand2, 0)
  end

  defp compare_bases([], [], acc), do: {:ok, acc}
  defp compare_bases(_strand1, [], _acc), do: {:error, "strands must be of equal length"}
  defp compare_bases([], _strand2, _acc), do: {:error, "strands must be of equal length"}
  defp compare_bases([char1 | tail1], [char2 | tail2], acc) do
    case char1 == char2 do
      true -> compare_bases(tail1, tail2, acc)
      false -> compare_bases(tail1, tail2, acc + 1)
    end
  end
end
