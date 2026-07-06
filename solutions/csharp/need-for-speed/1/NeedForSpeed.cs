class RemoteControlCar
{
    public int speed;
    private int _distanceDriven;
    public int batteryDrain;
    public int battery;
    public RemoteControlCar(int speed, int batteryDrain)
    {
        this.speed = speed;
        this.batteryDrain = batteryDrain;
        battery = 100;
        _distanceDriven = 0;
    }

    public bool BatteryDrained() => battery < batteryDrain;

    public int DistanceDriven() => _distanceDriven;

    public void Drive()
    {
        if (battery >= batteryDrain)
        {
            battery -= batteryDrain;
            _distanceDriven += speed;
        }
    }

    public static RemoteControlCar Nitro() => new RemoteControlCar(50, 4);
}

class RaceTrack
{
    private int _distance;
    public RaceTrack(int distance)
    {
        _distance = distance;
    }

    public bool TryFinishTrack(RemoteControlCar car)
    {
        int roundsAvailableToDrive = car.battery / car.batteryDrain;
        return this._distance <= roundsAvailableToDrive * car.speed;
    }
}
