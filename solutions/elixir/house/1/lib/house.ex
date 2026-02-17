defmodule House do
  @doc """
  Return verses of the nursery rhyme 'This is the House that Jack Built'.
  """
  @spec recite(start :: integer, stop :: integer) :: String.t()
  def recite(start, stop) do
    Enum.map(start..stop, fn x -> recite_verse(x) end)
    |> Enum.join()
  end

  defp recite_verse(1), do: "This is " <> phrase(1)
  defp recite_verse(n) do
    Enum.reduce(n..1//-1, "This is ", fn v, acc ->
      acc <> phrase(v)
    end)
  end

  defp phrase(1), do: "the house that Jack built.\n"
  defp phrase(2), do: "the malt that lay in "
  defp phrase(3), do: "the rat that ate "
  defp phrase(4), do: "the cat that killed "
  defp phrase(5), do: "the dog that worried "
  defp phrase(6), do: "the cow with the crumpled horn that tossed "
  defp phrase(7), do: "the maiden all forlorn that milked "
  defp phrase(8), do: "the man all tattered and torn that kissed "
  defp phrase(9), do: "the priest all shaven and shorn that married "
  defp phrase(10), do: "the rooster that crowed in the morn that woke "
  defp phrase(11), do: "the farmer sowing his corn that kept "
  defp phrase(12), do: "the horse and the hound and the horn that belonged to "
end
