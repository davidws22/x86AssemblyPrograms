TITLE Chapter 6 Exercise 6            

; Program:     Boolean_Calculator (Chapter 6, Pr 5 and Pr 6)
; Description: Boolean Calculator that exercises table-driven logic
; Student:     David Shin
; Date:        10/08/16
; Class:       CSCI 241
; Instructor:  Mr. Ding

Comment !
Description: Continue the solution program from the preceding
exercise by implementing the following procedures:

- AND_op: Prompt the user for two hexadecimal integers. AND them
  together and display the result in hexadecimal.
- OR_op: Prompt the user for two hexadecimal integers. OR them
  together and display the result in hexadecimal.
- NOT_op: Prompt the user for a hexadecimal integer. NOT the
  integer and display the result in hexadecimal.
- XOR_op: Prompt the user for two hexadecimal integers. Exclusive-OR
  them together and display the result in hexadecimal.
!
INCLUDE Irvine32.inc

.data
msgMenu BYTE "---- Boolean Calculator ----------",0dh,0ah
   BYTE 0dh,0ah
   BYTE "1. x AND y"     ,0dh,0ah
   BYTE "2. x OR y"      ,0dh,0ah
   BYTE "3. NOT x"       ,0dh,0ah
   BYTE "4. x XOR y"     ,0dh,0ah
   BYTE "5. Exit program",0

msgAND BYTE "Boolean AND",0
msgOR  BYTE "Boolean OR",0
msgNOT BYTE "Boolean NOT",0
msgXOR BYTE "Boolean XOR",0

msgOperand1 BYTE "Input the first 32-bit hexadecimal operand:  ",0
msgOperand2 BYTE "Input the second 32-bit hexadecimal operand: ",0
msgResult   BYTE "The 32-bit hexadecimal result is:            ",0

caseTable BYTE '1'   ; lookup value
		  DWORD AND_op
EntrySize = ($ - caseTable)
		  BYTE '2' 
		  DWORD OR_op
		  BYTE '3'
		  DWORD NOT_op
		  BYTE '4'
		  DWORD XOR_op
		  BYTE '5'
		  DWORD ExitProgram
NumberOfEntries = ($ - caseTable) / EntrySize

ErrorMsg BYTE "Error reading input from keyboard...",0
.code
main08stub PROC

   ; Show menu in a loop
Menu:
   mov edx, offset msgMenu
   call WriteString
   call crlf
   clc

L1:   
   ; Call ReadChar to get the input
   call ReadChar		;stores the user-input inside the al register
   ; verify the input
   cmp al, '1'
   jb L2
   cmp al, '5'
   ja L2
  
   call ChooseProcedure
   jnc Menu
   jmp quit
L2:
	mov edx, offset ErrorMsg
	call WriteString
	call crlf
	call crlf
	jmp Menu
quit:
	exit
	
   ; Call ChooseProcedure
   ; if CF set, exit
   ; otherwise display menu again

main08stub ENDP

;------------------------------------------------
ChooseProcedure PROC
;
; Selects a procedure from the caseTable
; Receives: AL is the number of operation the user entered
; Returns: if CF set, exit; else continue 
;------------------------------------------------
mov ebx, offset caseTable
mov ecx, NumberOfEntries
L1:
	cmp al, [ebx]
	jne L2
	call NEAR PTR [ebx + 1]
	jmp L3
L2:
	add ebx, EntrySize
	loop L1
L3:
	
ret
ChooseProcedure ENDP

;------------------------------------------------
AND_op PROC
;
; Performs a boolean AND operation
; Receives: Nothing
; Returns: Nothing
;------------------------------------------------
	call crlf
	mov edx, offset msgAND
	call WriteString
	call crlf

	mov edx, offset msgOperand1
	call WriteString
	Call ReadHex
	mov ebx, eax
	mov edx, offset msgOperand2
	call WriteString
	call ReadHex
	and eax, ebx
	mov edx, offset msgResult
	call WriteString
	call WriteHex
	call crlf
	mov eax, 0
	ret
AND_op ENDP

;------------------------------------------------
OR_op PROC
;
; Performs a boolean OR operation
; Receives: Nothing
; Returns: Nothing
;------------------------------------------------
	call crlf
	mov edx, offset msgOR
	call crlf

	mov edx, offset msgOperand1
	call WriteString
	Call ReadHex
	mov ebx, eax
	mov edx, offset msgOperand2
	call WriteString
	call ReadHex
	or eax, ebx
	mov edx, offset msgResult
	call WriteString
	call WriteHex
	call crlf
	mov eax, 0
	ret
OR_op ENDP

;------------------------------------------------
NOT_op PROC
;
; Performs a boolean NOT operation.
; Receives: Nothing
; Returns: Nothing
;------------------------------------------------
	call crlf
	mov edx, offset msgNOT
	call WriteString
	call crlf

	mov edx, offset msgOperand1
	call WriteString
	Call ReadHex
	not eax
	mov edx, offset msgResult
	call WriteString
	call WriteHex
	call crlf
	mov eax, 0
	ret
NOT_op ENDP

;------------------------------------------------
XOR_op PROC
;
; Performs an Exclusive-OR operation
; Receives: Nothing
; Returns: Nothing
;------------------------------------------------
	call crlf
	mov edx, offset msgXOR
	call WriteString
	call crlf
	mov edx, offset msgOperand1
	call WriteString
	Call ReadHex
	mov ebx, eax
	mov edx, offset msgOperand2
	call WriteString
	call ReadHex
	xor eax, ebx
	mov edx, offset msgResult
	call WriteString
	call WriteHex
	call crlf
	mov eax, 0
	ret

XOR_op ENDP

;------------------------------------------------
ExitProgram PROC
;
; Receives: Nothing
; Returns: Sets CF = 1 to signal end of program
;------------------------------------------------
stc
ret
ExitProgram ENDP

END main08stub
