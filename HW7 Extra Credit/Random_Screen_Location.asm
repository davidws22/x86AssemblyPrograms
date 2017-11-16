TITLE Random_Screen_Location (Chapter 5, Pr 7)

; Program:     Chapter 4, supplementary exercise
; Description: program that displays a single character at 100 random screen locations, with a delay factor of some milliseconds.
; Student:     David Shin
; Date:        09/21/16
; Class:       CSCI 241
; Instructor:  Mr. Ding

INCLUDE Irvine32.inc
.data

.code
main PROC
mov ecx, 100

call GetMaxXY ;returns the current columns in DX, and the current rows(y) in AX
			;This proceduce returns a 1-based number of columns and rows.
	movzx ESI, DX  ;esi now contains the number of columns
	movzx EDI, AX	;edi now contains the number of rows

L1:
	mov EAX, ESI
	call RandomRange
	mov dl, al

	mov EAX, EDI
	call RandomRange
	mov dh, al 
	call Gotoxy ;this procedure returns a 0-based number for the column and row

	mov  al,'A'
    call WriteChar

	mov  eax,100 ;delay 0.1 sec
    call Delay
	Loop L1

	exit
main ENDP

END main
