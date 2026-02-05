defmodule BirdCount do
  @busy_day_bird_count 5
  def today(list) do
    List.first(list)
  end

  def increment_day_count([]), do: [1]
  def increment_day_count(list) do
    [today | tail] = list
    [today + 1 | tail]
  end

  def has_day_without_birds?(list) do
    Enum.any?(list, fn x -> x == 0 end)
  end

  def total(list) do
    Enum.sum((list))
  end

  def busy_days(list) do
    Enum.reduce(list, 0, fn
      (x, acc) when x >= @busy_day_bird_count -> acc + 1
      (_x, acc) -> acc
    end)
  end
end
