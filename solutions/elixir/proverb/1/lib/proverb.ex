defmodule Proverb do
  @doc """
  Generate a proverb from a list of strings.
  """
  @spec recite(strings :: [String.t()]) :: String.t()
  def recite([]), do: ""
  def recite(strings) do
    strings
    |> do_recite("")
    |> Kernel.<>("And all for the want of a #{List.first(strings)}.\n")
  end

  defp do_recite([first], acc), do: acc
  defp do_recite([first, second | tail], acc) do
    do_recite([second | tail], acc <> "For want of a #{first} the #{second} was lost.\n")
  end
end
