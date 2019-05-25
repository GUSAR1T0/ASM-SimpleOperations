// -------------------------------------------------------------------------------------------------- //
// - Program:     Matrix                                                                            - //
// - Paraneters:  ---                                                                               - //
// - Description: Determine the line numbers, the arithmetic average of elements that are less than - //
// -              the specified value.                                                              - //
// -------------------------------------------------------------------------------------------------- //

#include "utils.cpp"

int main()
{
    int count_rows;
    cout << "Count of matrix rows: ";
    cin >> count_rows;
    rangeCheck(1, 20, count_rows);

    int count_cols;
    cout << "Count of matrix cols: ";
    cin >> count_cols;
    rangeCheck(1, 20, count_cols);

    println();

    int count_all = count_rows * count_cols;

    cout << "Matrix (size = " << count_rows << "x" << count_cols << ", total = " << count_all << "):" << endl;

    srand(time(NULL));
    int** matrix = new int*[count_rows];
    int* sums = new int[count_rows];
    for (int i = 0; i < count_rows; i++)
    {
        matrix[i] = new int[count_cols];
        sums[i] = 0;
        for (int j = 0; j < count_cols; j++)
        {
            matrix[i][j] = randomize(0, 100);
            sums[i] += matrix[i][j];
            cout << '\t' << matrix[i][j];
        }
        sums[i] = (int) (sums[i] / count_cols);
        println();
    }

    println();

    cout << "Row average values:" << endl;
    for (int i = 0; i < count_rows; i++)
    {
        cout << '\t' << i + 1 << " -> " << sums[i] << endl;
    }

    println();

    int avg_number;
    cout << "Number for average values comparison: ";
    cin >> avg_number;
    rangeCheck(0, 101, avg_number);

    println();

    bool flag = false;
    cout << "Rows comply the condition:" << endl;
    for (int i = 0; i < count_rows; i++)
    {
        if (avg_number > sums[i])
        {
            cout << '\t' << i + 1 << " -> " << sums[i] << endl;
            flag = true;
        }
    }
    if (!flag)
    {
        cout << '\t' << "No such rows" << endl;
    }

    for (int i = 0; i < count_rows; i++)
    {
        delete matrix[i];
        matrix[i] = nullptr;
    }
    delete[] matrix;
    matrix = nullptr;
    delete[] sums;
    sums = nullptr;
}