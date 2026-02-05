defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    Enum.sort(inventory, fn x, y -> Map.get(x, :price) <= Map.get(y, :price) end)
  end

  def with_missing_price(inventory) do
    Enum.filter(inventory, fn x -> Map.get(x, :price) == nil end)
  end

  def update_names(inventory, old_word, new_word) do
    Enum.map(inventory, &Map.update!(&1, :name, fn name ->
      String.replace(name, old_word, new_word)
    end))
  end

  def increase_quantity(item, count) do
    updated_quantites = item.quantity_by_size
    |> Enum.map(fn {size, qty} -> {size, qty + count} end)
    |> Map.new()
    %{item | quantity_by_size: updated_quantites}
  end

  def total_quantity(item) do
    Enum.reduce(item.quantity_by_size, 0, fn {_size, qty}, acc -> acc + qty end)
  end
end
