TITLE mReadInt_mWriteInt_Macro						(mWriteInt.asm)

; Program:     mReadInt_mWriteInt_Macro (Chapter 10, Pr 5 and Pr 6, Modified)
; Description: Create a macro named mReadInt that reads a 16- or 32-bit signed
;				 integer from standard input and returns the value in an argument.
;			   Create a macro named mWriteInt that writes a signed integer to 
;				 standard output by calling WriteInt.
; Student:     David Shin
; Date:        11/21/16
; Class:       CSCI 241
; Instructor:  Mr. Ding
INCLUDE Irvine32.inc
INCLUDE Macros.inc

mReadInt MACRO intVal
	;push eax
	IF (TYPE intVal LT 2) OR (TYPE intVal GT 4)
		ECHO error : ************************************************************************
		ECHO error : Argument &intVal passed to mReadInt must be either 16 or 32 bits.
		ECHO error : &intVal must be of 16 or 32-bit data type.
		ECHO error : ************************************************************************
		EXITM
	ENDIF
	push eax
	IF(TYPE intVal EQ 2)
		call ReadInt
		mov intVal, ax
	ELSEIF(TYPE intVal EQ 4)
		call ReadInt
		mov intVal, eax
	ENDIF
	pop eax
ENDM

mWriteInt MACRO myInt
	IF(TYPE myInt GT 4)
		ECHO warning : ************************************************************************
		ECHO warning : Argument &myInt passed to mWriteInt must be 8, 16, or 32 bits.
		ECHO warning : ************************************************************************
		EXITM
	ENDIF

	IF(TYPE myInt EQ 4)
		mWrite "&myInt = "
		push eax
		mov eax, myInt
		call WriteInt
		pop eax
	ELSE
		mWrite "&myInt = "
		push eax
		movsx eax, myInt
		call WriteInt
		pop eax
	ENDIF
	call crlf
ENDM

.data

bVal SBYTE ?
wVal SWORD ?
dVal DWORD ?
qVal QWORD 11
qVal2 QWORD 12
.code
main PROC
	mWrite "Enter a 32-bit integer: "
	mReadInt dVal
	mWriteInt dVal
	mWrite "Enter a 16-bit integer: "
	mReadInt BX
	mWriteInt BX

	mov bVal, -2
	mov wVal, -122
	mov dVal, 1234567

	mWriteInt bVal
	mWriteInt wVal
	mWriteInt dVal
	mWriteInt AX
	mWriteInt ebx
	;Test the macro's error message
    ;mWriteInt qVal
	mWriteInt bl
	mWriteInt qVal2

	exit
main ENDP
END main
