TITLE Improving_Binary_Search (Chapter 9, Modified)

; Program:     Bsort2.asm
; Description: Rewriting an improved binary search algorithm from the textbook.pg.377
; Student:     David Shin
; Date:        11/6/16
; Class:       CSCI 241
; Instructor:  Mr. Ding

INCLUDE Irvine32.inc

.code
;-------------------------------------------------------------
BinarySearch2 PROC USES ebx edx esi edi,
	pArray:PTR DWORD,		; pointer to array
	Count:DWORD,			; array size
	searchVal:DWORD			; search value

  
; Search an array of signed integers for a single value.
; Receives: Pointer to array, array size, search value.
; Returns: If a match is found, EAX = the array position of the
; matching element; otherwise, EAX = -1.
;-------------------------------------------------------------
	mov	 bl, 0				; first = 0
	mov	 eax,Count			; last = (count - 1)
	dec	 eax
	mov	 bh,eax
	mov	 edi,searchVal		; EDI = searchVal
	mov	 ebx,pArray			; EBX points to the array

L1: ; while first <= last
	mov	 eax,bl
	cmp	 eax,bh
	jg	 L5					; exit search

; mid = (last + first) / 2
	mov	 eax,bh
	add	 eax,bl
	shr	 eax,1
	mov	 dl,eax

; EDX = values[mid]
	mov	 esi,dl
	shl	 esi,2				; scale mid value by 4
	mov	 edx,[ebx+esi]		; EDX = values[mid]

; if ( EDX < searchval(EDI) )
;	first = mid + 1;
	cmp	 edx,edi
	jge	 L1
	mov	 eax,dl				; first = mid + 1
	inc	 eax
	mov	 bl,eax
	jmp	 L1

; else if( EDX > searchVal(EDI) )
;	last = mid - 1;

; else return mid
L3:	mov	 eax,dl  				; value found
	jmp	 L9						; return (mid)

L5:	mov	 eax,-1					; search failed
L9:	ret
BinarySearch2 ENDP
END
