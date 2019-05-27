#include <iostream>
#include <stdlib.h>
#include <time.h>

using namespace std;

void rangeCheck(int lower, int upper, int number)
{
    if (number < lower || number > upper)
    {
        cout << "Incorrect input number! Choose number in range [" << lower << ", " << upper << "]" << endl;
        exit(0);
    }
}

int randomize(int lower, int upper)
{
    return rand() % (upper - lower + 1) + lower;
}