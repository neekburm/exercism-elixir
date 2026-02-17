defmodule School do
  @moduledoc """
  Simulate students in a school.

  Each student is in a grade.
  """
  defstruct roster: MapSet.new(), grades: %{}

  @type school :: %__MODULE__{}

  @doc """
  Create a new, empty school.
  """
  @spec new() :: school
  def new() do
    %__MODULE__{}
  end

  @doc """
  Add a student to a particular grade in school.
  """
  @spec add(school, String.t(), integer) :: {:ok | :error, school}
  def add(%__MODULE__{roster: roster} = school, name, grade) do
    if MapSet.member?(roster, name) do
      {:error, school}
    else
      updated_grades =
        Map.update(school.grades, grade, MapSet.new([name]), fn set ->
          MapSet.put(set, name)
        end)

      {:ok, %__MODULE__{school | roster: MapSet.put(roster, name), grades: updated_grades}}
    end
  end

  @doc """
  Return the names of the students in a particular grade, sorted alphabetically.
  """
  @spec grade(school, integer) :: [String.t()]
  def grade(school, grade) do
    Map.get(school.grades, grade, MapSet.new())
    |> MapSet.to_list()
    |> Enum.sort()
  end

  @doc """
  Return the names of all the students in the school sorted by grade and name.
  """
  @spec roster(school) :: [String.t()]
  def roster(%__MODULE__{grades: grades}) do
    grades
    |> Enum.sort_by(fn {grade, _roster} -> grade end)
    |> Enum.flat_map(fn {_grade, roster} -> roster |> MapSet.to_list() |> Enum.sort() end)
  end
end
