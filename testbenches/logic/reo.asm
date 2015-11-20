;testbench REO

main:			LDC		R0 1			;set error flag
				JMP		test1
return1:		JMP		test2

return2:		LDC		R0 0
				STOP

test1:			NOP						;test only FALSE case result and flag behaviour
				LDC		R1 0			;N=1
				REO		R1 R1			;Z=1, C=0, N=0, O=0
				JNZ		error
				JC		error
				JN		error
				JO		error
				JMP		return1

test2:			LDC		R1 #001			;test all TRUE cases result and flag behaviour
				LDC		R3 1
test2_loop:		REO		R2 R1			;Z=0, C=0, N=0, O=0
				JZ		error
				JC		error
				JN		error
				JO		error
				AND		R2 R2 R3		;test result==1
				JZ		error
				ADD		R1 R1 R3
				ADD		R2 R1 R3
				JZ		test2_endloop
				JMP		test2_loop
test2_endloop:	JMP		return2


error:			LDC		R0 1
				STOP

;eof