TITLE  Chapter 3, Problem 2 and 4 (Symbolic_Integer_and_Text_Constants.asm)
; Program:     Chapter 3, Problem 2 and 4
; Description: This is a practice with symbolic constant definitions either using integers or strings
; Student:     David Shin	
; Date:        09/06/2016
; Class:       CSCI 241
; Instructor:  Mr. Ding

; 32-bit assembly language template

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
Monday = 0
Tuesday = 1
Wednesday = 2
Thursday = 3
Friday = 4
Saturday = 5
Sunday = 6

myArray BYTE Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday
numElements = ($ - myArray)

message1 EQU <"If at first",0>
message2 EQU <"you don't succeed...",0Dh, 0Ah, 0>
message3 EQU <"try, try, try again", 0>

m1 BYTE message1
m2 BYTE message2
m3 BYTE message3

.code
main proc

mov al, myArray
mov bl, numElements

mov cl, m1
mov cl, m2
mov cl, m3
nop

   invoke ExitProcess,0
main endp
end main
