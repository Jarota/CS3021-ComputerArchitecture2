.686                                ; create 32 bit code
.model flat, C                      ; 32 bit memory model
 option casemap:none                ; case sensitive

.data
public g
g DWORD 4

.code

;
; t1.asm
;

public      min

min:		push    ebp             ; push frame pointer
            mov     ebp, esp        ; update ebp
			mov		eax, [ebp+8]	; v = p1
			cmp		eax, [ebp+12]	; if(v > p2)
			jle		cmpparam3		; {
			mov		eax, [ebp+12]	;	v = p2
									; }
cmpparam3:	cmp		eax, [ebp+16]	; if(v > p3)
			jle		minreturn		; {
			mov		eax, [ebp+16]	;	v = p3
									; }
minreturn:	mov     esp, ebp        ; restore esp
            pop     ebp             ; restore ebp
            ret     0               ; return


public		p

p:			push	ebp
			mov		ebp, esp

			push	[ebp+12]
			push	[ebp+8]
			push	g
			call	min
			add		esp, 12

			push	[ebp+20]
			push	[ebp+16]
			push	eax
			call	min
			add		esp, 12

			mov		esp, ebp
			pop		ebp
			ret		0


public		gcd

gcd:		push	ebp
			mov		ebp, esp

			mov		eax, [ebp+12]
			cmp		eax, 0
			jne		gcdcall
			mov		eax, [ebp+8]
			jmp		gcdreturn

gcdcall:	mov		eax, [ebp+8]
			mov		ecx, [ebp+12]
			xor		edx, edx
			idiv	ecx
			push	edx
			push	[ebp+12]
			call	gcd
			add		esp, 8

gcdreturn:	mov		esp, ebp
			pop		ebp
			ret		0
    
    
end
