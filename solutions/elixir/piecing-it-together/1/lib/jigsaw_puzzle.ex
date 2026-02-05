defmodule JigsawPuzzle do
  @doc """
  Fill in missing jigsaw puzzle details from partial data
  """

  @type format() :: :landscape | :portrait | :square
  @type t() :: %__MODULE__{
          pieces: pos_integer() | nil,
          rows: pos_integer() | nil,
          columns: pos_integer() | nil,
          format: format() | nil,
          aspect_ratio: float() | nil,
          border: pos_integer() | nil,
          inside: pos_integer() | nil
        }

  defstruct [:pieces, :rows, :columns, :format, :aspect_ratio, :border, :inside]

  @spec data(jigsaw_puzzle :: JigsawPuzzle.t()) ::
          {:ok, JigsawPuzzle.t()} | {:error, String.t()}
  def data(%__MODULE__{} = jigsaw_puzzle) do
    iterate(jigsaw_puzzle, 0)
  end

  defp iterate(%__MODULE__{} = jigsaw_puzzle, passes) when passes >= 20 do
    {:error, "Insufficient data"}
  end

  defp iterate(%__MODULE__{} = jigsaw_puzzle, passes) do
    with :ok <- validate(jigsaw_puzzle) do
      next = calculate_missing_fields(jigsaw_puzzle)

      cond do
        complete?(next) -> {:ok, next}
        next == jigsaw_puzzle -> {:error, "Insufficient data"}
        true -> iterate(next, passes + 1)
      end
    end
  end

  defp complete?(%__MODULE__{} = jigsaw_puzzle) do
    jigsaw_puzzle
    |> Map.from_struct()
    |> Map.values()
    |> Enum.all?(fn x -> !is_nil(x) end)
  end

  defp validate(%__MODULE__{pieces: pieces, rows: rows, columns: columns})
      when not is_nil(pieces) and not is_nil(rows) and not is_nil(columns) do
    if rows * columns == pieces, do: :ok, else: {:error, "Contradictory data"}
  end

  defp validate(%__MODULE__{rows: rows, columns: columns, aspect_ratio: aspect_ratio, format: format})
      when not is_nil(rows) and not is_nil(columns) and (not is_nil(aspect_ratio) or not is_nil(format)) do
    if (format == :square or (aspect_ratio != nil and aspect_ratio == 1.0)) and rows != columns, do: {:error, "Contradictory data"}, else: :ok
  end

  defp validate(%__MODULE__{pieces: pieces, border: border, inside: inside})
      when not is_nil(pieces) and not is_nil(border) and not is_nil(inside) do
    if border + inside == pieces, do: :ok, else: {:error, "Contradictory data"}
  end

  defp validate(_), do: :ok

  defp calculate_missing_fields(%__MODULE__{} = jigsaw_puzzle) do
    jigsaw_puzzle
    |> calculate_pieces()
    |> calculate_rows()
    |> calculate_columns()
    |> calculate_format()
    |> calculate_aspect_ratio()
    |> calculate_border()
    |> calculate_inside()
  end

  defp calculate_pieces(%__MODULE__{pieces: pieces} = jigsaw_puzzle) when not is_nil(pieces),
    do: jigsaw_puzzle

  defp calculate_pieces(%__MODULE__{columns: columns, rows: rows} = jigsaw_puzzle)
      when not is_nil(columns) and not is_nil(rows) do
    pieces = columns * rows
    %__MODULE__{jigsaw_puzzle | pieces: pieces}
  end

  defp calculate_pieces(%__MODULE__{border: border, inside: inside} = jigsaw_puzzle)
      when not is_nil(border) and not is_nil(inside) do
    pieces = border + inside
    %__MODULE__{jigsaw_puzzle | pieces: pieces}
  end

  defp calculate_pieces(%__MODULE__{} = jigsaw_puzzle), do: jigsaw_puzzle

  defp calculate_rows(%__MODULE__{rows: rows} = jigsaw_puzzle) when not is_nil(rows),
    do: jigsaw_puzzle

  defp calculate_rows(%__MODULE__{columns: columns, pieces: pieces} = jigsaw_puzzle)
      when not is_nil(columns) and not is_nil(pieces) do
    rows = div(pieces, columns)
    %__MODULE__{jigsaw_puzzle | rows: rows}
  end

  defp calculate_rows(%__MODULE__{aspect_ratio: aspect_ratio, pieces: pieces} = jigsaw_puzzle)
      when not is_nil(pieces) and not is_nil(aspect_ratio) do
    rows = :math.sqrt(pieces / aspect_ratio) |> trunc()
    %__MODULE__{jigsaw_puzzle | rows: rows}
  end

  defp calculate_rows(%__MODULE__{aspect_ratio: aspect_ratio, columns: columns} = jigsaw_puzzle)
      when not is_nil(aspect_ratio) and not is_nil(columns) do
    rows = (columns / aspect_ratio) |> trunc()
    %__MODULE__{jigsaw_puzzle | rows: rows}
  end

  defp calculate_rows(
        %__MODULE__{border: border, pieces: pieces, format: format, aspect_ratio: aspect_ratio} =
          jigsaw_puzzle
      )
      when not is_nil(border) and not is_nil(pieces) and
             (not is_nil(aspect_ratio) or not is_nil(format)) do
    rows_and_columns = div(border + 4, 2)
    {r1, r2} = integer_quadratic(1, -1 * rows_and_columns, pieces)
    bigger = max(r1, r2)
    smaller = min(r1, r2)

    case {format, aspect_ratio} do
      {:square, _} ->
        %__MODULE__{jigsaw_puzzle | rows: bigger, columns: smaller}

      {:portrait, _} ->
        %__MODULE__{jigsaw_puzzle | rows: bigger, columns: smaller}

      {:landscape, _} ->
        %__MODULE__{jigsaw_puzzle | rows: smaller, columns: bigger}

      {_, aspect_ratio} when is_number(aspect_ratio) and abs(aspect_ratio - 1.0) < 1.0e-9 ->
        %__MODULE__{jigsaw_puzzle | rows: bigger, columns: smaller}

      {_, aspect_ratio} when aspect_ratio < 1.0 ->
        %__MODULE__{jigsaw_puzzle | rows: bigger, columns: smaller}

      {_, aspect_ratio} when aspect_ratio > 1.0 ->
        %__MODULE__{jigsaw_puzzle | rows: smaller, columns: bigger}
    end
  end

  defp calculate_rows(
        %__MODULE__{inside: inside, aspect_ratio: aspect_ratio} =
          jigsaw_puzzle
      )
      when not is_nil(inside) and not is_nil(aspect_ratio)  do
    a = aspect_ratio |> trunc()
    b = -2 * (1 + aspect_ratio) |> trunc()
    c = 4 - inside
    {r1, r2} = integer_quadratic(a, b, c)
    rows = max(r1, r2)
    %__MODULE__{jigsaw_puzzle | rows: rows}

  end

  defp calculate_rows(%__MODULE__{} = jigsaw_puzzle), do: jigsaw_puzzle

  defp calculate_columns(%__MODULE__{columns: columns} = jigsaw_puzzle) when not is_nil(columns),
    do: jigsaw_puzzle

  defp calculate_columns(%__MODULE__{rows: rows, pieces: pieces} = jigsaw_puzzle)
      when not is_nil(rows) and not is_nil(pieces) do
    columns = div(pieces, rows)
    %__MODULE__{jigsaw_puzzle | columns: columns}
  end

  defp calculate_columns(%__MODULE__{aspect_ratio: aspect_ratio, pieces: pieces} = jigsaw_puzzle)
      when not is_nil(pieces) and not is_nil(aspect_ratio) do
    columns = :math.sqrt(pieces * aspect_ratio) |> trunc()
    %__MODULE__{jigsaw_puzzle | columns: columns}
  end

  defp calculate_columns(%__MODULE__{aspect_ratio: aspect_ratio, rows: rows} = jigsaw_puzzle)
      when not is_nil(aspect_ratio) and not is_nil(rows) do
    columns = (rows * aspect_ratio) |> trunc()
    %__MODULE__{jigsaw_puzzle | columns: columns}
  end

  defp calculate_columns(%__MODULE__{} = jigsaw_puzzle), do: jigsaw_puzzle

  defp calculate_format(%__MODULE__{format: format} = jigsaw_puzzle) when not is_nil(format),
    do: jigsaw_puzzle

  defp calculate_format(%__MODULE__{aspect_ratio: aspect_ratio} = jigsaw_puzzle)
      when not is_nil(aspect_ratio) do
    format =
      cond do
        aspect_ratio == 1.0 -> :square
        aspect_ratio < 1.0 -> :portrait
        aspect_ratio > 1.0 -> :landscape
      end

    %__MODULE__{jigsaw_puzzle | format: format}
  end

  defp calculate_format(jigsaw_puzzle), do: jigsaw_puzzle

  defp calculate_aspect_ratio(%__MODULE__{aspect_ratio: aspect_ratio} = jigsaw_puzzle)
      when not is_nil(aspect_ratio), do: jigsaw_puzzle

  defp calculate_aspect_ratio(%__MODULE__{format: :square} = jigsaw_puzzle),
    do: %__MODULE__{jigsaw_puzzle | aspect_ratio: 1}

  defp calculate_aspect_ratio(%__MODULE__{rows: rows, columns: columns} = jigsaw_puzzle)
      when not is_nil(rows) and not is_nil(columns) do
    %__MODULE__{jigsaw_puzzle | aspect_ratio: columns / rows}
  end

  defp calculate_aspect_ratio(%__MODULE__{} = jigsaw_puzzle), do: jigsaw_puzzle

  defp calculate_border(%__MODULE__{border: border} = jigsaw_puzzle) when not is_nil(border),
    do: jigsaw_puzzle

  defp calculate_border(%__MODULE__{pieces: pieces, inside: inside} = jigsaw_puzzle)
      when not is_nil(inside) and not is_nil(pieces) do
    border = pieces - inside
    %__MODULE__{jigsaw_puzzle | border: border}
  end

  defp calculate_border(%__MODULE__{rows: rows, columns: columns} = jigsaw_puzzle)
      when not is_nil(rows) and not is_nil(columns) do
    border = rows * 2 + columns * 2 - 4
    %__MODULE__{jigsaw_puzzle | border: border}
  end

  defp calculate_border(%__MODULE__{} = jigsaw_puzzle), do: jigsaw_puzzle

  defp calculate_inside(%__MODULE__{inside: inside} = jigsaw_puzzle) when not is_nil(inside),
    do: jigsaw_puzzle

  defp calculate_inside(%__MODULE__{pieces: pieces, border: border} = jigsaw_puzzle)
      when not is_nil(border) and not is_nil(pieces) do
    inside = pieces - border
    %__MODULE__{jigsaw_puzzle | inside: inside}
  end

  defp calculate_inside(%__MODULE__{} = jigsaw_puzzle), do: jigsaw_puzzle

  defp integer_quadratic(a, b, c) do
    d = b * b - 4 * a * c

    cond do
      d < 0 ->
        :error

      true ->
        s = trunc(:math.sqrt(d))

        if s * s == d do
          denom = 2 * a
          {div(-b + s, denom), div(-b - s, denom)}
        else
          :error
        end
    end
  end
end
