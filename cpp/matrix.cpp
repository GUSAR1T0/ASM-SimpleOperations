// -------------------------------------------------------------------------------------------------- //
// - Program:     Matrix                                                                            - //
// - Paraneters:  ---                                                                               - //
// - Description: Determine the line numbers, the arithmetic average of elements that are less than - //
// -              the specified value.                                                              - //
// -------------------------------------------------------------------------------------------------- //

#include "utils.cpp"

class Matrix
{
    private:
        int count_rows;
        int count_cols;
        int count_all;

        int** table;
        int* sums;

        void initialize()
        {
            cout << "Matrix (size = " << count_rows << "x" << count_cols << ", total = " << count_all << "):" << endl;

            srand(time(NULL));
            table = new int*[count_rows];
            sums = new int[count_rows];
            for (int i = 0; i < count_rows; i++)
            {
                table[i] = new int[count_cols];
                sums[i] = 0;
                for (int j = 0; j < count_cols; j++)
                {
                    table[i][j] = randomize(0, 100);
                    sums[i] += table[i][j];
                    cout << '\t' << table[i][j];
                }
                sums[i] = (int) (sums[i] / count_cols);
                println();
            }
            println();
        }

    public:
        Matrix(int count_rows, int count_cols)
        {
            this->count_rows = count_rows;
            this->count_cols = count_cols;
            this->count_all = count_rows * count_cols;
            initialize();
        }

        ~Matrix()
        {
            for (int i = 0; i < count_rows; i++)
            {
                delete table[i];
                table[i] = nullptr;
            }
            delete[] table;
            table = nullptr;
            delete[] sums;
            sums = nullptr;
        }

        void averages()
        {
            cout << "Row average values:" << endl;
            for (int i = 0; i < count_rows; i++)
            {
                cout << '\t' << i + 1 << " -> " << sums[i] << endl;
            }
            println();
        }

        void result(int avg_number)
        {
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
        }
};

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

    Matrix *matrix = new Matrix(count_rows, count_cols);

    matrix->averages();

    int avg_number;
    cout << "Number for average values comparison: ";
    cin >> avg_number;
    rangeCheck(0, 101, avg_number);

    println();

    matrix->result(avg_number);

    delete matrix;
    matrix = nullptr;

    return 0;
}