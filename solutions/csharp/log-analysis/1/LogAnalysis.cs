public static class LogAnalysis 
{
    public static string SubstringAfter(this string logline, string substring)
    {
        int startIndex = logline.IndexOf(substring) + substring.Length;
        if (startIndex < 0) throw new Exception("unable to find substring");

        return logline.Substring(startIndex, logline.Length - startIndex);
    }
    public static string SubstringBetween(this string logline, string start, string end)
    {
        int startIndex = logline.IndexOf(start) + start.Length;
        int endIndex = logline.IndexOf(end);

        return logline.Substring(startIndex, endIndex - startIndex);
    }
    public static string Message(this string logline) => logline.SubstringAfter("]: ");
    
    public static string LogLevel(this string logline) => logline.SubstringBetween("[", "]");
}