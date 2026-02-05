defmodule RPNCalculator do
  def calculate!(stack, operation) do
    try do
      operation.(stack)
    rescue
      _e -> raise RuntimeError, "An Error occurred"
    end
  end

  def calculate(stack, operation) do
    try do
      {:ok, operation.(stack)}
    rescue
      _e -> :error
    end
  end

  def calculate_verbose(stack, operation) do
    try do
      {:ok, operation.(stack)}
    rescue
      e -> {:error, e.message}
    end
  end
end
