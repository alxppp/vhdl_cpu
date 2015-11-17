; Test STPC

	LDC	R1	5
	LDC	R2	1
	LDC	R3	TEST1

TEST1:	SUB	R1	R1	R3	; loop through 5 times and reset PC using STPC
	JZ	SUCCESS
	STPC	R3			; jump back to TEST1
	JMP	ERROR			; STPC didn't work apparently

SUCCESS:
	LDC	R0	0
	STOP

ERROR:	LDC	R0	1
	STOP
