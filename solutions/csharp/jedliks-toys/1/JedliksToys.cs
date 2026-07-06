class RemoteControlCar
{
    private int _distance = 0;
    public void updateDistance(int addedDistance) => _distance += addedDistance;

    private int _batteryPercentage = 100;
    public void updateBatteryPercentage(int decreacedBatteryPercentage) => _batteryPercentage -= decreacedBatteryPercentage;
    public static RemoteControlCar Buy() => new RemoteControlCar();

    public string DistanceDisplay() => $"Driven {_distance} meters";

    public string BatteryDisplay() => _batteryPercentage > 0 ? $"Battery at {_batteryPercentage}%" : "Battery empty";

    public void Drive()
    {
        if (_batteryPercentage > 0)
        {
            updateDistance(20);
            updateBatteryPercentage(1);
        }
    }
}
