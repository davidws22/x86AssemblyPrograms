TITLE  Chapter 3, Problem 1 (Integer_Expression.asm)

; Program:     Chapter 3, Problem 1
; Description: calculates Res = (A + B)  (C + D), using registers and variables
; Student:     David Shin	
; Due Date:    09/08/16    
; Class:       CSCI 241
; Instructor:  Mr. Ding

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
; define variables: varA, varB, varC, varD, and Res
varA	SDWORD	10
varB	SDWORD	20
varC	SDWORD	30
varD	SDWORD	40
Res		SDWORD	?

.code
main1 proc
; calculate Res = (A + B)  (C + D)
   ; calculate A + B	
   MOV EAX, varA
   ADD EAX, varB

   ; calculate C + D	
   MOV EBX, varC
   ADD EBX, varD

   ; calculate (A + B)  (C + D)	
   SUB EAX,EBX
   ; save the result in Res
   MOV Res, EAX
   invoke ExitProcess,0
main1 endp
end main1
