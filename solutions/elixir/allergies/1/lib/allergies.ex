defmodule Allergies do
  import Bitwise
    @allergies [
      {0b00000001, "eggs"},
      {0b00000010, "peanuts"},
      {0b00000100, "shellfish"},
      {0b00001000, "strawberries"},
      {0b00010000, "tomatoes"},
      {0b00100000, "chocolate"},
      {0b01000000, "pollen"},
      {0b10000000, "cats"}
    ]
  @doc """
  List the allergies for which the corresponding flag bit is true.
  """
  @spec list(non_neg_integer) :: [String.t()]
  def list(flags) do
    Enum.reduce(@allergies, [], fn {mask, allergy}, acc ->
      case (mask &&& flags) != 0 do
        true -> [allergy | acc]
        false -> acc
      end
    end)
  end

  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t()) :: boolean
  def allergic_to?(flags, item) do
    {mask, allergy} = Enum.find(@allergies, fn {mask, allergy} -> allergy == item end)
    (mask &&& flags) != 0
  end
end
