TITLE  Show_Date_Time_of_File (Chapter 11, Pr 9)

; Program:     Chapter 11, Pr 9
; Description: fills in SYSTEMTIME structs and displays when a file was created
;				and last modified.
; Student:     David Shin
; Date:        11/30/2016
; Class:       CSCI 241
; Instructor:  Mr. Ding

INCLUDE Irvine32.inc


WriteDateTime PROTO,
	DateTime:SYSTEMTIME
GetFileTime PROTO,		; get date/time stamp of a file
	hFile:HANDLE,
	pCreationTime:PTR FILETIME,
	pLastAccessTime:PTR FILETIME,
	pLastWriteTime:PTR FILETIME
CreateFile PROTO,		; create new file
	lpFilename:PTR BYTE,		; ptr to filename
	dwDesiredAccess:DWORD,		; access mode
	dwShareMode:DWORD,		; share mode
	lpSecurityAttributes:DWORD,  		; pointer to security attributes
	dwCreationDisposition:DWORD,		; file creation options
	dwFlagsAndAttributes:DWORD,		; file attributes
	hTemplateFile:DWORD		; handle to template file
GetStdHandle PROTO,
	nStdHandle:HANDLE	;handle type
FileTimeToSystemTime PROTO,		; convert FILETIME to SYSTEMTIME
	lpFileTime:PTR FILETIME,
	lpSystemTime:PTR SYSTEMTIME
CloseHandle PROTO, 
	hObject:HANDLE
SystemTimeToTzSpecificLocalTime PROTO, 
	lpTimeZone:DWORD,
	lpUniversalTime:PTR SYSTEMTIME,
	lpLocalTime:PTR SYSTEMTIME
	
	

INVALID_FILE_HANDLE EQU -1
.data
createdTime SYSTEMTIME <> 
modifiedTime SYSTEMTIME <>
prompt BYTE "Input your file name: ", 0
buffer BYTE 81 DUP(?)
message1 BYTE " was created on: ", 0
message2 BYTE "And it was last written on: ", 0
slash BYTE "/", 0
colon BYTE ":", 0
fileHandle HANDLE ?
errorMsg BYTE "Error opening file...", 0Dh, 0Ah, 0
whenCreated FILETIME <>
lastWritten FILETIME <>




.code
main PROC
	mov edx, offset prompt
	call WriteString
	mov edx, offset buffer
	mov ecx, 80
	call ReadString
	mov esi, offset createdTime
	mov edi, offset modifiedTime
	call AccessFileDateTime

	.IF CARRY?
		mov edx, offset errorMsg
		call WriteString
		jmp quit
	.ELSE 
		mov edx, offset buffer
		call WriteString
		mov edx, offset message1
		call WriteString
		invoke WriteDateTime, createdTime
		mov edx, offset message2
		call WriteString
		invoke WriteDateTime, modifiedTime
		call crlf
	.ENDIF
	
	quit:

	exit
main ENDP
AccessFileDateTime PROC 
; Receives: EDX offset of filename, 
;           ESI points to a SYSTEMTIME structure of sysTimeCreated
;           EDI points to a SYSTEMTIME structure of sysTimeLastWritten
; Returns: If successful, CF=0 and two SYSTEMTIME structures contain the file's date/time data. 
;          If it fails, CF=1.
	;open the file
	invoke CreateFile,
		edx,
		GENERIC_READ,
		DO_NOT_SHARE,
		NULL,
		OPEN_EXISTING,
		FILE_ATTRIBUTE_NORMAL,
		0
	;get the handle
	;invoke GetStdHandle, STD_INPUT_HANDLE
	mov fileHandle, eax
	cmp EAX, INVALID_FILE_HANDLE
	je error
	
	;call GetFileTime
	INVOKE GetFileTime, fileHandle, ADDR whenCreated, NULL, ADDR lastWritten

	;call FileTimeToSystemTime
	invoke FileTimeToSystemTime, ADDR whenCreated, esi
	invoke FileTimeToSystemTime, ADDR lastWritten, edi

	;close the file
	invoke CloseHandle, fileHandle
	invoke SystemTimeToTzSpecificLocalTime,	NULL, esi, esi
	invoke SystemTimeToTzSpecificLocalTime, NULL, edi, edi

	jmp success

error:
	stc
	jmp L2
success:
	clc
L2:  
ret
AccessFileDateTime ENDP

WriteDateTime PROC, DateTime:SYSTEMTIME
;Receives: SYSTEMTIME
;Returns: nothing
	xor eax, eax
	mov ax, DateTime.wMonth
	call WriteDec
	mov edx, offset slash
	call WriteString
	mov ax, DateTime.wDay
	call WriteDec
	mov edx, offset slash
	call WriteString
	mov ax, DateTime.wYear
	call WriteDec
	mov al, ' '
	call WriteChar
	mov ax, DateTime.wHour
	call WriteDec
	mov edx, offset colon
	call WriteString
	mov ax, DateTime.wMinute
	call WriteDec
	mov edx, offset colon
	call WriteString
	mov ax, DateTime.wSecond
	call WriteDec
	call crlf 
ret
WriteDateTime ENDP

END main
