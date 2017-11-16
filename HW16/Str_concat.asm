TITLE  Str_concat (Chapter 9, Pr 2, Modified)

; Program:     Str_concat.asm
; Description: concatenates a source string to the end of a target string
; Student:     David Shin
; Date:        11/6/16
; Class:       CSCI 241
; Instructor:  Mr. Ding

INCLUDE Irvine32.inc
Str_concat PROTO, targetStr:PTR DWORD, sourceStr:PTR DWORD

.data
prompt BYTE "Enter a string: ",0
result BYTE "The string concatenated: ",0
source BYTE 128 DUP(1)
destination BYTE 128 DUP(2)

.code
main PROC
	mov edx, offset prompt
	call WriteString
	mov edx, offset destination
	mov ecx, 128
	call ReadString
	
	mov edx, offset prompt
	call WriteString
	mov edx, offset source
	mov ecx, 128
	call ReadString

	invoke Str_concat, ADDR destination, ADDR source

	mov edx, offset result
	call WriteString
	mov edx, offset destination
	call WriteString
	call crlf
	exit
main ENDP

Str_concat PROC, targetStr:PTR DWORD, sourceStr:PTR DWORD
	mov ecx, 0
	mov esi, sourceStr
	mov edi, targetStr
		
mov edx, sourceStr
	mov ecx, 0
	mov edi, targetStr
	mov esi, sourceStr
		
L1:
	cmp BYTE PTR [edi], 0
	je L2
	inc ecx
	inc edi
	jmp L1	

L2:
	cmp BYTE PTR [esi], 0
	je L3
	inc esi
	jmp L2

L3: 
	cld
	mov esi, edx
	rep movsb
	mov BYTE PTR [edi], 0
	ret	
Str_concat ENDP
END main
