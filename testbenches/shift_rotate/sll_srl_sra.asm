				; expectet restult unsigned	| expected result signed	| comments


	LDC	R0	#1	; R0 = 1			| R0 = 1			|
	SLL	R0 	R0	; R0 = 2			| R0 = 2			|
	SLL	R0	R0	; R0 = 4			| R0 = 4			|
	SLL	R0	R0	; R0 = 8			| R0 = 8			|
	SLL	R0	R0	; R0 = 16			| R0 = 16			|
	SLL	R0	R0	; R0 = 32			| R0 = 32			|
	SLL	R0	R0 	; R0 = 64			| R0 = 64			|
	SLL	R0 	R0	; R0 = 128			| R0 = 128			|
	SLL	R0	R0	; R0 = 256			| R0 = 256			|
	SLL	R0	R0 	; R0 = 512			| R0 = 512			|
	SLL	R0	R0	; R0 = 1024			| R0 = 1024			|
	SLL	R0	R0	; R0 = 2048			| R0 = -2048, N = T, O = T	|
	SLL	R0	R0	; R0 = 0, C = T, Z = T		| R0 = 0, O = T, Z = T		|
	SLL	R0	R0	; R0 = 0, Z = T			| R0 = 0, Z = T			|


	LDC	R0	#800	; R0 = 2048			| R0 = -2048, N = T		|
	SRL	R0	R0	; R0 = 1024			| R0 = 1024, O = T		|
	SRL	R0	R0	; R0 = 512			| R0 = 512			|
	SRL	R0	R0	; R0 = 256			| R0 = 256			|
	SRL	R0	R0	; R0 = 128			| R0 = 128			|
	SRL	R0	R0	; R0 = 64			| R0 = 64			|
	SRL	R0	R0	; R0 = 32			| R0 = 32			|
	SRL	R0	R0	; R0 = 16			| R0 = 16			|
	SRL	R0	R0	; R0 = 8			| R0 = 8			|
	SRL	R0	R0	; R0 = 4			| R0 = 4			|
	SRL	R0	R0	; R0 = 2			| R0 = 2			|
	SRL	R0	R0	; R0 = 1			| R0 = 1			|
	SRL	R0	R0	; R0 = 0, Z = T, C = T		| R0 = 0, Z = T, C = T		|
	SRL	R0	R0	; R0 = 0, Z = T			| R0 = 0, Z = T			|

	LDC	R0	#800	; R0 = 2048			| R0 = -2048, N = T		|
	SRA	R0	R0	; R0 = 3072			| R0 = -1024, N = T		|
	SRA	R0	R0	; R0 = 3584			| R0 = -512, N = T		|
	SRA	R0	R0	; R0 = 3840			| R0 = -256, N = T		|
	SRA	R0	R0	; R0 = 3968			| R0 = -128, N = T 		|
	SRA	R0	R0	; R0 = 4032			| R0 = -64, N = T		|
	SRA	R0	R0	; R0 = 4064			| R0 = -32, N = T		|
	SRA	R0	R0	; R0 = 4080			| R0 = -16, N = T		|
	SRA	R0	R0	; R0 = 4088			| R0 = -8, N = T		|
	SRA	R0	R0	; R0 = 4092			| R0 = -4, N = T		|
	SRA	R0	R0	; R0 = 4094			| R0 = -2, N = T		|
	SRA	R0	R0	; R0 = 4095			| R0 = -1, N = T		|
	SRA	R0	R0	; R0 = 4095, C = T		| R0 = -1, N = T		|

	LDC	R0	#400	; R0 = 1024			| R0 = 1024			|
	SRA	R0	R0	; R0 = 512 			| R0 = 512			|
	SRA	R0	R0	; R0 = 256			| R0 = 256			|
	SRA	R0	R0	; R0 = 128			| R0 = 128			|
	SRA	R0	R0	; R0 = 64			| R0 = 64			|
	SRA	R0	R0	; R0 = 32			| R0 = 32			|
	SRA	R0	R0	; R0 = 16			| R0 = 16			|
	SRA	R0	R0	; R0 = 8			| R0 = 8			|
	SRA	R0	R0	; R0 = 4			| R0 = 4			|
	SRA	R0	R0	; R0 = 2			| R0 = 2			|
	SRA	R0	R0	; R0 = 1			| R0 = 1			|
	SRA	R0	R0	; R0 = 0, C = T, Z = T		| R0 = 0, Z = T			|
	SRA	R0	R0	; R0 = 0, Z = T			| R0 = 0, Z = T			|

	STOP	