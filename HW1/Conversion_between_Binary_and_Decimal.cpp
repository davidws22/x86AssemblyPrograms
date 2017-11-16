/*-----------------------------------------------------------------------------------------
Student: David Shin	
Class: CSCI 241
Instuctor: Ding
Assignment: Ch01, Conversion_between_Binary_and_Decimal
Due Date: 9/3/15

Description:
This program converts a user defined 8 bit binary number into a decimal number or a user
defined decimal number(<256) into an 8 bit binary number depending on a menu selection.

-----------------------------------------------------------------------------------------*/
#include <iostream>
#include <string>
using namespace std;

//function prototypes
int BinToDec(char* s);
char* DecToBin(int n);


int main(void)
{
	int userSelection;

	do{

	// Show menu and read case action
	cout << ">>> Please select the conversion type: \n";
	cout << "1. Binary to Decimal\n";
	cout << "2. Decimal to Binary\n";
	cout << "3. Exit\n";
	cout << "-------------------------------------------------\n";
	cout << "Enter your choice: ";
	cin >> userSelection;

	switch (userSelection)
	{
	case 1:  // How to call BinToDec()
	{
		int result;
		char myArray[9];
		// Prompt and Read input 
		cout << "Please Enter 8-bit binary digits (e.g., 11110000): ";
		cin >> myArray;
		// Call BinToDec() 
		result = BinToDec(myArray);
		// Output result
		cout << "The decimal integer of " << myArray << "b is " << result << "d \n";
		cin.get();
		break;
	}
	case 2:  // How to call DecToBin()
	{
		int input;
		char * binary;
		// Prompt and Read input
		cout << "Please Enter a decimal integer less than 256: ";
		cin >> input;
		// Call DecToBin()
		binary = DecToBin(input);
		// Output result
		cout << "The binary of " << input << "d is " << binary << "b\n";
		cin.get();
		delete[] binary;
		break;
	}
	case 3: //ending the program.
	{
		cout << "Bye!\n";
		system("pause");
		return 0;
	}

	}
}while (userSelection != 3);
	
		
}

// ============================================================================
// Function:	BinToDec
// Description:	This function converts an 8-bit binary integer to its decimal
// Parameter:   s [IN] -- a C-string with 8-bit binary digits received
// Return:      A decimal integer value calculated from s
// ============================================================================
int BinToDec(char* s)
{
	int var = 128;
	int ans = 0;
	
	for (int i = 0; i < 8; i++)
	{
		if (s[i] == '1')
		{
			ans += var;
		}
		var /= 2;
	}
	return ans;
}

// ============================================================================
// Function:	DecToBin
// Description:	This function converts a decimal integer to its binary bits
// Parameter:   n [IN] -- a decimal integer received, less than 256
// Return:      A C-string with 8-bit binary digits calculated from n
// ============================================================================
char* DecToBin(int n)
{
	int temp = 0;
	char* binaryHouse = new char[9];
	binaryHouse[8] = '\0';
	for(int i = 7; i >= 0; i--)
	{
		temp = n % 2;
		n /= 2;
		if (temp == 1)
			binaryHouse[i] = '1';
		else
			binaryHouse[i] = '0';
	}
	return binaryHouse;
}
