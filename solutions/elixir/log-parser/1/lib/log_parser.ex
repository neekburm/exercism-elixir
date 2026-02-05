defmodule LogParser do

  def valid_line?(line) do
    line =~ ~r/^\s*(?:\[DEBUG\]|\[INFO\]|\[WARNING\]|\[ERROR\])/
  end

  def split_line(line) do
    regex = ~r/<[~\*=\-]*>/
    Regex.split(regex, line)
  end

  def remove_artifacts(line) do
    regex = ~r/end-of-line[\d]+/i
    Regex.replace(regex, line, "")
    # Please implement the remove_artifacts/1 function
  end

  def tag_with_user_name(line) do
    case Regex.run(~r/User\s+([^\s]+)/, line) do
      [_, name] -> "[USER] #{name} " <> line
      nil -> line
    end
  end
end
