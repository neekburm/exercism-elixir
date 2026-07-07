public static class TelemetryBuffer
{
    public static byte[] ToBuffer(long reading)
    {
        (byte[] payload, bool signed) = reading switch
        {
            >= 0 and <= ushort.MaxValue => (BitConverter.GetBytes((ushort)reading), false),
            >= 65536 and <= int.MaxValue => (BitConverter.GetBytes((int)reading), true),
            >= 2_147_483_648L and <= uint.MaxValue => (BitConverter.GetBytes((uint)reading), false),
            >= -32768 and <= -1 => (BitConverter.GetBytes((short)reading), true),
            >= int.MinValue and <= -32769 => (BitConverter.GetBytes((int)reading), true),
            _ => (BitConverter.GetBytes(reading), true)
        };

        byte prefix = signed ? (byte)(256 - payload.Length) : (byte)payload.Length;

        byte[] buffer = new byte[9];
        buffer[0] = prefix;
        Array.Copy(payload, 0, buffer, 1, payload.Length);
        return buffer;
    }

    public static long FromBuffer(byte[] buffer)
    {
        byte prefix = buffer[0];

        return prefix switch
        {
            2 => BitConverter.ToUInt16(buffer, 1),
            4 => BitConverter.ToUInt32(buffer, 1),
            254 => BitConverter.ToInt16(buffer, 1),
            252 => BitConverter.ToInt32(buffer, 1),
            248 => BitConverter.ToInt64(buffer, 1),
            _ => 0
        };
    }
}
