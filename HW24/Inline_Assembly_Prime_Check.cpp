// Title	Inline_Assembly_Prime_Check (Chapter 13, inline assembly)

// Program:     Chapter 13
// Description: Practice using inline assembly programming
// Student:     David Shin
// Date:        12/7/2016
// Class:       CSCI 241
// Instructor:  Mr.Ding

#pragma warning(disable: 4716)
#include <iostream>
#include <cmath> //for sqrt()
using namespace std;
//function prototypes
bool isPrimeC_inlineASM(int n);
bool isPrimeC_inlineASM2(int n);
bool isPrimeC(int n);

int main(void)
{
	int N;
	while (1)
	{
		cout << "Enter an integer(-1 to exit) : ";
		cin >> N;
		if (N == -1)
			break;
		cout << "isPrimeC:   " << N << " is " << (isPrimeC(N) ? "" : "NOT ") << "prime\n";
		cout << "inlineASM:  " << N << " is " << (isPrimeC_inlineASM(N) ? "" : "NOT ") << "prime\n";
		cout << "inlineASM2: " << N << " is " << (isPrimeC_inlineASM2(N) ? "" : "NOT ") << "prime\n";
		// for next C_Assembly_Mixed_Call
		//cout << "isPrimeASM: " << N << " is " << (isPrimeASM(N) ? "" : "NOT ") << "prime\n\n";
	}
	return 0;
}

bool isPrimeC_inlineASM(int n)
{
	__asm
	{
		/*
		cmp n, 2
		jb fail
		xor edx, edx
		mov eax, n
		mov ebx, 2
		div ebx
		//eax contains n / 2
		mov ebx, eax
		mov ecx, 2

		L1:
		cmp ecx, ebx
			ja L2
			mov eax, n
			xor edx, edx
			div ecx
			; remainder will be in edx
			cmp edx, 0
			je fail
			inc ecx
			jmp L1
			L2 :
		mov al, 1
			jmp success
			fail :
		mov al, 0
			success :
		*/	// asm
	
	; fill is prime logic here...
	cmp n, 2
	jb notPrime
	je prime
	mov edx, 0				// free up edx
	mov eax, n				// eax = n
	mov ebx, 2				// what to divide by
	div ebx
	mov ecx, eax			// ecx = n/2

	check:
	mov edx, 0
	mov eax, n
	div ebx
	cmp edx, 0
	je notPrime
	cmp ebx, 2

	inc ebx
	jmp check

	prime:
	mov al, 1
	jmp done

	notPrime:
	mov al, 0

	done:

	
	}
}

bool isPrimeC_inlineASM2(int n)
{
	bool isPrime = true;
	for (int divisor = 2; divisor <= n / 2; divisor++)
	{
		if (n <2) return false;
		__asm 
		{
			xor edx, edx
			mov eax, n
			div divisor
			cmp edx, 0
			je L1
			jmp L2
			L1:
				mov isPrime, 0	
			L2:

		}		// asm

		if (!isPrime)
			break;
	}
	return isPrime;
}
bool isPrimeC(int n)
{
	if (n <2) return false;

	for (int divisor = 2; divisor <= n / 2; divisor++)
	{
		if (n % divisor == 0)
			return false;
	}
	return true;
}
