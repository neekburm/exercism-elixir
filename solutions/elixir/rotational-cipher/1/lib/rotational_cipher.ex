defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    String.to_charlist(text)
    |> do_cipher(shift, [])
    |> List.to_string()
  end
  defp do_cipher([], _shift, acc), do: Enum.reverse(acc)
  defp do_cipher([char | tail], shift, acc) do
    cond do
      char in ?A..?Z ->
        shifted_char = rem(char - ?A + shift, 26) + ?A
        do_cipher(tail, shift, [shifted_char | acc])
      char in ?a..?z ->
        shifted_char = rem(char - ?a + shift, 26) + ?a
        do_cipher(tail, shift, [shifted_char | acc])
      true -> do_cipher(tail, shift, [char | acc])
    end
  end
end
