// -------------------------------------------------------------------------------------------------- //
// - Program:     Matrix                                                                            - //
// - Parameters:  ---                                                                               - //
// - Description: Determine the line numbers, the arithmetic average of elements that are less than - //
// -              the specified value.                                                              - //
// -------------------------------------------------------------------------------------------------- //

using System;

public class Matrix
{
    public int CountRows { get; private set; }
    public int CountCols { get; private set; }
    public int CountAll => CountRows * CountCols;
    public int[][] Table;
    public int[] Sums;

    public Matrix(int countRows, int countCols)
    {
        CountRows = countRows;
        CountCols = countCols;
        Initialize();
    }

    private void Initialize()
    {
        Console.WriteLine("Matrix (size = " + CountRows + "x" + CountCols + ", total = " + CountAll + "):");

        var rand = new Random();
        Table = new int[CountRows][];
        Sums = new int[CountRows];
        for (var i = 0; i < CountRows; i++)
        {
            Table[i] = new int[CountCols];
            Sums[i] = 0;
            for (var j = 0; j < CountCols; j++)
            {
                Table[i][j] = rand.Next(0, 100);
                Sums[i] += Table[i][j];
                Console.Write("\t" + Table[i][j]);
            }
            Sums[i] = (int) (Sums[i] / CountCols);
            Console.WriteLine();
        }
        Console.WriteLine();
    }

    public void Averages()
    {
        Console.WriteLine("Row average values:");
        for (var i = 0; i < CountRows; i++)
        {
            Console.WriteLine("\t" + (i + 1) + " -> " + Sums[i]);
        }
        Console.WriteLine();
    }

    public void Result(int avgNumber)
    {
        var flag = false;
        Console.WriteLine("Rows comply the condition (x < " + avgNumber + "):");
        for (var i = 0; i < CountRows; i++)
        {
            if (avgNumber > Sums[i])
            {
                Console.WriteLine("\t" + (i + 1) + " -> " + Sums[i]);
                flag = true;
            }
        }
        if (!flag)
        {
            Console.WriteLine("\t" + "No such rows");
        }
    }
}

static class Program
{
    static void Main(string[] args)
    {
        Console.Write("Count of matrix rows: ");
        int.TryParse(Console.ReadLine(), out var countRows);
        Utils.RangeCheck(1, 1000, countRows);

        Console.Write("Count of matrix cols: ");
        int.TryParse(Console.ReadLine(), out var countCols);
        Utils.RangeCheck(1, 1000, countCols);

        Console.WriteLine();

        var matrix = new Matrix(countRows, countCols);

        matrix.Averages();

        Console.Write("Number for average values comparison: ");
        int.TryParse(Console.ReadLine(), out var avgNumber);
        Utils.RangeCheck(0, 101, avgNumber);

        Console.WriteLine();

        matrix.Result(avgNumber);
    }
}