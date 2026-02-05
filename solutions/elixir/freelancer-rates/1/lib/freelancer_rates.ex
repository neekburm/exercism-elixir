defmodule FreelancerRates do
  def daily_rate(hourly_rate) do
    8.0 * hourly_rate
  end

  def apply_discount(before_discount, discount) do
    before_discount - (before_discount * (discount / 100))
  end

  def monthly_rate(hourly_rate, discount) do
    discounted_daily = daily_rate(hourly_rate) |>
    apply_discount(discount)
    ceil(discounted_daily * 22)
  end

  def days_in_budget(budget, hourly_rate, discount) do
    discounted_daily = daily_rate(hourly_rate) |>
    apply_discount(discount)
    Float.floor(budget / discounted_daily, 1)
  end
end
