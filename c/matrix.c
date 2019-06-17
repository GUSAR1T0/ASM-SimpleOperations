// -------------------------------------------------------------------------------------------------- //
// - Program:     Matrix                                                                            - //
// - Parameters:  ---                                                                               - //
// - Description: Determine the line numbers, the arithmetic average of elements that are less than - //
// -              the specified value.                                                              - //
// -------------------------------------------------------------------------------------------------- //

#include "utils.c"

const char *average_row_msg = "\t%d -> %d\n";

struct Matrix
{
    int count_rows;
    int count_cols;
    int count_all;

    int** matrix;
    int* sums;
};

void initialize(struct Matrix *matrix);
void averages(struct Matrix *matrix);
void result(struct Matrix *matrix, int avg_number);
void deinitialize(struct Matrix *matrix);

int main()
{
    int count_rows;
    print("Count of matrix rows: ");
    scanf("%d", &count_rows);
    rangeCheck(1, 1000, count_rows);

    int count_cols;
    print("Count of matrix cols: ");
    scanf("%d", &count_cols);
    rangeCheck(1, 1000, count_cols);

    println();

    struct Matrix matrix;
    matrix.count_rows = count_rows;
    matrix.count_cols = count_cols;
    initialize(&matrix);

    averages(&matrix);

    int avg_number;
    print("Number for average values comparison: ");
    scanf("%d", &avg_number);
    rangeCheck(0, 101, avg_number);

    println();

    result(&matrix, avg_number);

    deinitialize(&matrix);

    return 0;
}

void initialize(struct Matrix *matrix)
{
    matrix->count_all = matrix->count_rows * matrix->count_cols;
    printf("Matrix (size = %dx%d, total = %d):\n", matrix->count_rows, matrix->count_cols, matrix->count_all);

    srand(time(NULL));
    matrix->matrix = (int **) malloc(matrix->count_rows * sizeof(int *));
    matrix->sums = (int *) malloc(matrix->count_rows * sizeof(int));
    for (int i = 0; i < matrix->count_rows; i++)
    {
        *(matrix->matrix + i) = malloc(matrix->count_cols * sizeof(int));
        *(matrix->sums + i) = 0;
        for (int j = 0; j < matrix->count_cols; j++)
        {
            *(*(matrix->matrix + i) + j) = randomize(0, 100);
            *(matrix->sums + i) += *(*(matrix->matrix + i) + j);
            printf("\t%d", *(*(matrix->matrix + i) + j));
        }
        *(matrix->sums + i) = (int) (*(matrix->sums + i) / matrix->count_cols);
        println();
    }
    println();
}

void averages(struct Matrix *matrix)
{
    print("Row average values:\n");
    for (int i = 0; i < matrix->count_rows; i++)
    {
        printf(average_row_msg, i + 1, *(matrix->sums + i));
    }
    println();
}

void result(struct Matrix *matrix, int avg_number)
{
    int flag = 0;
    printf("Rows comply the condition (x < %d):\n", avg_number);
    for (int i = 0; i < matrix->count_rows; i++)
    {
        if (avg_number > *(matrix->sums + i))
        {
            printf(average_row_msg, i + 1, *(matrix->sums + i));
            flag = 1;
        }
    }
    if (flag == 0)
    {
        print("\tNo such rows\n");
    }
}

void deinitialize(struct Matrix *matrix)
{
    for (int i = 0; i < matrix->count_rows; i++)
    {
        free(*(matrix->matrix + i));
        *(matrix->matrix + i) = NULL;
    }
    free(matrix->matrix);
    matrix->matrix = NULL;
    free(matrix->sums);
    matrix->sums = NULL;
}