// -------------------------------------------------------------------------------------------------- //
// - Program:     String                                                                            - //
// - Parameters:  ---                                                                               - //
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

        bool result()
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
                        changeSymbol(i);
                    }
                }
                else
                {
                    changeSymbol(i);
                }
            }
            return flag;
        }
    
    private:
        void changeSymbol(int index)
        {
            if (input[index] == '0')
            {
                input[index] = '1';
            }
            else if (input[index] == '1')
            {
                input[index] = '0';
            }
        }
};

int main()
{
    String *string = new String();

    cout << "Enter the original string:" << endl;
    cin >> string->input;

    cout << endl;

    cout << "The original string:" << endl << string->input << endl << endl;
    cout << "The reworked string:" << endl << (string->result() ? string->input : "Nothing changed!") << endl;

    delete string;
    string = nullptr;

    return 0;
}