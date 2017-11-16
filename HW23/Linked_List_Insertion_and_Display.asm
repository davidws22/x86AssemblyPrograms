TITLE  Linked_List_Insertion_and_Display 

; Program:     Chapter 11, Problem 11
; Description: Implementation of a singly linked list using dynamic memory allocation
; Student:     David Shin
; Date:        12/3/16	
; Class:       CSCI 241
; Instructor:  Mr. Ding

INCLUDE Irvine32.inc
GetProcessHeap PROTO 
HeapAlloc PROTO,
	hHeap:HANDLE, 
	dwFlags:DWORD,
	dwBytes:DWORD
HeapFree PROTO,
	hHeap:HANDLE,
	dwFlags:DWORD,
	lpMem:DWORD

NODE STRUCT
    intVal SDWORD ?
    pNext DWORD ?
NODE ENDS
PNODE TYPEDEF PTR NODE

.data
hHeap HANDLE ?
prompt BYTE "Enter a signed integer node value (zero to end): ",0
head NODE <0,0> ; Dummy head

arrow BYTE "->", 0
contents BYTE "Contents of linked list: ", 0
dummy BYTE "Dummy Head " , 0
;pTailNode PNODE ?
;pCurrNode PNODE ?

.code
main PROC
	INVOKE GetProcessHeap
	.IF eax == NULL
		jmp quit
	.ELSE
		mov hHeap, eax
	.ENDIF

	mov edi, offset head
;initialization of new nodes.
L1: 
	mov edx,OFFSET prompt
	call WriteString
	call ReadInt
	mov ebx, eax ;ebx contains myVal
	.IF EAX == 0
		call crlf
		call crlf
		mov edx, offset contents
		call WriteString
		call crlf
		jmp display
	.ELSE
		INVOKE HeapAlloc, hHeap, HEAP_ZERO_MEMORY+NULL, SIZEOF NODE
		mov esi, eax
		mov (NODE PTR [EDI]).pNext, eax
		mov	(NODE PTR [esi]).intVal, ebx 
		mov (NODE PTR [esi]).pNext, 0
		mov edi, eax
	.ENDIF
	jmp L1


;displaying and freeing dynamic memory
display:
	mov edx, offset dummy
	call WriteString
	mov edx, offset arrow
	call WriteString
	mov al, ' '
	call WriteChar

	mov  esi, head.pNext
	.IF esi == 0
		jmp quit
	.ENDIF

; Display the integers in the Node members.
NextNode:
	mov eax, (NODE PTR [ESI]).intVal
	call WriteInt
	mov edi, (NODE PTR [ESI]).pNext
	invoke HeapFree, hHeap, 0, esi
	mov esi, edi
	.IF ESI == 0
		JMP quit
	.ENDIF
	mov al, ' '
	call WriteChar
	mov edx, offset arrow
	call WriteString
	call WriteChar
	
jmp  NextNode	
quit:
	call crlf
	exit
main ENDP
END main
