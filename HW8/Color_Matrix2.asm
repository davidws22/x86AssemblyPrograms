TITLE Color_Matrix2 (Chapter 6, Supplied)

; Program:     Color_Matrix2 (Chapter 6, Supplied)
; Description: displays a single character in all possible combinations of foreground and background colors
; Student:     David Shin	
; Date:        09/24/16
; Class:       CSCI 241
; Instructor:  Mr. Ding

INCLUDE Irvine32.inc
.data

default = lightGray + (black*16)

.code
main PROC
mov ecx, 256
mov ebx, 00h



L1:
	mov eax, ebx
	call SetTextColor
	mov al, 'X'
	call WriteChar
	mov dl, bl
	and dl, 00001111b
	cmp dl, 00001111b
	jnz next
	call crlf
next:
	add bl, 1h
	loop L1	

mov eax, default
call SetTextColor

exit
main ENDP

END main
