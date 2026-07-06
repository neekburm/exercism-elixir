static class Appointment
{
    public static DateTime Schedule(string appointmentDateDescription) => DateTime.Parse(appointmentDateDescription);

    public static bool HasPassed(DateTime appointmentDate)
    {
        DateTime today = DateTime.Now;
        return appointmentDate < today;
    }

    public static bool IsAfternoonAppointment(DateTime appointmentDate)
    {
        return appointmentDate.Hour >= 12 && appointmentDate.Hour < 18;
    }

    public static string Description(DateTime appointmentDate) => $"You have an appointment on {appointmentDate}.";

    public static DateTime AnniversaryDate() => new DateTime(2026, 9, 15, 0, 0, 0);
}
