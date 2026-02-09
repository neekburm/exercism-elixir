defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    Regex.scan(~r/\p{L}+(?:'\p{L}+)*/, string)
    |> List.flatten()
    |> Enum.map(&String.first/1)
    |> Enum.map(&String.upcase/1)
    |> List.to_string()
  end

end
