defmodule LibraryFees do
  def datetime_from_string(string) do
    {:ok, date_time, _} = DateTime.from_iso8601(string)
    naive_date_time = DateTime.to_naive(date_time)
    naive_date_time
  end

  def before_noon?(datetime) do
    date = NaiveDateTime.to_date(datetime)
    today_noon = NaiveDateTime.new!(date, ~T[12:00:00])
    NaiveDateTime.after?(today_noon, datetime)
  end

  def return_date(checkout_datetime) do
    days_later = case before_noon?(checkout_datetime) do
      true -> 28
      false -> 29
    end
    date = NaiveDateTime.to_date(checkout_datetime)
    Date.shift(date, day: days_later)
  end

  def days_late(planned_return_date, actual_return_datetime) do
    days_late = NaiveDateTime.diff(actual_return_datetime,NaiveDateTime.new!(planned_return_date, ~T[00:00:00]), :day)
    if days_late < 0 do
      0
    else
      days_late
    end
  end

  def monday?(datetime) do
    day_of_week = NaiveDateTime.to_date(datetime) |>
    Date.day_of_week()
    day_of_week == 1
  end

  def calculate_late_fee(checkout, return, rate) do
    checkout_datetime = datetime_from_string(checkout)
    return_datetime = datetime_from_string(return)
    expected_return_date = return_date(checkout_datetime)
    days_late = days_late(expected_return_date, return_datetime)
    case monday?(return_datetime) do
      true -> trunc(days_late * rate / 2)
      false -> trunc(days_late * rate)
    end

  end
end
