defmodule TwelveDays do
  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """
  @spec verse(number :: integer) :: String.t()
  def verse(number) do
    preamble = "On the #{number_to_io(number)} day of Christmas my true love gave to me: "

    gifts = Enum.map(number..1//-1, &day/1)

    line = case gifts do
      [only] -> only
      _ ->
        {all_but_last, [last]} = Enum.split(gifts, length(gifts) -1)
        Enum.join(all_but_last, ", ") <> ", and " <> last
    end

    preamble <> line
  end

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    Enum.map(starting_verse..ending_verse, &verse/1)
    |> Enum.join("\n")
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing() :: String.t()
  def sing do
    verses(1, 12)
  end

  defp day(1), do: "a Partridge in a Pear Tree."
  defp day(2), do: "two Turtle Doves"
  defp day(3), do: "three French Hens"
  defp day(4), do: "four Calling Birds"
  defp day(5), do: "five Gold Rings"
  defp day(6), do: "six Geese-a-Laying"
  defp day(7), do: "seven Swans-a-Swimming"
  defp day(8), do: "eight Maids-a-Milking"
  defp day(9), do: "nine Ladies Dancing"
  defp day(10), do: "ten Lords-a-Leaping"
  defp day(11), do: "eleven Pipers Piping"
  defp day(12), do: "twelve Drummers Drumming"

  defp number_to_io(1), do: "first"
  defp number_to_io(2), do: "second"
  defp number_to_io(3), do: "third"
  defp number_to_io(4), do: "fourth"
  defp number_to_io(5), do: "fifth"
  defp number_to_io(6), do: "sixth"
  defp number_to_io(7), do: "seventh"
  defp number_to_io(8), do: "eighth"
  defp number_to_io(9), do: "ninth"
  defp number_to_io(10), do: "tenth"
  defp number_to_io(11), do: "eleventh"
  defp number_to_io(12), do: "twelfth"
end
