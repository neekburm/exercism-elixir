defmodule EliudsEggs do
  import Bitwise

  @doc """
  Given the number, count the number of eggs.
  """
  @spec egg_count(number :: integer()) :: non_neg_integer()
  def egg_count(number) do
    do_egg_count(number, 0)
  end

  defp do_egg_count(0, acc), do: acc

  defp do_egg_count(n, acc) do
    acc = acc + (n &&& 1)
    do_egg_count(n >>> 1, acc)
  end
end
