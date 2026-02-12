defmodule RnaTranscription do
  @transcription_complement %{
    ?G => ?C,
    ?C => ?G,
    ?T => ?A,
    ?A => ?U
  }
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

    iex> RnaTranscription.to_rna(~c"ACTG")
    ~c"UGAC"
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    Enum.map(dna, fn x -> Map.fetch!(@transcription_complement, x) end)
  end
end
