public static class CentralBank
{
    public static string DisplayDenomination(long @base, long multiplier)
    {
        try
        {
            long denomination = checked(@base * multiplier);
            return denomination.ToString();
        }
        catch (OverflowException)
        {
            return "*** Too Big ***";
        }
    }

    public static string DisplayGDP(float @base, float multiplier)
    {
       
        float denomination = checked(@base * multiplier);
        if (denomination == float.PositiveInfinity)
            return "*** Too Big ***";
        return denomination.ToString();
        
        
    }

    public static string DisplayChiefEconomistSalary(decimal salaryBase, decimal multiplier)
    {
        try
        {
            decimal denomination = salaryBase * multiplier;
            return denomination.ToString();
        }
        catch (OverflowException)
        {
            return "*** Much Too Big ***";
        }
    }
}
