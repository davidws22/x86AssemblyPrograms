TITLE  Fibonacci_Numbers (Chapter 4, Pr 5, Modified)

; Program:     Chapter 4, Pr 5, Modified					
; Description: calculates the first 12 values in the Fibonacci number sequence { 1,1,2,3,5,8,13,21,34,55,89,144}.
; Student:     David Shin	
; Date:        9/14/16
; Class:       CSCI 241
; Instructor:  Mr. Ding

INCLUDE Irvine32.inc
.data

bArray BYTE 12 DUP(?) ;uninitialized array of 12 bytes
myString BYTE  "First 12 Fibonacci numbers:", 0Dh, 0Ah, 0

.code
 
Fib PROC
	mov EDX, 0
	mov EBX, 1
	mov ECX, 12
	mov ESI, 0
	
L1:
	
	add EBX, EDX
	mov EAX, EBX
	mov EBX, EDX
	mov EDX, EAX
	mov bArray[ESI], AL
	inc ESI
	LOOP L1

	mov EDX, OFFSET myString
	call WriteString
	call Display
    exit

Fib ENDP
; A procedure to show dwArray memory by calling DumpMem 
Display PROC
    mov esi, offset bArray 
    mov ebx, type bArray
    mov ecx, lengthof bArray
    call DumpMem
    ret
Display ENDP
END Fib
