TITLE  Random_Color_Char_Screen_Fill

; Program:     (Chapter 11, Pr 4, Modified)
; Description: Write a program that fills each screen cell with a random character, in a random color.
; Student:     David Shin
; Date:        11/29/16
; Class:       CSCI 241
; Instructor:  Mr. Ding

INCLUDE Irvine32.inc
;prototypes
GetStdHandle PROTO, 
	mStdHandle:HANDLE
GetConsoleScreenBufferInfo PROTO,
	hConsoleOutput:HANDLE,
	lpConsoleScreenBufferInfo:PTR CONSOLE_SCREEN_BUFFER_INFO
SetConsoleWindowInfo PROTO, 
	hConsoleOutput:HANDLE,
	bAbsolute:DWORD,
	lpConsoleWindow:PTR SMALL_RECT
SetConsoleScreenBufferSize PROTO,
	hConsoleOutput:HANDLE,
	dwSize:COORD

WriteConsole PROTO,
	hConsoleOutput:HANDLE,
	lpBuffer:PTR BYTE,
	nNumberOfCharsToWrite:DWORD,
	lpNumberOfCharsWritten:PTR DWORD,
	lpReserved:DWORD
	
WriteConsoleOutputAttribute PROTO,
	hConsoleOutput:DWORD,
	lpAttribute:PTR WORD,
	nLength:DWORD,
	dwWriteCoord:COORD,
	lpNumberOfAttrsWritten:PTR DWORD
	
.data
startingConsoleInfo CONSOLE_SCREEN_BUFFER_INFO<>
outputHandle HANDLE ?
shrinkRect SMALL_RECT<0,0,49,29>
bufferCoord COORD<50,30>
byteWritten DWORD ?
charStart	COORD<0,3>

charArray BYTE 1000 DUP(?)
colorArray WORD 1000 DUP(?)
.code
main PROC
	;getting the output handle.
	invoke GetStdHandle, STD_OUTPUT_HANDLE
	mov outputHandle, eax

	;getting beginning state of console screen buffer
	invoke GetConsoleScreenBufferInfo, outputHandle, 
		ADDR startingConsoleInfo
	;
	call WaitMsg
	call crlf

	;setting window size 50 width x 30 height
	invoke SetConsoleWindowInfo, 
		outputHandle,
		TRUE,
		ADDR shrinkRect

	call WaitMsg
	call crlf

	;setting screen buffer size to 50 width x 30 height
	invoke SetConsoleScreenBufferSize,
		outputHandle,
		bufferCoord
	
	call WaitMsg
	call crlf

	;now write 1000 characters
	call Randomize
	mov esi, offset colorArray
	mov edi, offset charArray
	mov ecx, 1000
L1:
	mov eax, 4 
	call RandomRange ;generates a random value 0-3
	.IF (EAX == 0) || (EAX == 1)
		;color is red
		mov eax, red + (black*16) ;red on black
	.ELSEIF(EAX == 2)
		;color is green
		mov eax, green + (black*16)
	.ELSE
		;color is yellow
		mov eax, yellow + (black*16)
	.ENDIF
	mov [esi], ax
	add esi,2
	mov eax, 91
	call RandomRange
	add eax, 32
	mov [edi], al
	inc edi
loop L1

	invoke WriteConsole,
		outputHandle,
		ADDR charArray,
		sizeof charArray, 
		ADDR byteWritten,
		0 

	invoke WriteConsoleOutputAttribute,
		outputHandle,
		ADDR colorArray,
		1000,
		charStart, 
		ADDR byteWritten
	call crlf

	;resetting  screen buffer size to default
	invoke SetConsoleScreenBufferSize,
		outputHandle,
		startingConsoleInfo.dwSize

	call WaitMsg
	call crlf
	
	;resetting window size
	invoke SetConsoleWindowInfo, 
		outputHandle,
		TRUE,
		ADDR startingConsoleInfo.srWindow

	call WaitMsg
	call crlf

	exit
main ENDP

END main
