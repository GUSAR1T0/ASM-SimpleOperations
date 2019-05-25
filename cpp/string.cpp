// -------------------------------------------------------------------------------------------------- //
// - Program:     String                                                                            - //
// - Paraneters:  ---                                                                               - //
// - Description: Replace all zeros with ones in the text, and ones with zeros, starting from the   - //
// -              position in which the number of preceding ones exceeds the number of preceding    - //
// -              zeros by 1.                                                                       - //
// -------------------------------------------------------------------------------------------------- //

#include <string>
#include "utils.cpp"

class String
{
    public:
        string input;

        void result()
        {
            bool flag = false;
            int count0 = 0, count1 = 0;
            for (int i = 0; i < input.length(); i++)
            {
                if (!flag)
                {
                    if (input[i] == '0')
                    {
                        count0++;
                    }
                    else if (input[i] == '1')
                    {
                        count1++;
                    }
                    if (count1 - count0 >= 1)
                    {
                        flag = true;
                    }
                }
                else
                {
                    if (input[i] == '0')
                    {
                        input[i] = '1';
                    }
                    else if (input[i] == '1')
                    {
                        input[i] = '0';
                    }
                }
                cout << input[i];
            }
        }
};

int main()
{
    String *string = new String();

    cout << "Enter the original string:" << endl;
    cin >> string->input;

    println();

    cout << "The reworked string:" << endl;
    string->result();

    println();

    delete string;
    string = nullptr;

    return 0;
}