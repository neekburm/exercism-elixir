class WeighingMachine
{
    public int Precision { get; }

    private double _Weight;
    public double Weight
    {
        get => _Weight;
        set
        {
            if (value >= 0)
            {
                _Weight = value;
            }
            else
            {
                throw new ArgumentOutOfRangeException();
            }
        }
    }
    public double TareAdjustment;

    public string DisplayWeight
    {
        get
        {
            return $"{Math.Round(Weight - TareAdjustment, Precision).ToString($"F{Precision}")} kg";
        }
    }

    public WeighingMachine(int precision)
    {
        Precision = precision;
        TareAdjustment = 5;
        _Weight = 0.0;
    }
}
