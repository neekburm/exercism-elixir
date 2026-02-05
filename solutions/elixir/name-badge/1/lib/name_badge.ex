defmodule NameBadge do

  def print(id, name, nil) do
    print(id, name, "owner")
  end
  def print(nil, name, department) do
    "#{name} - #{String.upcase(department)}"
  end
  def print(id, name, department) do
    "[#{id}] - #{name} - #{String.upcase(department)}"
  end
end
