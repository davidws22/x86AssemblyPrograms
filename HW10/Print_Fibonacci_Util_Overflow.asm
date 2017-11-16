TITLE  Print_Fibonacci_Util_Overflow (Chapter 6)

; Program:     Chapter 6, Required exercise
; Description: This program calculates the signed Fibonacci number sequence, stopping only when the Overflow flag is set
; Student:     David Shin	
; Date:        10/05/16
; Class:       CSCI 241
; Instructor:  Mr. Ding

INCLUDE Irvine32.inc
.data
myString BYTE ": ", 0 ;string to display the : for every line count

.code
OverFib PROC
	mov EDX, 0 ;fib #
	mov EBX, 1 ;fib #
	
	mov ESI, 1 ;this is the line counter
	
L1:
	add EBX, EDX
	jo quit ;jump out of the infinite loop if overflow flag is set
	mov ecx, edx
	mov edi, ebx
	mov eax, esi	;these
	call WriteDec	;take care of line count
	mov edx, offset myString
	call WriteString
	mov eax, edi
	call WriteDec
	call crlf
	inc esi
	mov edx, ecx
	mov EAX, EBX
	mov EBX, EDX
	mov EDX, EAX
jmp L1

quit:
	exit
OverFib ENDP
END OverFib
