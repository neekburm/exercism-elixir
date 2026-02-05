defmodule LucasNumbers do
  @moduledoc """
  Lucas numbers are an infinite sequence of numbers which build progressively
  which hold a strong correlation to the golden ratio (φ or ϕ)

  E.g.: 2, 1, 3, 4, 7, 11, 18, 29, ...
  """
  def generate(count) when is_integer(count) == false or count < 1, do: raise(ArgumentError, "count must be specified as an integer >= 1")
  def generate(count) do
    stream_do_generate(count)
  end

  def do_generate(1), do: [2]
  def do_generate(2), do: [2, 1]
  def do_generate(count) do
    acc = do_generate(count - 1)
    Enum.concat(acc, [Enum.at(acc, Enum.count(acc) - 1) + Enum.at(acc, Enum.count(acc) - 2)])
  end

  defp stream_do_generate(count) do
    Stream.unfold({2, 1}, fn {a, b} ->
      {a, {b, a + b}}
    end)
    |> Enum.take(count)
  end
end
