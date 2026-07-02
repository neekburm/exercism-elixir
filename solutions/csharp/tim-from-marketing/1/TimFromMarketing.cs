static class Badge
{
    public static string Print(int? id, string name, string? department)
    {
        if (id == null)
        {
            return $"{name} - {department?.ToUpper() ?? "OWNER"}";
        }
        else
        {
            return $"[{id}] - {name} - {department?.ToUpper() ?? "OWNER"}";
        }
    }
}
