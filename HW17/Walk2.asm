TITLE Drunkard's Walk 					(Walk2.asm)

; Program:     Drunkards_Walk_Enhanced (Chapter 10)
; Description: Drunkard's walk program. The professor starts at 
;				coordinates 39,10 and wanders around the immediate area.
; Student:     David Shin
; Date:        11/20/16
; Class:       CSCI 241
; Instructor:  Mr. Ding

INCLUDE Irvine32.inc
WalkMax = 256
;drunkard will always start at center
StartX = 39
StartY = 10

DrunkardWalk STRUCT
	path COORD WalkMax DUP(<0,0>)
	pathsUsed WORD 0
DrunkardWalk ENDS


.data
prompt BYTE "How many steps the drunkard to move: ", 0
aWalk DrunkardWalk <>


.code
main PROC
	mov edx, offset prompt
	call WriteString
	call ReadDec ;returns the integer in eax
	mov aWalk.pathsUsed, ax

	mov	esi,OFFSET aWalk
	call	TakeDrunkenWalk2
	call ShowPath
	exit
main ENDP

;-------------------------------------------------------
TakeDrunkenWalk2 PROC
; Take a walk in random directions (north, south, east,
; west).
; Receives: ESI points to a DrunkardWalk structure
;			AX, number of steps to take
; Returns:  the structure is initialized with random values
;-------------------------------------------------------
	pushad
	mov EDX, 0
	mov EBX, 0
; Use the OFFSET operator to obtain the address of
; path, the array of COORD objects, and copy it to EDI.
	mov	edi,esi
	add	edi,OFFSET DrunkardWalk.path
	mov	ecx,eax			; loop counter
	mov	dx, StartX		; current X-location
	mov	bx ,StartY		; current Y-location
	
Again:
	; Insert current location in array.
	mov	(COORD PTR [edi]).X,dx
	mov	(COORD PTR [edi]).Y,bx
	call DisplayPosition2
Gen:
	mov	  eax,4			; choose a direction (0-3)
	call  RandomRange

	.IF eax == 0		; North
	  dec bx
	.ELSEIF eax == 1	; South
	  inc bx
	.ELSEIF eax == 2	; West
	  dec dx
	.ELSE			; East (EAX = 3)
	  inc dx
	.ENDIF
	
	;comparisions to origin
	.IF (edx == 39 && ebx == 10)
		mov dx, (COORD PTR [edi]).X
		mov bx, (COORD PTR [edi]).Y
		jmp Gen
	.ENDIF
	
	add	edi,TYPE COORD		; point to next COORD
	loop	Again

Finish:
	mov (DrunkardWalk PTR [esi]).pathsUsed, WalkMax
	popad
	call crlf
	call WaitMsg
	ret
TakeDrunkenWalk2 ENDP

;-------------------------------------------------------
DisplayPosition2 PROC 
; Display the current X and Y positions.
;-------------------------------------------------------
.data
commaStr BYTE ",",0
openParen BYTE '(', 0
closeParen BYTE ')', 0
space BYTE " ", 0

.code
	pushad
	;ebx contains Y, and EDX contains X
	;saving x...
	mov eax, edx
	mov edx, offset openParen
	call WriteString
	; current X position
	call	 WriteDec
	mov	 edx,OFFSET commaStr	; "," string
	call	 WriteString
	mov eax, ebx			; current Y position
	call	 WriteDec
	mov edx, offset closeParen 
	call WriteString
	mov edx, offset space
	call WriteString
	popad
	ret
DisplayPosition2 ENDP

;-------------------------------------------------------
ShowPath PROC 
; Displays the path of the drunkard using the set coordinates.
;-------------------------------------------------------
	pushad
	xor edx, edx
	add esi,OFFSET DrunkardWalk.path
	dec eax
	mov ecx, eax
	xor eax, eax
	call GetTextColor
	mov ebx, eax
	ror bl, 4 ;this contains the color flip
	mov eax, ebx
	call SetTextColor
	mov dh, StartY
	mov dl, StartX
	call Gotoxy
	mov al, 'O'
	call WriteChar
	mov eax, 500
	call Delay
	ror bl, 4
	mov eax, ebx ;eax has original color
	call SetTextColor
	mov al, 'O'
	call Gotoxy
	call WriteChar
	add esi, TYPE COORD
L1:
	mov dx, (COORD PTR [esi]).X
	mov ax, (COORD PTR [esi]).Y
	shl ax, 8
	or dx, ax
	call Gotoxy
	ror bl, 4
	mov eax, ebx ;eax has original color
	call SetTextColor
	mov al, '*'
	call WriteChar
	mov eax, 500
	call Delay
	ror bl, 4
	mov eax, ebx ;eax has original color
	call SetTextColor
	mov al, '*'
	call Gotoxy
	call WriteChar
	add esi, TYPE COORD

loop L1
	
	popad
	call crlf
	ret
ShowPath ENDP



END main
