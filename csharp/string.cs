// -------------------------------------------------------------------------------------------------- //
// - Program:     String                                                                            - //
// - Paraneters:  ---                                                                               - //
// - Description: Replace all zeros with ones in the text, and ones with zeros, starting from the   - //
// -              position in which the number of preceding ones exceeds the number of preceding    - //
// -              zeros by 1.                                                                       - //
// -------------------------------------------------------------------------------------------------- //

using System;

public class String
{
    public string Input { get; set; }
    private char[] InputChars => Input.ToCharArray();

    public void Result()
    {
        var flag = false;
        int count0 = 0, count1 = 0;
        for (var i = 0; i < InputChars.Length; i++)
        {
            char symbol = InputChars[i];
            if (!flag)
            {
                if (symbol == '0')
                {
                    count0++;
                }
                else if (symbol == '1')
                {
                    count1++;
                }
                if (count1 - count0 >= 1)
                {
                    flag = true;
                }
            }
            else
            {
                if (symbol == '0')
                {
                    symbol = '1';
                }
                else if (symbol == '1')
                {
                    symbol = '0';
                }
            }
            Console.Write(symbol);
        }
    }
}

static class Program
{
    static void Main(string[] args)
    {
        var @string = new String();

        Console.WriteLine("Enter the original string:");
        @string.Input = Console.ReadLine();

        Console.WriteLine();

        Console.WriteLine("The reworked string:");
        @string.Result();

        Console.WriteLine();
    }
}