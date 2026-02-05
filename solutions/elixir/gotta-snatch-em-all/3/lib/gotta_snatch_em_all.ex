defmodule GottaSnatchEmAll do
  @type card :: String.t()
  @type collection :: MapSet.t(card())

  @spec new_collection(card()) :: collection()
  def new_collection(card) do
    MapSet.new([card])
  end

  @spec add_card(card(), collection()) :: {boolean(), collection()}
  def add_card(card, collection) do
    updated_collection = MapSet.put(collection, card)
    collection_already_contains_card = MapSet.member?(collection, card)
    {collection_already_contains_card, updated_collection}
  end

  @spec trade_card(card(), card(), collection()) :: {boolean(), collection()}
  def trade_card(your_card, their_card, collection) do
    valid_trade = MapSet.member?(collection, your_card) and not MapSet.member?(collection, their_card)
    updated_collection =
      MapSet.delete(collection, your_card)
      |> MapSet.put(their_card)
    {valid_trade, updated_collection}
  end

  @spec remove_duplicates([card()]) :: [card()]
  def remove_duplicates(cards) do
    MapSet.new(cards)
    |> MapSet.to_list()
    |> Enum.sort()
  end

  @spec extra_cards(collection(), collection()) :: non_neg_integer()
  def extra_cards(your_collection, their_collection) do
    MapSet.difference(your_collection, their_collection)
    |> MapSet.size()
  end

  @spec boring_cards([collection()]) :: [card()]
  def boring_cards([]), do: []
  def boring_cards([first | rest]) do
    first_set = MapSet.new(first)
    rest
    |> Enum.reduce(first_set, fn collection, acc -> MapSet.intersection(acc, MapSet.new(collection)) end)
    |> MapSet.to_list()
    |> Enum.sort()
  end

  @spec total_cards([collection()]) :: non_neg_integer()
  def total_cards([]), do: 0
  def total_cards([first | rest]) do
    first_set = MapSet.new(first)
    rest
    |> Enum.reduce(first_set, fn collection, acc -> MapSet.union(acc, MapSet.new(collection)) end)
    |> MapSet.size()
  end

  @spec split_shiny_cards(collection()) :: {[card()], [card()]}
  def split_shiny_cards(collection) do
    {shiny, boring} = Enum.split_with(collection, fn card -> String.starts_with?(card, "Shiny") end)
    {Enum.sort(shiny), Enum.sort(boring)}
  end
end
