// -------------------------------------------------------------------------------------------------- //
// - Program:     String                                                                            - //
// - Paraneters:  ---                                                                               - //
// - Description: Replace all zeros with ones in the text, and ones with zeros, starting from the   - //
// -              position in which the number of preceding ones exceeds the number of preceding    - //
// -              zeros by 1.                                                                       - //
// -------------------------------------------------------------------------------------------------- //

#include "utils.c"

#define STRING_SIZE 1024

int main()
{
    char string[STRING_SIZE];
    print("Enter the original string:\n");
    scanf("%[^\n]%*c", string);

    println();

    print("The reworked string:\n");
    int flag = 0, count0 = 0, count1 = 0;
    for (int i = 0; i < STRING_SIZE && string[i] != '\0'; i++)
    {
        if (flag == 0)
        {
            if (string[i] == '0')
            {
                count0++;
            }
            else if (string[i] == '1')
            {
                count1++;
            }
            if (count1 - count0 >= 1)
            {
                flag = 1;
            }
        }
        else
        {
            if (string[i] == '0')
            {
                string[i] = '1';
            }
            else if (string[i] == '1')
            {
                string[i] = '0';
            }
        }
        printf("%c", string[i]);
    }
    print("\n");

    return 0;
}