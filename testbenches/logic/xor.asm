; Test XOR

TEST1:	LDC	R1	0		; test 0 ⊻ 0 == 0
	XOR	R1	R1	R1
	JNZ	ERROR

TEST2:	LDC	R1	0		; test 0 ⊻ #FFF == #FFF
	LDC	R2	#FFF
	XOR	R1	R1	R2
	SUB	R1	R1	R2
	JNZ	ERROR

TEST3:	LDC	R1	1		; test 1 ⊻ 2 == 3
	LDC	R2	2
	XOR	R2	R1	R2
	LDC	R3	3
	SUB	R3	R2	R3
	JNZ	ERROR

TEST4:	LDC	R1	#FFF		; test #FFF ⊻ #FFF == 0
	XOR	R1	R1	R1
	JNZ	ERROR

TEST5:	LDC	R1	#ABC		; test XOR swap
	XOR	R1	R1	R2	; swap R1 and R2
	XOR	R2	R1	R2	; ------ " -----
	XOR	R1	R1	R2	; ------ " -----
	LDC	R3	#ABC		; R2 should be #ABC now
	SUB	R1	R2	R3
	JNZ	ERROR

SUCCESS:
	LDC	R0	0
	STOP

ERROR:	LDC	R0	1
	STOP
