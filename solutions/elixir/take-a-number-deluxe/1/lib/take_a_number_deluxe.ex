defmodule TakeANumberDeluxe do
  use GenServer

  @spec start_link(keyword()) :: {:ok, pid()} | {:error, atom()}
  def start_link(init_args) do
    GenServer.start_link(__MODULE__, init_args)
  end

  @spec report_state(pid()) :: TakeANumberDeluxe.State.t()
  def report_state(machine) do
    GenServer.call(machine, :report_state)
  end

  @spec queue_new_number(pid()) :: {:ok, integer()} | {:error, atom()}
  def queue_new_number(machine) do
    GenServer.call(machine, :queue_new_number)
  end

  @spec serve_next_queued_number(pid(), integer() | nil) :: {:ok, integer()} | {:error, atom()}
  def serve_next_queued_number(machine, priority_number \\ nil) do
    GenServer.call(machine, {:serve_next_queued_number, priority_number})
  end

  @spec reset_state(pid()) :: :ok
  def reset_state(machine) do
    GenServer.cast(machine, :reset_state)
  end

  # Server callbacks

  @impl GenServer
  def init(opts) do
    min_number = Keyword.fetch!(opts, :min_number)
    max_number = Keyword.fetch!(opts, :max_number)
    timeout = Keyword.get(opts, :auto_shutdown_timeout, :infinity)

    case TakeANumberDeluxe.State.new(min_number, max_number, timeout) do
      {:ok, state} ->
        {:ok, state, timeout}

      {:error, reason} ->
        {:stop, reason}
    end
  end

  @impl GenServer
  def handle_call(:report_state, _from, state) do
    {:reply, state, state, state.auto_shutdown_timeout}
  end

  @impl GenServer
  def handle_call(:queue_new_number, _from, state) do
    timeout = state.auto_shutdown_timeout

    case TakeANumberDeluxe.State.queue_new_number(state) do
      {:ok, new_number, new_state} ->
        {:reply, {:ok, new_number}, new_state, timeout}

      {:error, error} ->
        {:reply, {:error, error}, state, timeout}
    end
  end

  @impl GenServer
  def handle_call({:serve_next_queued_number, priority_number}, _from, state) do
    timeout = state.auto_shutdown_timeout

    case TakeANumberDeluxe.State.serve_next_queued_number(state, priority_number) do
      {:ok, next_number, new_state} ->
        {:reply, {:ok, next_number}, new_state, timeout}

      {:error, error} ->
        {:reply, {:error, error}, state, timeout}
    end
  end

  @impl GenServer
  def handle_cast(:reset_state, %{min_number: min, max_number: max, auto_shutdown_timeout: timeout}) do
    {:ok, new_state} = TakeANumberDeluxe.State.new(min, max, timeout)
    {:noreply, new_state, timeout}
  end

  @impl GenServer
  def handle_info(:timeout, state), do: {:stop, :normal, state}
  def handle_info(_msg, state), do: {:noreply, state, state.auto_shutdown_timeout}
end
