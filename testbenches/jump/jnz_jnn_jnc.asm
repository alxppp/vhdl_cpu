	LDC	R0	#0
	JNZ	Error

	LDC	R0	#FFF
	JNN	Error

	LDC	R0	#800
	ADD	R0	R0	R0
	JNC	Error

	STOP

Error:	LDC	R3	#FFF	;indicates error in trace
	STOP