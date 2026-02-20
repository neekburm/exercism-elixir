defmodule Series do
  @doc """
  Finds the largest product of a given number of consecutive numbers in a given string of numbers.
  """
  @spec largest_product(String.t(), non_neg_integer) :: non_neg_integer
  def largest_product(number_string, size) do
    if String.length(number_string) < size, do: raise(ArgumentError, "size too large for such tiny string")
    number_string
    |> unfold_series(size)
    |> Enum.reduce(0, fn x, acc ->
      product = Enum.product(x)
      if product > acc, do: product, else: acc
    end)
  end

  def unfold_series(str, size) do
    String.to_integer(str)
    |> Integer.digits()
    |> Stream.unfold(fn l ->
      if length(l) >= size do
        {Enum.take(l, size), tl(l)}
      else
        nil
      end
    end)
  end
end
