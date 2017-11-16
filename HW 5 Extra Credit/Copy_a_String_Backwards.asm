TITLE  Copy_a_String_Backwards (Chapter 4, Pr 7, Modified)

; Program:     Chapter 4, Pr 7
; Description: copies a string from source to target, reversing the character order in the process
; Student:     David Shin	
; Date:        9/14/16
; Class:       CSCI 241
; Instructor:  Mr. Ding

INCLUDE Irvine32.inc
.data
myString BYTE "Original: ", 0
my2String BYTE "Reversed: ", 0
BYTE "---"
source BYTE "This is the source string", 0
target BYTE SIZEOF source DUP(1)

.code
CopyBackwards PROC

mov ESI, OFFSET source
mov EDI, OFFSET target
mov ECX, LENGTHOF source - 1
add ESI, SIZEOF source - 2



L1:
	mov al, [esi]
	mov [edi], al
	dec esi
	inc edi
	LOOP L1
	mov al, 0
	mov [edi], al
	
	mov EDX, OFFSET myString
	call WriteString
	mov EDX, OFFSET source
	call WriteString
	call crlf
	mov EDX, OFFSET my2String
	call WriteString
	mov EDX, OFFSET target
	call WriteString
	call crlf

    exit
CopyBackwards ENDP
END CopyBackwards
