;testbench JNO



main:			LDC			R0 1			;clear success flag
				JMP			test1
return1:		LDC			R0 0			;set success flag
				STOP

test1:			LDC			R1 #800
				SLL			R1 R1			;O=1
				JNO			error
				SLL			R1 R1			;O=0
				JNO			return1
				JMP			error

error:			LDC			R0 1			;clear success flag
				STOP

;eof