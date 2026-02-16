defmodule Gigasecond do
  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) ::
          {{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}
  def from({{year, month, day}, {hours, minutes, seconds}}) do
    {:ok, start_date} = NaiveDateTime.new(year, month, day, hours, minutes, seconds)
    end_date = NaiveDateTime.add(start_date, 1_000_000_000)
    {{end_date.year, end_date.month, end_date.day}, {end_date.hour, end_date.minute, end_date.second}}
  end
end
