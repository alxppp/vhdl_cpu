; Test NOT

TEST1:	LDC	R1	0		; test ⌐0 == #FFF
	NOT	R1	R1
	LDC	R2	#FFF		; expected result if #FFF
	SUB	R1	R1	R2	; see if result - expected result is 0
	JZ	TEST2			; delta is 0 -> success
	JMP	ERROR			; delta is not 0 -> error

TEST2:	LDC	R1	#F0		; test ⌐#F0 == #F0F
	NOT	R1	R1
	LDC	R2	#F0F
	SUB	R1	R1	R2
	JZ	SUCCESS
	JMP	ERROR

SUCCESS:
	LDC	R0	0
	STOP

ERROR:	LDC	R0	1
	STOP
