defmodule RPNCalculatorInspection do
  def start_reliability_check(calculator, input) do
    {:ok, pid} = Task.start_link(fn -> calculator.(input) end)
    %{input: input, pid: pid}
  end

  def await_reliability_check_result(%{pid: pid, input: input}, results) do
    receive do
      {:EXIT, ^pid, :normal} -> Map.put(results, input, :ok)
      {:EXIT, ^pid, reason} -> Map.put(results, input, :error)
    after
      100 -> Map.put(results, input, :timeout)
    end
  end

  def reliability_check(calculator, inputs) do
    old = Process.flag(:trap_exit, true)
    try do
      inputs
      |> Enum.map(fn input -> start_reliability_check(calculator, input) end)
      |> Enum.reduce(%{}, fn %{pid: pid, input: input}, acc ->
        await_reliability_check_result(%{pid: pid, input: input}, acc)
      end)
    after
      Process.flag(:trap_exit, old)
    end
  end

  def correctness_check(calculator, inputs) do
    inputs
    |> Enum.map(fn input ->
      Task.async(fn -> calculator.(input) end)
    end)
    |> Enum.map(fn task -> Task.await(task, 100) end)
  end
end
