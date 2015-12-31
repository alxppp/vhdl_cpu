				; expectet restult unsigned	| expected result signed	| HEX result


Test1:	LDC	R0	#1	; R0 = 1			| R0 = 1			| R0 = 001
	SLL	R0 	R0	; R0 = 2			| R0 = 2			| R0 = 002
	SLL	R0	R0	; R0 = 4			| R0 = 4			| R0 = 004
	SLL	R0	R0	; R0 = 8			| R0 = 8			| R0 = 008
	SLL	R0	R0	; R0 = 16			| R0 = 16			| R0 = 010
	SLL	R0	R0	; R0 = 32			| R0 = 32			| R0 = 020
	SLL	R0	R0 	; R0 = 64			| R0 = 64			| R0 = 040
	SLL	R0 	R0	; R0 = 128			| R0 = 128			| R0 = 080
	SLL	R0	R0	; R0 = 256			| R0 = 256			| R0 = 100
	SLL	R0	R0 	; R0 = 512			| R0 = 512			| R0 = 200
	SLL	R0	R0	; R0 = 1024			| R0 = 1024			| R0 = 400
	SLL	R0	R0	; R0 = 2048			| R0 = -2048, N = T, O = T	| R0 = 800
	SLL	R0	R0	; R0 = 0, C = T, Z = T		| R0 = 0, O = T, Z = T		| R0 = 000
	SLL	R0	R0	; R0 = 0, Z = T			| R0 = 0, Z = T			| R0 = 000


Test2:	LDC	R0	#800	; R0 = 2048			| R0 = -2048, N = T		| R0 = 800
	SRL	R0	R0	; R0 = 1024			| R0 = 1024, O = T		| R0 = 400
	SRL	R0	R0	; R0 = 512			| R0 = 512			| R0 = 200
	SRL	R0	R0	; R0 = 256			| R0 = 256			| R0 = 100
	SRL	R0	R0	; R0 = 128			| R0 = 128			| R0 = 080
	SRL	R0	R0	; R0 = 64			| R0 = 64			| R0 = 040
	SRL	R0	R0	; R0 = 32			| R0 = 32			| R0 = 020
	SRL	R0	R0	; R0 = 16			| R0 = 16			| R0 = 010
	SRL	R0	R0	; R0 = 8			| R0 = 8			| R0 = 008
	SRL	R0	R0	; R0 = 4			| R0 = 4			| R0 = 004
	SRL	R0	R0	; R0 = 2			| R0 = 2			| R0 = 002
	SRL	R0	R0	; R0 = 1			| R0 = 1			| R0 = 001
	SRL	R0	R0	; R0 = 0, Z = T, C = T		| R0 = 0, Z = T, C = T		| R0 = 000
	SRL	R0	R0	; R0 = 0, Z = T			| R0 = 0, Z = T			| R0 = 000
 
Test3:	LDC	R0	#800	; R0 = 2048			| R0 = -2048, N = T		| R0 = 800
	SRA	R0	R0	; R0 = 3072			| R0 = -1024, N = T		| R0 = C00
	SRA	R0	R0	; R0 = 3584			| R0 = -512, N = T		| R0 = E00
	SRA	R0	R0	; R0 = 3840			| R0 = -256, N = T		| R0 = F00
	SRA	R0	R0	; R0 = 3968			| R0 = -128, N = T 		| R0 = F80
	SRA	R0	R0	; R0 = 4032			| R0 = -64, N = T		| R0 = FC0
	SRA	R0	R0	; R0 = 4064			| R0 = -32, N = T		| R0 = FE0
	SRA	R0	R0	; R0 = 4080			| R0 = -16, N = T		| R0 = FF0
	SRA	R0	R0	; R0 = 4088			| R0 = -8, N = T		| R0 = FF8
	SRA	R0	R0	; R0 = 4092			| R0 = -4, N = T		| R0 = FFC
	SRA	R0	R0	; R0 = 4094			| R0 = -2, N = T		| R0 = FFE
	SRA	R0	R0	; R0 = 4095			| R0 = -1, N = T		| R0 = FFF
	SRA	R0	R0	; R0 = 4095, C = T		| R0 = -1, N = T		| R0 = 000

Test4:	LDC	R0	#400	; R0 = 1024, C = T		| R0 = 1024			| R0 = 400
	SRA	R0	R0	; R0 = 512			| R0 = 512			| R0 = 200
	SRA	R0	R0	; R0 = 256			| R0 = 256			| R0 = 100
	SRA	R0	R0	; R0 = 128			| R0 = 128			| R0 = 080
	SRA	R0	R0	; R0 = 64			| R0 = 64			| R0 = 040
	SRA	R0	R0	; R0 = 32			| R0 = 32			| R0 = 020
	SRA	R0	R0	; R0 = 16			| R0 = 16			| R0 = 010
	SRA	R0	R0	; R0 = 8			| R0 = 8			| R0 = 008
	SRA	R0	R0	; R0 = 4			| R0 = 4			| R0 = 004
	SRA	R0	R0	; R0 = 2			| R0 = 2			| R0 = 002
	SRA	R0	R0	; R0 = 1			| R0 = 1			| R0 = 001
	SRA	R0	R0	; R0 = 0, C = T, Z = T		| R0 = 0, Z = T			| R0 = 000
	SRA	R0	R0	; R0 = 0, Z = T			| R0 = 0, Z = T			| R0 = 000

	STOP	