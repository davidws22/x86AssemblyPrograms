TITLE  Fun_with_UNION (Chapter 10, Supplied)
; Program:     Fun_with_UNION.asm
; Description: program to understand the concept of UNIONS

; Student:     David Shin
; Date:        11/16/16
; Class:       CSCI 241
; Instructor:  Mr. Ding

INCLUDE Irvine32.inc
FunUnion UNION
	text  BYTE  'Have fun with UNION!', 0Dh, 0Ah, 0 
	dw3   DWORD 1,2,3,4,5,6,7,8,9,10,11 
	 
FunUnion ENDS


str2 TEXTEQU <"Hello Word">
.data
;str BYTE "Pa at Kevin's house"
u FunUnion <>
msg BYTE "this is type: ", 0
msg2 BYTE "this is sizeof: ", 0
.code
mainu PROC
   mov edx, OFFSET u.text
  ; call writeString


  mov esi, offset u
  mov DWORD PTR [esi], "ZB"

 ; Move some values to union member dw3 here
 ;  mov u.dw3, '3210'
 ;  mov u.dw3 + 4, '0654'
 ;  mov u.dw3 + 8, 00A0Dh
   
   mov edx, offset msg
   call WriteString
   mov eax, type u
   call WriteDec
   call crlf
   mov edx, offset msg2
   call WriteString
   mov eax, sizeof u
   call WriteDec
   call crlf
   mov edx, OFFSET u.text
   call writeString
   ;call CrLf
   exit
mainu ENDP
END  mainu 
