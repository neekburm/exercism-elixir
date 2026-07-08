using System.Text;
public static class Identifier
{
    public static string Clean(string identifier)
    {
        StringBuilder sb = new StringBuilder(identifier);
        sb.Replace(' ', '_')
          .Replace("\0", "CTRL")
          .CamelCase()
          .RemoveNonLetters()
          .RemoveGreekLowercase();
        return sb.ToString();
    }

    private static StringBuilder CamelCase(this StringBuilder sb)
    {
        for (int i = 0; i < sb.Length - 1; i++)
        {
            if (sb[i] == '-')
                sb[i + 1] = char.ToUpper(sb[i + 1]);
        }
        return sb.Replace("-", "");
    }

    private static StringBuilder RemoveNonLetters(this StringBuilder sb)
    {
        for (int i = sb.Length - 1; i >= 0; i--)
        {
            if (!char.IsLetter(sb[i]) && sb[i] != '_')
                sb.Remove(i, 1);
        }
        return sb;
    }

    private static StringBuilder RemoveGreekLowercase(this StringBuilder sb)
    {
        for (int i = sb.Length - 1; i >= 0; i--)
        {
            if (sb[i] is >= 'α' and <= 'ω')
                sb.Remove(i, 1);
        }
        return sb;
    }
}