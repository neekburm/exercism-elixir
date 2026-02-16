defmodule Sublist do
  @type list_type() :: :equal | :sublist | :superlist | :unequal
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  @spec compare(list, list) :: list_type()
  def compare(a, b) do
    cond do
      a == b -> :equal
      sublist?(a, b) -> :sublist
      sublist?(b, a) -> :superlist
      true -> :unequal
    end
  end

  defp sublist?(_small, []), do: false
  defp sublist?([], _big), do: true

  defp sublist?(small, big) do
    big
    |> tails()
    |> Enum.any?(&List.starts_with?(&1, small))
  end

  defp tails(list),
    do:
      Stream.unfold(list, fn
        [] -> nil
        [_ | t] = l -> {l, t}
      end)
end
