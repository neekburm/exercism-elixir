defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t()
  def convert(number) do
    []
    |> maybe_add(rem(number, 7) == 0, "Plong")
    |> maybe_add(rem(number, 5) == 0, "Plang")
    |> maybe_add(rem(number, 3) == 0, "Pling")
    |> case do
      [] -> Integer.to_string(number)
      parts -> Enum.join(parts)
    end

  end

  defp maybe_add(list, true, word), do: [word | list]
  defp maybe_add(list, false, _word), do: list
end
