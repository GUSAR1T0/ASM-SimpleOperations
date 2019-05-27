// -------------------------------------------------------------------------------------------------- //
// - Program:     String                                                                            - //
// - Parameters:  ---                                                                               - //
// - Description: Replace all zeros with ones in the text, and ones with zeros, starting from the   - //
// -              position in which the number of preceding ones exceeds the number of preceding    - //
// -              zeros by 1.                                                                       - //
// -------------------------------------------------------------------------------------------------- //

using System;
using System.Text;

public class String
{
    public string Input 
    { 
        get => input.ToString();
        set => this.input = new StringBuilder(value);
    }

    private StringBuilder input;

    public bool Result()
    {
        var flag = false;
        int count0 = 0, count1 = 0;
        for (var i = 0; i < input.Length; i++)
        {
            if (!flag)
            {
                if (input[i] == '0')
                {
                    count0++;
                }
                else if (input[i] == '1')
                {
                    count1++;
                }
                if (count1 - count0 >= 1)
                {
                    flag = true;
                    ChangeSymbol(i);
                }
            }
            else
            {
                ChangeSymbol(i);
            }
        }
        return flag;
    }

    private void ChangeSymbol(int index)
    {
        if (input[index] == '0')
        {
            input[index] = '1';
        }
        else if (input[index] == '1')
        {
            input[index] = '0';
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

        Console.WriteLine("The original string:");
        Console.WriteLine(@string.Input);
        Console.WriteLine();
        Console.WriteLine("The reworked string:");
        Console.WriteLine(@string.Result() ? @string.Input : "Nothing changed!");
    }
}