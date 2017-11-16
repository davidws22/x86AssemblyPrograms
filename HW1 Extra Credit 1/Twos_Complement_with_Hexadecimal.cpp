/*-----------------------------------------------------------------------------------------
Student: David Shin
Class: CSCI 241
Instuctor: Ding
Assignment: Ch01, Twos_Complement_with_Hexadecimal
Due Date: 9/1/16

Description: C++ program converting a 4-digit Hexadecimal integer to its Two's Complement.
-----------------------------------------------------------------------------------------*/
#include <iostream>
#include <cctype>

using namespace std;

// function prototype
void TwosComplement(char* s, char* s2);

int main(void)
{
	char Array1[5];
	char Array2[6];
	char userInput;

	while (true)
	{
		cout << "Please Enter 4-digit Hexadecimal integer (e.g., A1B2): ";
		cin >> Array1;
		TwosComplement(Array1, Array2);
		cout << "Two's Complement of Hex " << Array1 << " is " << Array2 << "\n";
		cout << "Try again? (y/n) ";
		cin >> userInput;
		if ((userInput == 'n' || userInput == 'N'))
		{
			system("pause");
			return 0;
		}
	}

}
// ============================================================================
// Function:	TwosComplement
// Description:	This function converts a Hexadecimal to its Two's Complement
//
// Parameter:   s [IN] - a C-string with a 4-digit Hexadecimal received
//              s2 [out] - a C-string with a 4-digit of s two's complement
// Return:      None
// ============================================================================
void TwosComplement(char* s, char* s2)
{
	bool indicator = true; //if temp is not within hex ranges, turned to false
	char temp;
	char value;
	bool result = true;


	for (int i = 3; i >= 0; i--)
	{
		temp = toupper(s[i]);
		if ((temp >= '0' && temp <= '9') || (temp >= 'A' && temp <= 'F'))
		{
			if (temp >= '6' && temp <= '9')
				value = ('F' - temp) + 41;

			else
				value = ('F' - temp) + 48;
			s2[i] = value;
		}
		else
		{
			s[0] = 'E';
			s[1] = 'r';
			s[2] = 'r';
			s[3] = 'o';
			s[4] = 'r';
			s[5] = '\0';
			indicator = false;
			break;

		}
	}//end for-loop

	if (indicator)
	{
		s2[4] = '\0';
		bool carry = false;
		for (int k = 3; k >= 0; k--)
		{//for 6789
			if (s2[k] == '9' && result)
			{
				s2[k] = 'A';
				result = false;
				break;
			}
			else if (s2[k] < 'F' && result)
			{
				s2[k] += 1;
				result = false;
				break;
			}
			else if (s2[k] == 'F')
			{
				s2[k] = '0';
				carry = true;
			}
			else if (carry)
			{
				result = true;
				if (s2[k] == '9' && result)
				{
					s2[k] = 'A';
					result = false;
					carry = false;
				}
				else if (s2[k] < 'F' && result)
				{
					s2[k] += 1;
					result = false;
					carry = false;
				}
				else if (s2[k] == 'F')
				{
					s2[k] = '0';
					carry = true;
				}
				

			}
		}//end for
	}//end if
}//end function