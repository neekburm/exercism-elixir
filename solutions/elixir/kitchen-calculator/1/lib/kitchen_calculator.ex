defmodule KitchenCalculator do
  def get_volume({_unit, volume}) do
    volume
  end

  def to_milliliter({unit, volume}) do
    cond do
      unit == :cup -> {:milliliter, volume * 240}
      unit == :fluid_ounce -> {:milliliter, volume * 30}
      unit == :teaspoon -> {:milliliter, volume * 5}
      unit == :tablespoon -> {:milliliter, volume * 15}
      unit == :milliliter -> {:milliliter, volume}
    end
  end

  def from_milliliter(volume_pair, unit) do
    {:milliliter, milliliters} = to_milliliter(volume_pair)
    cond do
      unit == :cup -> {unit, milliliters / 240}
      unit == :fluid_ounce -> {unit, milliliters / 30}
      unit == :teaspoon -> {unit, milliliters / 5}
      unit == :tablespoon -> {unit, milliliters / 15}
      unit == :milliliter -> {unit, milliliters}

    end
  end

  def convert(volume_pair, unit) do
    converted_volume_pair = to_milliliter(volume_pair)
    from_milliliter(converted_volume_pair, unit)
  end
end
