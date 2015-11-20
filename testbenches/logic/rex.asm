;testbench REX
;use IO to compare and verify results with a logfile
;therefore requires rex_log.txt to be in InDevice.txt

main:			LDC		R0 1			;set error flag
				JMP		test1

return1:		LDC		R0 0
				STOP

test1:			LDC		R1 #000			;loop through all possible values and compare with logfile
				
test1_loop:		REX		R2 R1			;C=0, N=0, O=0
				JC		error
				JN		error
				JO		error
				IN		R3				;load compare value from logfile
				SUB		R2 R2 R3		;compare
				JNZ		error
				LDC		R3 1			;update loop values...
				ADD		R1 R1 R3
				ADD		R2 R1 R3
				JZ		test1_endloop
				JMP		test1_loop
test1_endloop:	JMP		return1


error:			LDC		R0 1
				STOP

;eof