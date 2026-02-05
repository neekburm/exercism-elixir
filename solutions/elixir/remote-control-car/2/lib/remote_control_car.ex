defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct [:nickname, battery_percentage: 100, distance_driven_in_meters: 0]


  def new(nickname \\ "none") do
    %RemoteControlCar{nickname: nickname}
  end

  def display_distance(%RemoteControlCar{} = remote_car) do
    "#{remote_car.distance_driven_in_meters} meters"
  end

  def display_battery(%RemoteControlCar{} = remote_car) when remote_car.battery_percentage > 0 do
    "Battery at #{remote_car.battery_percentage}%"
  end
  def display_battery(%RemoteControlCar{} = _remote_car) do
    "Battery empty"
  end

  def drive(%RemoteControlCar{} = remote_car) when remote_car.battery_percentage > 0 do
    new_battery_percentage = remote_car.battery_percentage - 1
    new_distance = remote_car.distance_driven_in_meters + 20
    %{remote_car | battery_percentage: new_battery_percentage, distance_driven_in_meters: new_distance}
  end
  def drive(%RemoteControlCar{} = remote_car), do: remote_car
end
