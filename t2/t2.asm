option casemap:none                ; case sensitive

includelib legacy_stdio_definitions.lib
extrn printf:near

.data
public g
g QWORD 4

.code

;
; t2.asm
;

public      min

min:		mov		rax, rcx		; v = p1
			cmp		rax, rdx		; if(v > p2)
			jle		cmpparam3		; {
			mov		rax, rdx		;	v = p2
									; }
cmpparam3:	cmp		rax, r8			; if(v > p3)
			jle		minreturn		; {
			mov		rax, r8			;	v = p3
									; }
minreturn:  ret     0               ; return


public		p

p:			sub		rsp, 32			; allocate shadow space
			mov		r12, r9			; save l
			mov		r13, r8			; save k
			mov		r14, rdx		; save j
			mov		r15, rcx		; save i

			mov		r8, rdx			; param 3 = j
			mov		rdx, rcx		; param 2 = i
			mov		rcx, g			; param 1 = g
			call	min

			mov		r8, r12
			mov		rdx, r13
			mov		rcx, rax
			call	min
			
			add		rsp, 32
			ret		0


public		gcd

gcd:		mov		rax, rcx
			mov		r10, rdx
			cmp		r10, 0			; if( b == 0 )
			jne		gcdcall			;	return a
			jmp		gcdreturn
gcdcall:	sub		rsp, 32
			mov		rdx, 0
			cqo
			idiv	r10
			mov		rcx, r10
			call	gcd
			add		rsp, 32
gcdreturn:	ret

fq	db		'a = %I64d b = %I64d c = %I64d d = %I64d e = %I64d sum = %I64d\n', 0AH, 00H

public		q

q:			xor		r10, r10
			lea		r10, [rcx+rdx]
			add		r10, r8
			add		r10, r9
			mov		r11, [rbp-16]
			add		r10, r11
			mov		[rsp+24], r10		; save sum in shadow space

			sub		rsp, 56				; 56 bytes of shadow space allocated for 7 printf paramaters
			mov		[rsp+48], r10		; pass sum to printf
			mov		[rsp+40], r11		; pass e
			mov		[rsp+32], r9		; pass d
			mov		r9, r8				; pass c
			mov		r8, rdx				; pass b
			mov		rdx, rcx			; pass a

			lea		rcx, fq				; pass string
			call	printf
			add		rsp, 56				; deallocate shadow space

			mov		rax, [rsp+24]		; return sum
			ret


public		qns

fqns	db		'qns\n', 0AH, 00H

qns:		;sub		rsp, 32				; allocate shadow space
			lea		rcx, fqns			; pass in string to printf
			call	printf
			;add		rsp, 32				; deallocate shadow space
			ret

end
