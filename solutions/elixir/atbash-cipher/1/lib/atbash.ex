defmodule Atbash do
  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  @spec encode(String.t()) :: String.t()
  def encode(plaintext) do
    plaintext
    |> String.downcase()
    |> String.to_charlist()
    |> Enum.filter(fn char -> char in ?a..?z or char in ?0..?9 end)
    |> Enum.map(&encode_char/1)
    |> Enum.chunk_every(5)
    |> Enum.intersperse([?\s])
    |> IO.iodata_to_binary()
  end

  @spec decode(String.t()) :: String.t()
  def decode(cipher) do
    cipher
    |> String.to_charlist()
    |> Enum.reject(fn char -> char == ?\s end)
    |> Enum.map(&encode_char/1)
    |> List.to_string()
  end

  def encode_char(char) when char in ?a..?z, do: ?z - (char - ?a)
  def encode_char(char), do: char
end
