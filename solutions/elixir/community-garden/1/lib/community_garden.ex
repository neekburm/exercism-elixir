# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  use Agent
  def start(opts \\ []) do
    Agent.start_link(fn -> %{count: 0, plots: []} end, name: __MODULE__)
  end

  def list_registrations(pid) do
    Agent.get(pid, fn state -> state.plots end)
  end

  def register(pid, register_to) do
    Agent.get_and_update(pid, fn %{count: count, plots: plots} = state ->
      new_plot = %Plot{plot_id: count + 1, registered_to: register_to}
      {new_plot, %{state | count: count + 1, plots: [new_plot | plots]}}
    end)
  end

  def release(pid, plot_id) do
    remaining_plots =
    Agent.update(pid, fn %{plots: plots} = state ->
      remaining_plots = Enum.filter(plots, fn plot -> plot.plot_id != plot_id end)
      %{state | plots: remaining_plots}
    end)
  end

  def get_registration(pid, plot_id) do
    Agent.get(pid, fn %{plots: plots} ->
      Enum.find(plots, {:not_found, "plot is unregistered"}, fn %Plot{plot_id: id} -> id == plot_id end)
    end)
  end
end
