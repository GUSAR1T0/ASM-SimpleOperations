// -------------------------------------------------------------------------------------------------- //
// - Program:     Matrix                                                                            - //
// - Paraneters:  ---                                                                               - //
// - Description: Determine the line numbers, the arithmetic average of elements that are less than - //
// -              the specified value.                                                              - //
// -------------------------------------------------------------------------------------------------- //

#include "utils.c"

const char *input_error_msg = "Incorrect input number! Choose number in range [%d, %d]\n";
const char *average_row_msg = "\t%d -> %d\n";

int main()
{
    int count_rows;
    print("Count of matrix rows: ");
    scanf("%d", &count_rows);
    if (count_rows < 1 || count_rows > 20)
    {
        printf(input_error_msg, 1, 20);
        return 0;
    }

    int count_cols;
    print("Count of matrix cols: ");
    scanf("%d", &count_cols);
    if (count_cols < 1 || count_cols > 20)
    {
        printf(input_error_msg, 1, 20);
        return 0;
    }

    println();

    int count_all = count_rows * count_cols;

    printf("Matrix (size = %dx%d, total = %d):\n", count_rows, count_cols, count_all);

    srand(time(NULL));
    int **matrix = malloc(count_rows * sizeof(int *));
    int *sums = malloc(count_rows * sizeof(int));
    for (int i = 0; i < count_rows; i++)
    {
        *(matrix + i) = malloc(count_cols * sizeof(int));
        *(sums + i) = 0;
        for (int j = 0; j < count_cols; j++)
        {
            *(*(matrix + i) + j) = randomize(0, 100);
            *(sums + i) += *(*(matrix + i) + j);
            printf("\t%d", *(*(matrix + i) + j));
        }
        *(sums + i) = (int) (*(sums + i) / count_cols);
        println();
    }

    println();

    printf("Row average values:\n");
    for (int i = 0; i < count_rows; i++)
    {
        printf(average_row_msg, i + 1, *(sums + i));
    }

    println();

    int avg_number;
    print("Number for average values comparison: ");
    scanf("%d", &avg_number);
    if (avg_number < 0 || avg_number > 101)
    {
        printf(input_error_msg, 0, 101);
        return 0;
    }

    println();

    int flag = 0;
    printf("Rows comply the condition:\n");
    for (int i = 0; i < count_rows; i++)
    {
        if (avg_number > *(sums + i))
        {
            printf(average_row_msg, i + 1, *(sums + i));
            flag = 1;
        }
    }
    if (flag == 0)
    {
        print("\tNo such rows\n");
    }

    for (int i = 0; i < count_rows; i++)
    {
        free(*(matrix + i));
        *(matrix + i) = NULL;
    }
    free(matrix);
    matrix = NULL;
    free(sums);
    sums = NULL;

    return 0;
}