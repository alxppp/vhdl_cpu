; Test JC

	LDC	R1	#800
	ADD	R1	R1	R1
	JC	SUCCESS

ERROR:	LDC	R0	1
	STOP

SUCCESS:
	LDC	R0	0
	STOP
