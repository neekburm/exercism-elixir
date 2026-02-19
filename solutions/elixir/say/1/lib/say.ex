defmodule Say do
  @doc """
  Translate a positive integer into English.
  """
  @spec in_english(integer) :: {atom, String.t()}
  def in_english(number) when number in 0..999_999_999_999 do
    formatted_number = number_to_io(number)
    |> IO.iodata_to_binary()
    {:ok, formatted_number}
  end
  def in_english(_), do: {:error, "number is out of range"}

  defp number_to_io(0), do: "zero"
  defp number_to_io(1), do: "one"
  defp number_to_io(2), do: "two"
  defp number_to_io(3), do: "three"
  defp number_to_io(4), do: "four"
  defp number_to_io(5), do: "five"
  defp number_to_io(6), do: "six"
  defp number_to_io(7), do: "seven"
  defp number_to_io(8), do: "eight"
  defp number_to_io(9), do: "nine"
  defp number_to_io(10), do: "ten"
  defp number_to_io(11), do: "eleven"
  defp number_to_io(12), do: "twelve"
  defp number_to_io(13), do: "thirteen"
  defp number_to_io(14), do: "fourteen"
  defp number_to_io(15), do: "fifteen"
  defp number_to_io(16), do: "sixteen"
  defp number_to_io(17), do: "seventeen"
  defp number_to_io(18), do: "eighteen"
  defp number_to_io(19), do: "nineteen"
  defp number_to_io(20), do: "twenty"
  defp number_to_io(30), do: "thirty"
  defp number_to_io(40), do: "forty"
  defp number_to_io(50), do: "fifty"
  defp number_to_io(60), do: "sixty"
  defp number_to_io(70), do: "seventy"
  defp number_to_io(80), do: "eighty"
  defp number_to_io(90), do: "ninety"

  defp number_to_io(n) when n < 100 do
    number = div(n, 10) * 10
    remainder = rem(n, 10)
    format(number, "", "-", remainder)
  end

  defp number_to_io(n) when n < 1000 do
    number = div(n, 100)
    remainder = rem(n, 100)
    format(number, " hundred", " ", remainder)
  end

  ~w[thousand million billion]
  |> Enum.zip(Stream.unfold(1000, fn acc -> {acc, acc * 1000} end))
  |> Enum.each(fn {suffix, m} ->
    defp number_to_io(n) when n < unquote(m) * 1000 do
      number = div(n, unquote(m))
      remainder = rem(n, unquote(m))
      format(number, " " <> unquote(suffix), " ", remainder)
    end
  end)

  defp format(number, suffix, _separator, 0), do: [number_to_io(number) | suffix]
  defp format(number, suffix, separator, remainder), do: [number_to_io(number), suffix, separator | number_to_io(remainder)]
end
