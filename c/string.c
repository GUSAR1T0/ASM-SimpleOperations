// -------------------------------------------------------------------------------------------------- //
// - Program:     String                                                                            - //
// - Paraneters:  ---                                                                               - //
// - Description: Replace all zeros with ones in the text, and ones with zeros, starting from the   - //
// -              position in which the number of preceding ones exceeds the number of preceding    - //
// -              zeros by 1.                                                                       - //
// -------------------------------------------------------------------------------------------------- //

#include "utils.c"

#define STRING_SIZE 1024

struct String
{
    char input[STRING_SIZE];
};

void result(struct String *string);

int main()
{
    struct String string;
    print("Enter the original string:\n");
    scanf("%[^\n]%*c", string.input);

    println();

    print("The reworked string:\n");
    result(&string);

    println();

    return 0;
}

void result(struct String *string)
{
    int flag = 0, count0 = 0, count1 = 0;
    for (int i = 0; i < STRING_SIZE && string->input[i] != '\0'; i++)
    {
        if (flag == 0)
        {
            if (string->input[i] == '0')
            {
                count0++;
            }
            else if (string->input[i] == '1')
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
            if (string->input[i] == '0')
            {
                string->input[i] = '1';
            }
            else if (string->input[i] == '1')
            {
                string->input[i] = '0';
            }
        }
        printf("%c", string->input[i]);
    }
}