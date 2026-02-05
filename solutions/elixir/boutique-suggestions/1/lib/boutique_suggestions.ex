defmodule BoutiqueSuggestions do
  @default_maximum_price 100
  def get_combinations(tops, bottoms, options \\ []) do
    maximum_price = options[:maximum_price] || @default_maximum_price
    for t <- tops,
        b <- bottoms,
        t.base_color != b.base_color
        and t.price + b.price <= maximum_price do
          {t, b}
        end
  end
end
