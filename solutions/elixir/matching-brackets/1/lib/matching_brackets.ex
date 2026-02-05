defmodule MatchingBrackets do
  @bracket_matches %{
    ?) => ?(,
    ?] => ?[,
    ?} => ?{
  }
  @opening Map.values(@bracket_matches)
  @closing Map.keys(@bracket_matches)
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str) do
    str
    |> String.to_charlist()
    |> do_check_brackets([])
  end

  defp do_check_brackets([], []), do: true
  defp do_check_brackets([], _), do: false
  defp do_check_brackets([bracket | tail], stack) when bracket in @opening, do: do_check_brackets(tail, [bracket | stack])
  defp do_check_brackets([ch | _tail], []) when ch in @closing, do: false

  defp do_check_brackets([bracket | tail], [top | stack]) when bracket in @closing do
    case Map.get(@bracket_matches, bracket) do
      ^top -> do_check_brackets(tail, stack)
      _ -> false
    end
  end
  defp do_check_brackets([_bracket | tail], stack) , do: do_check_brackets(tail, stack)
end
