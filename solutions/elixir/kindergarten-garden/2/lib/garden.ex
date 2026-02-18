defmodule Garden do
  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
    garden_info = Garden.info("VC\nRC")
    assert garden_info.alice == {:violets, :clover, :radishes, :clover}
  """
  @students [:alice, :bob, :charlie, :david, :eve, :fred, :ginny, :harriet, :ileana, :joseph, :kincaid, :larry]
  @plants %{
    ?V => :violets,
    ?G => :grass,
    ?C => :clover,
    ?R => :radishes
  }

  @spec info(String.t(), list) :: map
  def info(info_string, student_names \\ @students) do
    [top, bottom] = String.split(info_string, "\n")
    |> Enum.map(&String.to_charlist/1)

    parse_student_plants(top, bottom, %{}, Enum.sort(student_names))
  end


  defp parse_student_plants(_, _, acc, []), do: acc
  defp parse_student_plants([], [], acc, [student | remaining_students]) do
    parse_student_plants([], [], Map.put(acc, student, {}), remaining_students)
  end
  defp parse_student_plants([first, second | top_tail], [third, fourth | bottom_tail], acc, [student | remaining_students]) do
    student_plants = {plants(first), plants(second), plants(third), plants(fourth)}
    parse_student_plants(top_tail, bottom_tail, Map.put(acc, student, student_plants), remaining_students)
  end

  defp plants(plant_char) do
    Map.get(@plants, plant_char)
  end
end
