defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(s, size) when byte_size(s) < size or size < 1, do: []
  def slices(s, size) do
    do_slice(s, size, [])
    |> Enum.reverse()
  end

  defp do_slice(s, size, acc) when byte_size(s) < size, do: acc
  defp do_slice(s, size, acc) do
    <<head::binary-size(size), _tail::binary>> = s
    <<_h, next_segment::binary>> = s
    do_slice(next_segment, size, [head | acc])
  end
end
