defmodule CaptainsLog do
  @planetary_classes ["D", "H", "J", "K", "L", "M", "N", "R", "T", "Y"]

  def random_planet_class() do
    index = :rand.uniform(length(@planetary_classes)) - 1
    Enum.at(@planetary_classes, index)
  end

  def random_ship_registry_number() do
    "NCC-#{:rand.uniform(8999) + 999}"
  end

  def random_stardate() do
    min = 41_000.0
    max = 42_000.0
    min + :rand.uniform() * (max - min)
  end

  def format_stardate(stardate) do
    :io_lib.format("~.1f", [stardate])
    |> List.to_string()
  end
end
