defmodule BinarySearchTree do
  @type bst_node :: %{data: any, left: bst_node | nil, right: bst_node | nil}

  @doc """
  Create a new Binary Search Tree with root's value as the given 'data'
  """
  @spec new(any) :: bst_node
  def new(data) do
    %{data: data, left: nil, right: nil}
  end

  @doc """
  Creates and inserts a node with its value as 'data' into the tree.
  """
  @spec insert(bst_node, any) :: bst_node
  def insert(tree, data) do
    do_insert(tree, data)
  end

  defp do_insert(tree, data) do
    case data > tree.data do
      true ->
        if tree.right == nil do
          %{tree | right: new(data)}
        else
          %{tree | right: do_insert(tree.right, data)}
        end

      false ->
        if tree.left == nil do
          %{tree | left: new(data)}
        else
          %{tree | left: do_insert(tree.left, data)}
        end
    end
  end

  @doc """
  Traverses the Binary Search Tree in order and returns a list of each node's data.
  """
  @spec in_order(bst_node) :: [any]
  def in_order(tree) do
    tree
    |> do_in_order([], [])
    |> Enum.reverse()
  end

  defp do_in_order(nil, [], acc), do: acc
  defp do_in_order(nil, [node | stack], acc) do
    do_in_order(node.right, stack, [node.data | acc])
  end
  defp do_in_order(node, stack, acc) do
    do_in_order(node.left, [node | stack], acc)
  end


end
