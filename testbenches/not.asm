; Test NOT

TEST1:	LDC	R1	0		; test ⌐0 == #FFF
	NOT	R1	R1
	LDC	R2	#FFF		; expected result if #FFF
	SUB	R1	R1	R2	; see if result - expected result is 0
	JZ	SUCCESS			; delta is 0 -> success
	JMP	ERROR			; delta is not 0 -> error

SUCCESS:
	LDC	R1	0
	STOP

ERROR:	LDC	R1	1
	STOP
