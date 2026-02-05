defmodule TakeANumber do
  def start() do
    spawn(fn -> loop(0) end)
  end

  defp loop(state) do
    receive do
      {:report_state, sender_pid} when is_pid(sender_pid) ->
        send(sender_pid, state)
        loop(state)

      {:take_a_number, sender_pid} when is_pid(sender_pid) ->
        next = state + 1
        send(sender_pid, next)
        loop(next)

      :stop -> :ok
      _unknown -> loop(state)
    end
  end
end
