// -------------------------------------------------------------------------------------------------- //
// - Program:     String                                                                            - //
// - Parameters:  ---                                                                               - //
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

int result(struct String *string);
void changeSymbol(struct String *string, int index);

int main()
{
    struct String string;
    print("Enter the original string:\n");
    scanf("%[^\n]%*c", string.input);

    println();

    print("The original string:\n");
    print(string.input);
    println();
    println();
    print("The reworked string:\n");
    print(result(&string) != 0 ? string.input : "Nothing changed!");
    println();

    return 0;
}

int result(struct String *string)
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
                changeSymbol(string, i);
            }
        }
        else
        {
            changeSymbol(string, i);
        }
    }
    return flag;
}

void changeSymbol(struct String *string, int index)
{
    if (string->input[index] == '0')
    {
        string->input[index] = '1';
    }
    else if (string->input[index] == '1')
    {
        string->input[index] = '0';
    }
}