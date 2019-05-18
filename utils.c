#include <stdlib.h>
#include <time.h>

static int flag = 0;

int randomize(int lower, int upper)
{
    if (flag == 0)
    {
        srand(time(NULL));
        flag = 1;
    }
    return rand() % (upper - lower + 1) + lower;
}
