Test1:	LDC	R0	#0
	JNZ	Error
	LDC R0	#1
	JNZ Test2
	JMP Error

Test2:	LDC	R0	#FFF
	JNN	Error
	LDC	R0	#1
	JNN	Test3
	JMP 	Error

Test3:	LDC	R0	#800
	ADD	R0	R0	R0
	JNC	Error
	LDC	R0	#1
	ADD	R0	R0	R0
	JNC	End
	JMP	Error

Error:	LDC	R3	#FFF	;indicates error in trace
End:	STOP