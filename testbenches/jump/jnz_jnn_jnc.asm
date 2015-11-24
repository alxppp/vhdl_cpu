Test1:	LDC	R0	#0	; Z = T
	JNZ	Error 		; jump should not be executed
	LDC R0	#1		; Z = F
	JNZ Test2		; jump to Test2 has to be executed
	JMP Error 		

Test2:	LDC	R0	#FFF	; N = T
	JNN	Error 		; jump should not be execute
	LDC	R0	#1 	; N = F
	JNN	Test3 		; jump to Test2 has to be executed
	JMP 	Error

Test3:	LDC	R0	#801 	
	SLL	R0	R0 	; C = T
	JNC	Error 		; jump should not be executed
	LDC	R0	#1 
	SLL	R0	R0 	; C = F
	JNC	End 		; jump to End has to be executed
	JMP	Error

Error:	LDC	R3	#FFF	; #FFF in R3 signalize error during test
End:	STOP