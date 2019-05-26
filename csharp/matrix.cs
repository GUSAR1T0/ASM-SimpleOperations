// -------------------------------------------------------------------------------------------------- //
// - Program:     Matrix                                                                            - //
// - Paraneters:  ---                                                                               - //
// - Description: Determine the line numbers, the arithmetic average of elements that are less than - //
// -              the specified value.                                                              - //
// -------------------------------------------------------------------------------------------------- //

using System;

public class Matrix
{
    public int count_rows { get; private set; }
    public int count_cols { get; private set; }
    public int count_all => count_rows * count_cols;
    public int[][] matrix;
    public int[] sums;

    public Matrix(int count_rows, int count_cols)
    {
        this.count_rows = count_rows;
        this.count_cols = count_cols;
        Initialize();
    }

    private void Initialize()
    {
        Console.WriteLine("Matrix (size = " + this.count_rows + "x" + this.count_cols + ", total = " + this.count_all + "):");

        var rand = new Random();
        matrix = new int[this.count_rows][];
        sums = new int[this.count_rows];
        for (var i = 0; i < this.count_rows; i++)
        {
            matrix[i] = new int[this.count_cols];
            sums[i] = 0;
            for (var j = 0; j < this.count_cols; j++)
            {
                matrix[i][j] = rand.Next(0, 100);
                sums[i] += matrix[i][j];
                Console.Write("\t" + matrix[i][j]);
            }
            sums[i] = (int) (sums[i] / this.count_cols);
            Console.WriteLine();
        }
        Console.WriteLine();
    }

    public void Averages()
    {
        Console.WriteLine("Row average values:");
        for (var i = 0; i < this.count_rows; i++)
        {
            Console.WriteLine("\t" + (i + 1) + " -> " + this.sums[i]);
        }

        Console.WriteLine();
    }

    public void Result(int avg_number)
    {
        var flag = false;
        Console.WriteLine("Rows comply the condition:");
        for (var i = 0; i < this.count_rows; i++)
        {
            if (avg_number > this.sums[i])
            {
                Console.WriteLine("\t" + (i + 1) + " -> " + this.sums[i]);
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
        int.TryParse(Console.ReadLine(), out var count_rows);
        Utils.RangeCheck(1, 20, count_rows);

        Console.Write("Count of matrix cols: ");
        int.TryParse(Console.ReadLine(), out var count_cols);
        Utils.RangeCheck(1, 20, count_cols);

        Console.WriteLine();

        var matrix = new Matrix(count_rows, count_cols);

        matrix.Averages();

        Console.Write("Number for average values comparison: ");
        int.TryParse(Console.ReadLine(), out var avg_number);
        Utils.RangeCheck(0, 101, avg_number);

        Console.WriteLine();

        matrix.Result(avg_number);
    }
}