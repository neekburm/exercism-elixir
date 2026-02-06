defmodule ResistorColorTrio do
  @doc """
  Calculate the resistance value in ohms from resistor colors
  """
  @color_map %{
    black: 0,
    brown: 1,
    red: 2,
    orange: 3,
    yellow: 4,
    green: 5,
    blue: 6,
    violet: 7,
    grey: 8,
    white: 9
  }

  @spec label(colors :: [atom]) :: {number, :ohms | :kiloohms | :megaohms | :gigaohms}
  def label(colors) do
    [band_1, band_2, band_3 | _tail] = colors
    ohms = process_colors([band_2, band_1], 0, 0)
    exponent = get_color_exponent(band_3)
    reduce_ohms(ohms * exponent)
  end

  def get_color_exponent(color) do
    exponent = Map.fetch!(@color_map, color)
    10 ** exponent
  end

  def process_colors([], acc, _cycles), do: acc
  def process_colors([head | tail], acc, cycles) do
    with {:ok, color_value} <- Map.fetch(@color_map, head) do
      process_colors(tail, acc + (color_value * 10**cycles), cycles + 1)
    else
      {:error, _} -> process_colors(tail, acc, cycles)
    end
  end

  def reduce_ohms(ohms) do
    scales = [
      {1_000_000_000, :gigaohms},
      {1_000_000, :megaohms},
      {1_000, :kiloohms}
    ]

    case Enum.find(scales, fn {scale, _unit} ->
           value = div(ohms, scale)
           value > 0 and value < 1000
         end) do
      {scale, unit} ->
        {div(ohms, scale), unit}

      nil ->
        {ohms, :ohms}
    end
  end
end
