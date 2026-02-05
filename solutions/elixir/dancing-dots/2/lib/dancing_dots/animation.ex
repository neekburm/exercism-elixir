defmodule DancingDots.Animation do
  alias DancingDots.Animation
  @type dot :: DancingDots.Dot.t()
  @type opts :: keyword
  @type error :: any
  @type frame_number :: pos_integer

  @callback init(opts::keyword())::{:ok, opts}|{:error, error}
  @callback handle_frame(dot(), frame_number(), opts::keyword())::any()
  defmacro __using__(_) do
    quote do
      @behaviour DancingDots.Animation

      @impl DancingDots.Animation
      def init(opts) do
        {:ok, opts}
      end
      defoverridable(init: 1)
    end
  end
end

defmodule DancingDots.Flicker do
  use DancingDots.Animation

  @impl true
  def handle_frame(%DancingDots.Dot{opacity: opacity} = dot, frame_number, _opts) do
    case rem(frame_number, 4) do
      0 -> %DancingDots.Dot{dot | opacity: opacity / 2}
      _ -> dot
    end
  end
end

defmodule DancingDots.Zoom do
  use DancingDots.Animation

  @impl true
  def init(opts) when is_list(opts) do
    velocity = Keyword.get(opts, :velocity)

    if is_number(velocity) do
      {:ok, opts}
    else
      {:error, "The :velocity option is required, and its value must be a number. Got: #{inspect(velocity)}"}
    end
  end
  @impl true
  def handle_frame(%DancingDots.Dot{radius: radius} = dot, frame_number, [velocity: velocity]) do
    %DancingDots.Dot{dot | radius: radius + (frame_number - 1) * velocity}
  end
end
