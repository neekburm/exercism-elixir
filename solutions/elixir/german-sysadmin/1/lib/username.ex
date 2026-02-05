defmodule Username do
  def sanitize(username) do
    do_sanitize(username)
  end

  defp do_sanitize([]), do: []

  defp do_sanitize([char | rest]) do
    case char do
      ?_ -> [?_ | do_sanitize(rest)]
      ?ä ->	~c"ae" ++ do_sanitize(rest)
      ?ö ->	~c"oe" ++ do_sanitize(rest)
      ?ü ->	~c"ue" ++ do_sanitize(rest)
      ?ß ->	~c"ss" ++ do_sanitize(rest)
      c when c in ?a..?z -> [c | do_sanitize(rest)]
      _ -> do_sanitize(rest)
    end
  end
end
