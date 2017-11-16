TITLE Greatest_Common_Divisor.asm (Chapter 7, Pr 6)

; Program:     Chapter 7, Problem 6
; Description: Implementation of Euclid's algorithm in assembly language
; Student:     David Shin
; Date:        10/16/2016
; Class:       CSCI 241
; Instructor:  Mr. Ding

INCLUDE Irvine32.inc
.data

prompt BYTE "Enter a 32 bit number: " , 0
result BYTE "Greatest common divisor is: ", 0

.code
main PROC

	mov edx, offset prompt
	call WriteString
	call ReadInt
	mov ebx, eax ;ebx contains the first int x
	call WriteString
	call ReadInt
	;eax contains the second int y
	call CalcGcd
	mov edx, offset result
	call WriteString
	call WriteDec
	call crlf
	exit
main ENDP

;--------------------------------------------------------
CalcGcd PROC 
; calculates the greatest common divisor between two integers
; Receives: two unsigned ints which are contained in
;			ebx and eax
; Returns:  Eax, the gcd
;--------------------------------------------------------
	cmp ebx, 0
	jg check
	neg ebx
check:
	cmp eax, 0
	jg check2
	neg eax
check2:	;at this point, all values have been converted to the absolute value
	
L2:
	mov edx, 0 ;this is the new EDX:EAX
	div ebx		;divisor is ebx
	;remainder will be in edx
	mov eax, ebx ;mov the current y to x
	mov ebx, edx 
	cmp edx, 0
	je next
	jmp L2
next:
   ret
CalcGcd ENDP
END main
