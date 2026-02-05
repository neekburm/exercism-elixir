defmodule HighScore do
  @default_initial_score 0
  def new() do
    %{}
  end

  def add_player(scores \\ new(), name, score \\ @default_initial_score) do
    Map.put_new(scores, name, score)
  end

  def remove_player(scores, name) do
    Map.delete(scores, name)
  end

  def reset_score(scores, name) do
    Map.put(scores, name, 0)
  end

  def update_score(scores, name, score \\ 0) do
    {old_score, scores} = add_player(scores, name) |>
    Map.get_and_update(name, fn x -> {x, x + score} end)
    scores
  end

  def get_players(scores) do
    Map.to_list(scores) |>
    Enum.map(fn {name, _score} -> name end)|>
    Enum.sort()
  end
end
