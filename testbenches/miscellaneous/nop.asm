; NOP testbench
main:		LDC		R0 #1		;clear success register
			JMP		test1
return:		LDC		R0 #0		;set success register
			STOP


;Test NOP does not affect flags...
test1:		LDC		R1 #0		;Z=1
			NOP
			JNZ		error
			LDC		R1 #800		;N=1
			NOP
			JNN		error
			LDC		R1 #FFF
			SLL		R1 R1		;C=1
			NOP
			JNC		error
			LDC		R2 #800
			ADD		R1 R1 R2	;O=1
			NOP
			JNO		error
			JMP		return

error:		LDC		R0 #1
			STOP

;eof