		add r0, #4, r3			; g = 4

min:		add r0, r26, r1			; v = a
		sub r27, r1, r0 {C}		; b < v ?
		jge cmpC
		xor r0, r0, r0
		add r0, r27, r1			; v = b
cmpC:		sub r28, r1, r0 {C}		; c < v ?
		jge emin
		xor r0, r0, r0
		add r0, r28, r1			; v = c
emin:		RET r25, 0			; return v
		xor r0, r0, r0


p:		add r0, r3, r10
		add r0, r26, r11
		CALLR r25, min			; x = min(g, i, j)
		add r0, r27, r12

		add r0, r1, r10
		add r0, r28, r11
		CALLR r25, min			; return min(x, k, l)
		add r0, r29, r12

		RET r25, 0
		xor r0, r0, r0


gcd:		sub r0, r27, r0 {C}		; b == 0 ?
		jeq rtrn
		add r0, r26, r1			; return a
		add r0, r26, r10
		CALLR r25, mod			; a % b
		add r0, r27, r11
		add r0, r27, r10
		CALLR r25, gcd			; gcd(b, a % b)
		add r0, r1, r11

rtrn:		RET r25, 0
		xor r0, r0, r0
