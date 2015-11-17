; Test AND

TEST1:	LDC	R1	0		; test 0 & 0 == 0
	AND	R1	R1	R1
	JNZ	ERROR

TEST2:	LDC	R1	#FFF		; test 0 & #FFF == 0
	LDC	R2	0
	AND	R1	R1	R2
	JNZ	ERROR

TEST3:	LDC	R1	#FFF		; test 1 & #FFF == 1
	LDC	R2	1
	AND	R3	R1	R2
	SUB	R3	R3	R2
	JNZ	ERROR

TEST4:	LDC	R1	#FFF		; test #FFF & #FFF == #FFF
	LDC	R2	#FFF
	AND	R3	R1	R2
	SUB	R3	R3	R2
	JNZ	ERROR

SUCCESS:
	LDC	R0	0
	STOP

ERROR:	LDC	R0	1
	STOP