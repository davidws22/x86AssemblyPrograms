TITLE DOS_file_time (Chapter 7, Supplied) DOS_file_time.asm

; Description: diplays 24-hour clock format given 4 hex-digits
;				exercises the concept of bit shifting
; Student:     David Shin
; Date:        10/08/16
; Class:       CSCI 241
; Instructor:  Mr. Ding

INCLUDE Irvine32.inc
.data
HexMsg BYTE "Please enter 16-bit hexadecimal (4-digit, e.g., 1207): ", 0
BinMsg BYTE "Your equivalent binary is ", 0
DosMsg BYTE "Your DOS file time is ", 0
;ErrorMsg BYTE "Error reading hexadecimal value...", 0D, 0A, 0
Colon	BYTE ":",0
value WORD ?

.code
main PROC
	mov edx, offset HexMsg
	call WriteString
	call ReadHex ; value is stored in eax register
	mov value, ax
	mov edx, offset BinMsg
	call WriteString
	mov ebx, 2
	call WriteBinB
	call crlf
	mov edx, offset DosMsg
	call WriteString
	call ShowFileTime

	exit
main ENDP

;------------------------------------------------
ShowFileTime PROC
;
; displays 24-hour time
; Receives: AX is the 16-bit binary value
; Returns: nothing 
;------------------------------------------------
mov bx, value
and bx, 0F800h ;hours
shr bx, 11
call DispTime
mov edx, offset Colon		
call WriteString

mov bx, value
and bx, 07E0h ;minutes
shr bx, 5
call DispTime
mov edx, offset Colon
call WriteString
	
mov bx, value
and bx, 001Fh ;seconds
stc ;indicator to tell if you are dealing with seconds
call DispTime
call crlf
ret
ShowFileTime ENDP

;------------------------------------------------
DispTime PROC
;
; helper procedure that displays time correctly
; Receives: BX
; Returns: nothing 
;------------------------------------------------
jc L2
L1:
	cmp bl, 10
	ja L3
	mov al, '0'
	call WriteChar
	mov eax, 0
	mov al, bl
	call WriteDec
	ret
L2:
	shl bl, 1
	clc
	jmp L1
L3:
	mov eax, 0
	mov al, bl
	call WriteDec
	ret
DispTime ENDP
END main
