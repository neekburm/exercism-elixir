defmodule TopSecret do
  def to_ast(string) do
    Code.string_to_quoted!(string)
  end

  def decode_secret_message_part({op, _meta, [head | _tail]} = ast, acc)
      when op in [:def, :defp] do
    {name, arity} = name_and_arity(head)

    part =
      name
      |> Atom.to_string()
      |> String.slice(0, arity)

    {ast, [part | acc]}
  end

  def decode_secret_message_part(ast, acc), do: {ast, acc}

  def decode_secret_message(string) do
    ast = to_ast(string)
    {_ast, acc} = Macro.prewalk(ast, [], fn node, acc -> decode_secret_message_part(node, acc) end)

    acc
    |> Enum.reverse()
    |> Enum.join()
  end

  defp name_and_arity({:when, _meta, [fun_head | _]}), do: name_and_arity(fun_head)
  defp name_and_arity({name, _meta, args}) when is_list(args), do: {name, length(args)}
  defp name_and_arity({name, _meta, nil}), do: {name, 0}
end
