TITLE Chapter 5 Exercise 10              (ch05_Pr10stub.asm)

; Program:     Chapter 5, exercise 10
; Description: 
Comment @
Using Programming Exercise 6 in Chapter 4 as a starting point, 
write a program that generates the first 47 values in the Fibonacci 
series, stores them in an array of doublewords, and writes the 
doubleword array to a disk file.
@
; Student:     David Shin
; Date:        9/16/16
; Class:       CSCI 241
; Instructor:  Mr. Ding

INCLUDE Irvine32.inc

FIB_COUNT = 47	; number of values to generate

.data
fileHandle DWORD ?
filename BYTE "fibonacci.bin",0
array DWORD FIB_COUNT DUP(?)

.code
main2sub PROC

; Generate the array of fib values
   ; Prepare your ESI and ECX 
   MOV ECX, FIB_COUNT
   MOV ESI, OFFSET array
   
   ; Calling generateFibonacci
   call generate_fibonacci

; Create the file, call CreateOutputFile
	MOV EDX, OFFSET filename
	call CreateOutputFile
	MOV fileHandle, EAX

; Write the array to the file, call WriteToFile
	
	MOV EDX, OFFSET array
	MOV ECX, (FIB_COUNT * 4)
	call WriteToFile

; Close the file, call CloseFile	
	MOV EAX, fileHandle
	call CloseFile

   exit
main2sub ENDP

;------------------------------------------------------------
generate_fibonacci PROC USES eax ebx ecx edx
;
; Generates fibonacci values and stores in an array.
; Receives: ESI points to the array, 
;           ECX = count
; Returns: nothing
;------------------------------------------------------------
	MOV EDX, 0
	MOV EBX, 1
	
L1:
	add EBX, EDX
	mov EAX, EBX
	call WriteDec
	call crlf
	mov EBX, EDX
	mov EDX, EAX
	mov [esi], EAX
	add esi, 4
	loop L1
   ret
generate_fibonacci ENDP

END main2sub
