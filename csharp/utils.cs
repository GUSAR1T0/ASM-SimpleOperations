using System;

public static class Utils
{
    public static void RangeCheck(int lower, int upper, int number)
    {
        if (number < lower || number > upper)
        {
            Console.WriteLine("Incorrect input number! Choose number in range [" + lower + ", " + upper + "]");
            Environment.Exit(0);
        }
    }
}