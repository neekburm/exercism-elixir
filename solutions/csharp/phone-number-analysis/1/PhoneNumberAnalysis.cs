public static class PhoneNumber
{
    public static (bool IsNewYork, bool IsFake, string LocalNumber) Analyze(string phoneNumber)
    {
        string areaCode = phoneNumber.Substring(0, 3);
        string prefixCode = phoneNumber.Substring(4, 3);
        string lastFour = phoneNumber.Substring(8, 4);
        
        bool IsNewYork = areaCode == "212";
        bool isFake = prefixCode == "555";
        return (IsNewYork, isFake, lastFour);
    }

    public static bool IsFake((bool IsNewYork, bool IsFake, string LocalNumber) phoneNumberInfo)
    {
        (bool _isNewYork, bool IsFake, string _lastFour) = phoneNumberInfo;
        return IsFake;
    }
}
