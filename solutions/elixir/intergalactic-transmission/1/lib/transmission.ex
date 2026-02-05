defmodule Transmission do
  import Bitwise

  @doc """
  Return the transmission sequence for a message.
  """
  @spec get_transmit_sequence(binary()) :: binary()
  def get_transmit_sequence(message) do
    create_transmit_sequence(message, [])
  end

  defp create_transmit_sequence(<<>>, acc) do
    acc
    |> Enum.reverse()
    |> IO.iodata_to_binary()
  end

  defp create_transmit_sequence(<<chunk::7, tail::bitstring>>, acc) do
    parity = rem(bit_count(chunk), 2)
    byte = chunk <<< 1 ||| parity
    create_transmit_sequence(tail, [<<byte::8>> | acc])
  end

  defp create_transmit_sequence(<<chunk::bitstring>>, acc) do
    bits = bit_size(chunk)
    padded = <<chunk::bitstring, 0::size(7 - bits)>>
    <<value::7>> = padded

    parity = rem(bit_count(value), 2)
    byte = value <<< 1 ||| parity
    create_transmit_sequence(<<>>, [<<byte::8>> | acc])
  end

  @doc """
  Return the message decoded from the received transmission.
  """
  @spec decode_message(binary()) :: {:ok, binary()} | {:error, String.t()}
  def decode_message(received_data) do
    try do
      do_decode_message(received_data, [])
    rescue
      e in RuntimeError -> {:error, Exception.message(e)}
    end
  end

  defp do_decode_message(<<>>, acc) do
    decoded_message =
      acc
      |> Enum.reverse()
      |> repack_7bit_chunks_to_bytes()

    {:ok, decoded_message}
  end

  defp do_decode_message(<<byte::8, tail::bitstring>>, acc) do
    chunk = byte >>> 1
    check_bit = byte &&& 1

    if rem(bit_count(chunk), 2) != check_bit do
      raise("wrong parity")
    else
      do_decode_message(tail, [chunk | acc])
    end
  end

  defp repack_7bit_chunks_to_bytes(chunks) do
    {out, buf, bits} =
      Enum.reduce(chunks, {[], 0, 0}, fn chunk, {out, buf, bits} ->
        buf = ((buf <<< 7) ||| chunk)
        bits = bits + 7
        flush_bytes(out, buf, bits)
      end)
    if bits == 0 or buf == 0 do
      out
      |> Enum.reverse()
      |> IO.iodata_to_binary()
    else
      {:error, "non-zero padding"}
    end
  end
  defp flush_bytes(out, buf, bits) when bits < 8, do: {out, buf, bits}
  defp flush_bytes(out, buf, bits) do
    shift = bits - 8
    byte = (buf >>> shift) &&& 0xFF

    buf =
      if shift == 0 do
        0
      else
        buf &&& ((1 <<< shift) - 1)
      end
    flush_bytes([<<byte::8>> | out], buf, shift)
  end

  @spec bit_count(number :: integer()) :: non_neg_integer()
  defp bit_count(number) do
    do_bit_count(number, 0)
  end

  defp do_bit_count(0, acc), do: acc

  defp do_bit_count(n, acc) do
    do_bit_count(n >>> 1, acc + (n &&& 1))
  end
end
