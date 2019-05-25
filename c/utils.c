#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void rangeCheck(int lower, int upper, int number)
{
    if (number < lower || number > upper)
    {
        printf("Incorrect input number! Choose number in range [%d, %d]\n", lower, upper);
        exit(0);
    }
}

void println()
{
    printf("\n");
}

void print(const char* chars)
{
    printf("%s", chars);
}

int randomize(int lower, int upper)
{
    return rand() % (upper - lower + 1) + lower;
}