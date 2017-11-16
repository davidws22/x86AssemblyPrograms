TITLE Chapter 7 Exercise 3              Packed_BCD_to_ASCII.asm

; Program:     Chapter 7, Exercise 3
Comment !
Description: Write a procedure named PackedToAsc that converts a
4-byte packed decimal number to a string of ASCII decimal digits.
Pass the packed number to the procedure in EAX, and pass a pointer
to a buffer that will hold the ASCII digits. Write a short test
program that demonstrates several conversions and displays the
converted numbers on the screen.
!
; Student:     David Shin
; Date:        10/17/2016
; Class:       CSCI 241
; Instructor:  Mr. Ding


INCLUDE Irvine32.inc

.data
numbers DWORD 87654321h, 45346894h, 193492h, 123h, 3h
buffer BYTE 8 DUP(1), 0   ; 8 digits plus null character

.code
main PROC

   ; Prepare for LOOP
   mov ecx, lengthof numbers
   mov eax, offset numbers
L1:
   ; Prepare the pointer to buffer and a packed decimal number
  ; mov eax, offset numbers
   mov edx, offset buffer
   ; Call PackedToAsC to convert to ASCII digits
   call PackedToAsC
   ; Display string of digits
   mov edx, offset buffer
   call WriteString
   call crlf
   ; Get next number
   add eax, TYPE DWORD
   loop L1
   exit
main ENDP

;----------------------------------------------------------------
PackedToAsc PROC USES ECX EAX
;
; procedure that converts a 4-byte packed decimal number
; to a string of ASCII decimal digits
; Receives: EAX, One packed decimal number
;           EDX, The pointer to a buffer with ASCII returned
; Returns: String of ASCII digits in buffer pointed by EDX
;------------------------------------------------------------------
	mov ecx, 4
	add eax, 3
	mov ebx, 0
L1:
	mov bl, BYTE PTR [eax]
	and bl, 0F0h
	shr bl, 4
	or bl, 30h
	mov BYTE PTR [edx], bl
	inc edx
	mov bl, BYTE PTR [eax]
	and bl, 0Fh
	or bl, 30h
	mov BYTE PTR [edx], bl
	inc edx
	sub eax, TYPE BYTE
loop L1
ret
PackedToAsc ENDP
END main
