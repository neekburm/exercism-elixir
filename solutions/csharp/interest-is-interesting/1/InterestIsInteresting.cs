static class SavingsAccount
{
    private const decimal NEGATIVE_BALANCE_INTEREST_RATE = 0.03213m;
    private const decimal LESS_THAN_1000_DOLLAR_INTEREST_RATE = 0.005m;
    private const decimal MORE_THAN_1000_LESS_THAN_5000_INTEREST_RATE = 0.01621m;
    private const decimal GREATER_THAN_5000_INTEREST_RATE = 0.02475m;

    private static decimal RateFraction(decimal balance)
    {
        if (balance < 0m)
            return NEGATIVE_BALANCE_INTEREST_RATE;
        if (balance < 1000m)
            return LESS_THAN_1000_DOLLAR_INTEREST_RATE;
        if (balance < 5000m)
            return MORE_THAN_1000_LESS_THAN_5000_INTEREST_RATE;
        return GREATER_THAN_5000_INTEREST_RATE;
    }
    public static float InterestRate(decimal balance) => (float)(RateFraction(balance) * 100m);

    public static decimal Interest(decimal balance) => balance * RateFraction(balance);

    public static decimal AnnualBalanceUpdate(decimal balance) => balance + Interest(balance);

    public static int YearsBeforeDesiredBalance(decimal balance, decimal targetBalance)
    {
        int years = 0;
        while (balance < targetBalance)
        {
            balance = AnnualBalanceUpdate(balance);
            years += 1;
        }
        return years;
    }
}
