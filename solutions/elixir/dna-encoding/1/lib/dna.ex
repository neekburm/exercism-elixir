defmodule DNA do
  def encode_nucleotide(code_point) do
    case code_point do
      ?\s -> 0b0000
      ?A -> 0b0001
      ?C -> 0b0010
      ?G -> 0b0100
      ?T -> 0b1000
    end
  end

  def decode_nucleotide(encoded_code) do
    case encoded_code do
      0b0000 -> ?\s
      0b0001 -> ?A
      0b0010 -> ?C
      0b0100 -> ?G
      0b1000 -> ?T
    end
  end

  def encode(dna) do
    do_encode(dna, <<>>)
  end

  def do_encode([], acc), do: acc
  def do_encode([nucleotide | tail], acc), do: do_encode(tail, <<acc::bitstring, encode_nucleotide(nucleotide)::4>>)

  def decode(dna), do: do_decode(dna, [])

  defp do_decode(<<>>, acc), do: Enum.reverse(acc)
  defp do_decode(<<nucleotide::4, tail::bitstring>>, acc) do
    do_decode(tail, [decode_nucleotide(nucleotide) | acc])
  end
end
