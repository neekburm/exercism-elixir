defmodule LanguageList do
  def new() do
    []
  end

  def add(list, language) do
    [language | list]
  end

  def remove(list) do
    [_deleted | return_list] = list
    return_list
  end

  def first(list) do
    List.first(list)
  end

  def count(list) do
    Enum.count(list)
  end

  def functional_list?(list) do
    Enum.find(list, fn x -> x == "Elixir" end)
  end
end
