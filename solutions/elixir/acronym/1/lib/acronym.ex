defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    Regex.scan(~r/\p{L}+(?:'\p{L}+)*/, string)
    |> List.flatten()
    |> Enum.map(fn word -> String.first(word) end)
    |> Enum.map(fn first_letter -> String.upcase(first_letter) end)
    |> List.to_string()
  end

end
