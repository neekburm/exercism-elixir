defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday ::
          :monday
          | :tuesday
          | :wednesday
          | :thursday
          | :friday
          | :saturday
          | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @week_map %{
    first: 1,
    second: 2,
    third: 3,
    fourth: 4
  }
  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: Date.t()
  def meetup(year, month, weekday, schedule) do
    get_date(year, month, weekday, schedule)
  end

  defp get_date(year, month, weekday, :teenth) do
    thirteenth = Date.new!(year, month, 13)
    alleged_date = Date.beginning_of_week(thirteenth, weekday)

    if Date.before?(alleged_date, thirteenth),
      do: Date.shift(alleged_date, day: 7),
      else: alleged_date
  end

  defp get_date(year, month, weekday, :last) do
    last_of_month =
      Date.new!(year, month, 1)
      |> Date.end_of_month()

    alleged_first_weekday = Date.beginning_of_week(last_of_month, weekday)

    if Date.after?(alleged_first_weekday, last_of_month),
      do: Date.shift(alleged_first_weekday, day: -7),
      else: alleged_first_weekday
  end

  defp get_date(year, month, weekday, week) do
    first_of_month = Date.new!(year, month, 1)
    alleged_first_weekday = Date.beginning_of_week(first_of_month, weekday)

    first_weekday_of_month =
      if Date.before?(alleged_first_weekday, first_of_month),
        do: Date.shift(alleged_first_weekday, day: 7),
        else: alleged_first_weekday

    Date.shift(first_weekday_of_month, day: 7 * (Map.fetch!(@week_map, week) - 1))
  end
end
