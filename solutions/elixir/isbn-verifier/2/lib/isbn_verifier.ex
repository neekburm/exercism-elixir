defmodule IsbnVerifier do
  @doc """
    Checks if a string is a valid ISBN-10 identifier

    ## Examples

      iex> IsbnVerifier.isbn?("3-598-21507-X")
      true

      iex> IsbnVerifier.isbn?("3-598-2K507-0")
      false

  """
  @spec isbn?(String.t()) :: boolean
  def isbn?(isbn) do
    isbn_list =
      isbn
      |> String.to_charlist()
      |> Enum.map(&parse_isbn_char/1)
      |> Enum.reject(fn x -> x == nil end)

    case valid_isbn?(isbn_list) do
      true ->
        isbn_list
        |> Enum.zip(10..1//-1)
        |> Enum.reduce(0, fn {digit, check_digit}, acc ->
          digit * check_digit + acc
        end)
        |> Integer.mod(11)
        |> Kernel.==(0)

      false ->
        false
    end
  end

  defp parse_isbn_char(?X), do: 10
  defp parse_isbn_char(char) when char in ?0..?9, do: List.to_integer([char])
  defp parse_isbn_char(?\-), do: nil
  defp parse_isbn_char(char), do: char

  defp valid_isbn?(isbn_numbers) do
    ten_location = Enum.find_index(isbn_numbers, fn x -> x == 10 end)

    Enum.all?(isbn_numbers, fn x -> x in 0..10 end)
    and (ten_location == 9 or ten_location == nil)
    and Enum.count(isbn_numbers) == 10
  end
end
