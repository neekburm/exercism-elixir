defmodule AllYourBase do
  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}
  def convert(_digits, input_base, _output_base) when input_base < 2,
    do: {:error, "input base must be >= 2"}

  def convert(_digits, _input_base, output_base) when output_base < 2,
    do: {:error, "output base must be >= 2"}

  def convert(digits, input_base, output_base) do
    with {:ok, base_10_number} <- convert_to_base_10(digits, input_base),
         {:ok, output_list} <- convert_to_new_base(base_10_number, output_base) do
      {:ok, output_list}
    else
      {:error, message} -> {:error, message}
    end
  end

  defp convert_to_base_10(digits, input_base) do
    digits
    |> Enum.reverse()
    |> Enum.with_index(fn element, index -> {element, index} end)
    |> Enum.reduce_while(0, fn {digit, power}, acc ->
      cond do
        digit < 0 or digit >= input_base ->
          {:halt, {:error, "all digits must be >= 0 and < input base"}}

        true ->
          {:cont, digit * Integer.pow(input_base, power) + acc}
      end
    end)
    |> case do
      {:error, _} = err -> err
      n -> {:ok, n}
    end
  end

  defp convert_to_new_base(base_10_number, output_base) do
    power = max_power(base_10_number, output_base)

    digit_list =
      get_digit(base_10_number, output_base, power, [])
      |> Enum.reverse()

    {:ok, digit_list}
  end

  defp get_digit(_base_10_number, _output_base, power, acc) when power < 0, do: acc

  defp get_digit(base_10_number, output_base, power, acc) do
    divisor = Integer.pow(output_base, power)
    q = div(base_10_number, divisor)
    r = rem(base_10_number, divisor)
    get_digit(r, output_base, power - 1, [q | acc])
  end

  defp max_power(n, base, p \\ 0) do
    if Integer.pow(base, p + 1) <= n do
      max_power(n, base, p + 1)
    else
      p
    end
  end
end
