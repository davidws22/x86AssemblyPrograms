TITLE Color_Matrix (Chapter 5, Pr 8)

; Program:     Color_Matrix (Chapter 5, Pr 8)
; Description: displays a single character in all possible combinations of foreground and background colors
; Student:     David Shin	
; Date:        09/18/16
; Class:       CSCI 241
; Instructor:  Mr. Ding

INCLUDE Irvine32.inc
.data

myColor BYTE 00h
count DWORD ?
default = lightGray + (black*16)

.code
main PROC
mov ecx, 16

L1:
	mov count, ecx
	mov ecx, 16
	L2:
		mov eax, DWORD PTR myColor
		call SetTextColor
		mov al, 'X'
		call WriteChar
		mov al, myColor
		add al, 1h
		mov myColor, al
		loop L2
	call crlf
	mov ecx, count
loop L1		

mov eax, default
call SetTextColor

exit
main ENDP

END main
