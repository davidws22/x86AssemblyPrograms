; Symmetric-Key Encryption Program            

; Program:     Multiple_Byte_Key_Encryption.asm
; Description: This program demonstrates simple symmetric encryption using the XOR instruction.
; Student:     David Shin
; Date:        09/30/16
; Class:       CSCI 241
; Instructor:  Mr. Ding

INCLUDE Irvine32.inc

BUFMAX = 128     	; maximum buffer size

.data
sPrompt  BYTE  "Enter the plain text: ",0
KeyProm  BYTE "Enter the encryption key: ", 0
sEncrypt BYTE  "Cipher text:          ",0
sDecrypt BYTE  "Decrypted:            ",0
keyBuf	 BYTE	BUFMAX+1 DUP(0)
buffer   BYTE   BUFMAX+1 DUP(0)
bufSize  DWORD  ?


.code
main PROC
	mov edx, OFFSET sPrompt  ; display buffer prompt
    mov eax, OFFSET buffer   ; point to the buffer
    call InputTheString
    mov bufSize, ebx         ; save the buffer length

    mov edx, OFFSET KeyProm  ; display key prompt
    mov eax, OFFSET keyBuf		; point to the key
    call InputTheString

	;prepare for translate buffer!!!
	mov esi, OFFSET buffer
	mov edx, OFFSET keyBuf
	mov ecx, bufSize
	call TranslateBuffer

	mov edx, OFFSET sEncrypt
	mov ebx, OFFSET buffer
	call DisplayMessage
	
	mov esi, OFFSET buffer
	mov edx, OFFSET keyBuf
	mov ecx, bufSize
	call TranslateBuffer

	mov edx, OFFSET sDecrypt
	mov ebx, OFFSET buffer
	call DisplayMessage

	call crlf


	exit
main ENDP

;-----------------------------------------------------
InputTheString PROC 
;
; Prompts user for a plaintext string. Saves the string 
; and its length.
; Receives: edx pointing to the offset of a prompt 
;			eax pointing to the offset of an empty buffer
; Returns: length of updated buffer saved into ebx
;-----------------------------------------------------
	call	WriteString ; writes the buffer prompt
	mov	ecx, BUFMAX		; maximum character count
	mov	edx, eax		; point to the buffer
	call	ReadString      ; input the string
	mov	ebx, eax        	; save the length
	ret
InputTheString ENDP

;-----------------------------------------------------
DisplayMessage PROC
;
; Displays the encrypted or decrypted message.
; Receives: EDX points to the message
; Returns:  nothing
;-----------------------------------------------------
	pushad
	call	WriteString
	mov	edx,ebx		; display the buffer
	call	WriteString
	call crlf
	popad
	ret
DisplayMessage ENDP

;-----------------------------------------------------
TranslateBuffer PROC
;
; Translates the string by exclusive-ORing each
; byte with the encryption key byte.
; Receives: esi, edx, ecx
; Returns: nothing
;-----------------------------------------------------
	mov edi, edx
L1:
	mov al, [esi]
	xor	al, [edi]	; translate a byte
	mov [esi], al
	inc	esi	; point to next byte
	inc edi ; point to the next key byte
	cmp BYTE PTR [edi], 0
	jnz next
	mov edi, edx
next:
	loop L1 
	ret
TranslateBuffer ENDP
END main
