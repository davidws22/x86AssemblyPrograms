TITLE Even_Parity_Encoding (Chapter 7, Supplied)

; Program:     Chapter 7, Supplied
; Description: Conversion of a string to even parity
; Student:     David Shin
; Date:        10/17/2016
; Class:       CSCI 241
; Instructor:  Mr. Ding

INCLUDE Irvine32.inc
.data
message BYTE "Encoded string with message header: ", 0
prompt BYTE "Please enter a text message (less than 128 char): ", 0
userInput BYTE 128 DUP(?)
buffer BYTE 128 DUP(?)

.code
main PROC
	mov edx, offset prompt	
	call WriteString
	mov edx, offset userInput
	mov ecx, 128
	call ReadString ;returns the length of the string in eax

	mov esi, offset userInput  
    mov ebx, type userInput
    mov ecx, eax
    call DumpMem 

	mov esi, offset userInput
	mov ecx, eax ;eax contains the byte count of userInput
	mov edi, offset buffer
	call MessageEncoding

	mov edx, offset message
	call WriteString

	mov esi, offset buffer 
	mov ebx, type buffer
	add ecx, 2
	call DumpMem

	exit
main ENDP
;--------------------------------------------------------
MessageEncoding PROC uses ECX
;    Convert an original text message string to encode 
; in Even Parity for error checking with message count
; and modulo 256 checksum
; 
; Receives: ESI, points to an original text message string 
;           ECX, byte count of the text message
;           EDI, points to an encoded text message buffer
; Returns:  EDI, encoded text message buffer
;--------------------------------------------------------
; Add mesage count as the first byte at the beginning
; Leave a checksum position at the second byte
	
	mov edx, edi
	push edx
	mov BYTE PTR [edi], al
	add edi, 2
	mov ebx, eax
	mov edx, 0
L1: 
 ; For each char in ESI memory
	mov al, BYTE PTR [esi] 
    call EvenParityEncodeChar
 ; to Even Parity Encode a char to EDI memory
    mov BYTE PTR [edi], al
 ; Calculate modulo 256 checksum
	add bx, ax ;bx accumulates the sum of the message
	inc esi
	inc edi
   loop L1

; Set modulo 256 checksum as the second byte
	pop edi
	inc edi
	mov BYTE PTR [edi], bl
	ret
MessageEncoding ENDP
;--------------------------------------------------------
EvenParityEncodeChar PROC
; For a char to encode in Even Parity 
; Receives: AL as a char
; Returns:  AL encoded 
;--------------------------------------------------------
test al, 0FFh
jp L1
or al, 80h
L1:
ret
EvenParityEncodeChar ENDP

END main
