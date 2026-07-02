static class LogLine
{
    public static string Message(string logLine)
    {
        int messageStartIndex = logLine.IndexOf(':') + 2;
        return logLine.Substring(messageStartIndex).Trim();
    }

    public static string LogLevel(string logLine)
    {
        int logLevelEnd = logLine.IndexOf(':');
        return logLine.Substring(0, logLevelEnd).Trim(['[',']']).ToLower().Trim();
    }

    public static string Reformat(string logLine) => $"{LogLine.Message(logLine)} ({LogLine.LogLevel(logLine)})";
}
