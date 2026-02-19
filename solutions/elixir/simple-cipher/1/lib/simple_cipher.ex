defmodule SimpleCipher do
  @doc """
  Given a `plaintext` and `key`, encode each character of the `plaintext` by
  shifting it by the corresponding letter in the alphabet shifted by the number
  of letters represented by the `key` character, repeating the `key` if it is
  shorter than the `plaintext`.

  For example, for the letter 'd', the alphabet is rotated to become:

  defghijklmnopqrstuvwxyzabc

  You would encode the `plaintext` by taking the current letter and mapping it
  to the letter in the same position in this rotated alphabet.

  abcdefghijklmnopqrstuvwxyz
  defghijklmnopqrstuvwxyzabc

  "a" becomes "d", "t" becomes "w", etc...

  Each letter in the `plaintext` will be encoded with the alphabet of the `key`
  character in the same position. If the `key` is shorter than the `plaintext`,
  repeat the `key`.

  Example:

  plaintext = "testing"
  key = "abc"

  The key should repeat to become the same length as the text, becoming
  "abcabca". If the key is longer than the text, only use as many letters of it
  as are necessary.
  """
  def encode(plaintext, key) do
    do_cipher(plaintext, key, :asc)
  end

  @doc """
  Given a `ciphertext` and `key`, decode each character of the `ciphertext` by
  finding the corresponding letter in the alphabet shifted by the number of
  letters represented by the `key` character, repeating the `key` if it is
  shorter than the `ciphertext`.

  The same rules for key length and shifted alphabets apply as in `encode/2`,
  but you will go the opposite way, so "d" becomes "a", "w" becomes "t",
  etc..., depending on how much you shift the alphabet.
  """
  def decode(ciphertext, key) do
    do_cipher(ciphertext, key, :desc)
  end

  defp do_cipher(plaintext, key, direction) do
    char_plaintext = String.to_charlist(plaintext)
    char_key = String.to_charlist(key)

    key_shifts =
      pad_key(char_plaintext, char_key)
      |> Enum.map(&get_char_shift/1)

    Enum.zip(char_plaintext, key_shifts)
    |> Enum.map(fn {text_char, key_shift} -> shift_chars(text_char, key_shift, direction) end)
    |> List.to_string()
  end

  @doc """
  Generate a random key of a given length. It should contain lowercase letters only.
  """
  def generate_key(length) do
    Enum.map(1..length, fn _ -> Enum.random(?a..?z) end)
    |> List.to_string()
  end

  defp get_char_shift(char) when char in ?a..?z, do: char - ?a

  defp shift_chars(char, shift, :asc), do: Integer.mod(char - ?a + shift, 26) + ?a
  defp shift_chars(char, shift, :desc), do: Integer.mod(char - ?a - shift, 26) + ?a

  defp pad_key(text, key) do
    text_length = Enum.count(text)
    key_length = Enum.count(key)

    case key_length >= text_length do
      true ->
        key

      false ->
        duplications = div(text_length, key_length) + 1

        List.duplicate(key, duplications)
        |> List.flatten()
        |> Enum.take(text_length)
    end
  end
end
