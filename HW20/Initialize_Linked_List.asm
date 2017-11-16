TITLE  Initialize_Linked_List (Chapter 10, Supplied)

; Program:     Chapter 10, List.asm
; Description: Initialize a linked list containing the first
;				15 numbers of the fibonacci sequence.
; Student:     David Shin
; Date:        11/22/16
; Class:       CSCI 241
; Instructor:  Mr. Ding

INCLUDE Irvine32.inc

;list segment
ListNode STRUCT
  NodeData DWORD ?
  NextPtr  DWORD ?
ListNode ENDS

;values for list
TotalNodeCount = 15
NULL = 0
Counter = 0
val1  = 0
val2  = 1
val3 = 0

.data
LinkedList LABEL PTR ListNode
REP TotalNodeCount
	Counter = Counter + 1
	val3 = val1 + val2
	val2 = val1
	val1 = val3
	IF (Counter EQ 15)
		ListNode <val3, 0> 
	ELSE
		ListNode <val3, ($ + Counter * SIZEOF ListNode)>
	ENDIF
ENDM

.code
main PROC
	mov  esi,OFFSET LinkedList

; Display the integers in the NodeData members.
;NextNode:
	; Check for the tail node.
;	mov  eax,(ListNode PTR [esi]).NextPtr
;	cmp  eax,NULL
;	je   quit
	mov ecx, 15
L1:

	; Display the node data.
	mov  eax,(ListNode PTR [esi]).NodeData
	call WriteDec
	mov al, ' '
	call WriteChar

	; Get pointer to next node.
	mov  esi,(ListNode PTR [esi]).NextPtr
	;jmp  NextNode
	loop L1
;quit:
	call crlf
	exit
main ENDP
END main
