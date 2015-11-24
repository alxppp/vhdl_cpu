					;expected result unsigned	| exprected result signed	| HEX result

; same test cases for ADD and ADDC, result should be the same
	LDC	R3	#100		; R3 used to clear flags before executing ADD or ADDC

Test1:	LDD	R1	c1		; R1 = 0, Z = T 		| R1 = 0, Z = T 		| R1 = 000
	LDD	R2	c2		; R2 = 1			| R1 = 1			| R1 = 001

	SRL	R0	R3		; Clear flags
	ADD	R0	R1	R2	; R0 = 1			| R0 = 1			| R0 = 001

	SRL	R0	R3		; Clear flags
	ADDC	R0	R1	R2	; R0 = 1			| R0 = 1			| R0 = 001

Test2:  LDD	R1	c2		; R1 = 1			| R1 = 1			| R1 = 001
	LDD	R2	c3		; R2 = 42			| R2 = 42			| R2 = 02A

	SRL	R0	R3		; Clear flags
	ADD 	R0	R1	R2	; R0 = 43			| R0 = 43			| R0 = 02B

	SRL	R0	R3		; Clear flags
	ADDC	R0	R1	R2	; R0 = 43			| R0 = 43			| R0 = 02B

Test3:	LDD	R1	c4		; R1 = 1024			| R1 = 1024			| R1 = 400
	LDD	R2	c4		; R2 = 1024			| R2 = 1024			| R2 = 400

	SRL	R0	R3		; Clear flags
	ADD 	R0	R1	R2	; R0 = 2048			| R0 = -2048, O = T		| R0 = 800

	SRL	R0	R3		; Clear flags
	ADDC	R0	R1	R2	; R0 = 2048			| R0 = -2048, O = T 	 	| R0 = 800

Test4:  LDD	R1	c4		; R1 = 1024			| R1 = 1024			| R1 = 400
	LDD	R2	c5		; R2 = 2048			| R2 = -2048, N = T 		| R2 = 800

	SRL	R0	R3		; Clear flags
	ADD 	R0	R1	R2	; R0 = 3072			| R0 = -1024, N = T		| R0 = C00

	SRL	R0	R3		; Clear flags
	ADDC 	R0	R1	R2	; R0 = 3072			| R0 = -1024, N = T		| R0 = C00

Test5:	LDD	R1	c5		; R1 = 2048			| R1 = -2048, N = T		| R1 = 800
	LDD	R2	c5		; R2 = 2048			| R2 = -2048, N = T		| R2 = 800

	SRL	R0	R3		; Clear flags
	ADD 	R0	R1	R2	; R0 = 0, C = T, Z = T 		| R0 = 0, O = T, Z = T, N = T	| R0 = 000

	SRL	R0	R3		; Clear flags
	ADDC 	R0	R1	R2	; R0 = 0, C = T, Z = T 		| R0 = 0, O = T, Z = T, N = T	| R0 = 000

Test6:	LDD	R1	c2		; R1 = 1			| R1 = 1			| R1 = 001
	LDD	R2	c6		; R2 = 4095			| R2 = -1			| R2 = FFF

	SRL	R0	R3		; Clear flags
	ADD 	R0	R1	R2	; R0 = 0, C = T, Z = T 		| R0 = 0, Z = T			| R0 = 000

	SRL	R0	R3		; Clear flags
	ADDC 	R0	R1	R2	; R0 = 0, C = T, Z = T 		| R0 = 0, Z = T 		| R0 = 000 

;special test for ADDC
	LDC	R3	#101		; R3 used to set carry flag and clear all other flags

Test7:	LDD	R1	c1		; R1 = 0			| R1 = 0			| R1 = 000
	LDD	R2	c1		; R2 = 0			| R2 = 0			| R2 = 000

	SRA	R0	R3		; set carry flag, clear all other flags
	ADDC	R0	R1	R2	; R0 = 1			| R0 = 1			| R0 = 001

Test8:	LDD	R1	c1		; R1 = 0			| R1 = 0			| R1 = 000
	LDD	R2	c2		; R2 = 1			| R2 = 1			| R2 = 001

	SRA	R0	R3		; set carry flag, clear all other flags
	ADDC	R0	R1	R2	; R0 = 2			| R0 = 2			| R0 = 002

Test9:	LDD	R1	c2		; R1 = 1			| R1 = 1			| R1 = 001
	LDD	R2	c3		; R2 = 42			| R2 = 42			| R2 = 02A

	SRA	R0	R3		; set carry flag, clear all other flags
	ADDC	R0	R1	R2	; R0 = 44			| R0 = 44			| R0 = 02C

Test10:	LDD	R1	c1		; R1 = 0			| R1 = 0			| R1 = 000
	LDD	R2	c7		; R2 = 2047			| R2 = 2047			| R2 = 7FF

	SRA	R0	R3		; set carry flag, clear all other flags
	ADDC	R0	R1	R2	; R0 = 2048			| R0 = -2048, O = T 		| R0 = 800

Test11: LDD	R1	c5		; R1 = 2048			| R1 = -2048			| R1 = 800
	LDD	R2	c6		; R2 = 4095			| R2 = -1			| R2 = FFF

	SRA	R0	R3		; set carry flag, clear all other flags
	ADDC 	R0	R1	R2	; R0 = 2048, C = T 		| R0 = -2048, N = T 		| R0 = 800

Test12: LDD	R1	c5		; R1 = 2048			| R1 = -2048			| R1 = 800
	LDD	R2	c7		; R2 = 2047			| R2 = 2047			| R2 = 7FF

	SRA	R0	R3		; set carry flag, clear all other flags
	ADDC	R0	R1	R2	; R0 = 0, Z = T, C = T 		| R0 = 0, Z = T 		| R0 = 000

Test13: LDD	R1	c1		; R1 = 0			| R1 = 0			| R1 = 000
	LDD	R2	c6		; R2 = 4095			| R2 = -1			| R2 = FFF

	SRA	R0	R3		; set carry flag, clear all other flags
	ADDC 	R0	R1	R2	; R0 = 0, C = T, Z = T		| R0 = 0, Z = T 		| R0 = 000
	
	STOP







;test constants		; unsigned interpretation	| signed interpretation	| HEX
c1:	.db	0	; 0				| 0			| 000
c2:	.db	1	; 1				| 1			| 001
c3:	.db	42	; 42				| 42			| 02A
c4:	.db	1024	; 1024				| 1024			| 400
c5:	.db	2048	; 2048				| -2048			| 800
c6:	.db	4095	; 4095				| -1			| FFF
c7:	.db	2047	; 2047				| 2047			| 7FF
