defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep(list, fun) do
    do_keep(list, fun, [], true)
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard(list, fun) do
    do_keep(list, fun, [], false)
  end

  defp do_keep([], fun, acc), do: acc
  defp do_keep([head | tail], fun, acc, keep?) do
    case fun(head) == keep? do
      true -> do_keep(tail, fun, [head | acc], keep?)
      false -> do_keep(tail, fun, acc, keep?)
    end
  end
end
