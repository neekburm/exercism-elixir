defmodule Bob do
  @question_regex ~r/.*\?$/u
  @has_letter_regex ~r/[[:alpha:]]/u

  @spec hey(String.t()) :: String.t()
  def hey(input) do
    trimmed_input = String.trim(input)
    has_letter? = Regex.match?(@has_letter_regex, trimmed_input)

    silence? = trimmed_input == ""
    question? = Regex.match?(@question_regex, trimmed_input)
    yelling? = has_letter? and trimmed_input == String.upcase(trimmed_input)
    cond do
      yelling? and question? -> "Calm down, I know what I'm doing!"
      yelling? -> "Whoa, chill out!"
      question? -> "Sure."
      silence? -> "Fine. Be that way!"
      true -> "Whatever."
    end
  end
end
