defmodule BasketballWebsite do
  def extract_from_path(data, path) do
    keys = String.split(path, ".", trim: true)
    do_extract(data, keys)
  end
  defp do_extract(value, []), do: value
  defp do_extract(nil, _keys), do: nil
  defp do_extract(value, [key | rest]) do
    do_extract(value[key], rest)
  end

  def get_in_path(data, path) do
    keys = String.split(path, ".", trim: true)
    Kernel.get_in(data, keys)
  end
end
