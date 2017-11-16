// Title: C_Assembly_Mixed_Call(Chapter 13, Pr 5, Modified)

// Program:     Chapter 13, Pr 5, Modified
// Description: Demonstrate calls to a C++ program from an Assembly program, vice versa
// Student:     David Shin
// Date:        12/8/16
// Class:       CSCI 241
// Instructor:  Mr.Ding

#include <iostream>
#include <cmath> //for sqrt
using namespace std;

extern "C" 
{
	bool isPrimeASM(int inVal);
	int intSqrt(int n);
}
//function prototype


int main(void)
{
	int N;
	while (1)
	{
		cout << "Enter an integer (-1 to exit): ";
		cin >> N;
		if (N == -1)
			break;
			// for next C_Assembly_Mixed_Call
		cout << "isPrimeASM: " << N << " is " << (isPrimeASM(N) ? "" : "NOT ") << "prime\n\n";
	}
	return 0;
}

int intSqrt(int n)
{
	return static_cast<int>(sqrt(n));
}
