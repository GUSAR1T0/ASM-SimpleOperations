#include <stdio.h>
#include <stdlib.h>
#include <time.h>

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