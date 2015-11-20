;ROLC testbench
;use IO to compare and verify results with a logfile
;therefore requires rolc_log.txt to be in InDevice.txt

main:			LDC		R0 1			;set error flag
				JMP		t1				;carry input = 0

t1return:		JMP		t2				;carry input = 1
t2return:		LDC		R0 0
				STOP

t1:				LDC		R1 #000			;loop through all possible values with carry=0 and compare with logfile
				
t1_loop:		LDC		R3 0			;make sure C=0!
				ROLC	R2 R1			;O=0
				JO		error
				JC		t1_C1			;verify C, Z, N flags
				JMP		t1_C0		
t1flagsok:		IN		R3				;load compare value from logfile
				SUB		R2 R2 R3		;compare value
				JNZ		error

				LDC		R3 1			;update loop values...
				ADD		R1 R1 R3
				JZ		t1_endloop
				JMP		t1_loop
t1_endloop:		JMP		t1return

;switch block
t1_C1:			JNZ		t1_C1_Z0
t1_C1_Z1:		JN		t1CZN			
				JMP		t1CZX
t1_C1_Z0:		JN		t1CXN
				JMP		t1CXX
t1_C0:			JNZ		t1_C0_Z0
t1_C0_Z1:		JN		t1XZN
				JMP		t1XZX
t1_C0_Z0:		JN		t1XXN
				JMP		t1XXX

; CZN
t1XXX:			IN		R3				;C=0, Z=0, N=0
				JNZ		error			;Carry from logfile =1
				OR		R2 R2 R2
				JZ		error			;Z=1
				JN		error			;N=1
				JMP		t1flagsok		;flags are correct

t1XXN:			IN		R3				;C=0, Z=0, N=1
				JNZ		error			;Carry from logfile =1
				OR		R2 R2 R2
				JZ		error			;Z=1
				JNN		error			;N=0
				JMP		t1flagsok		;flags are correct

t1XZX:			IN		R3				;C=0, Z=1, N=0
				JNZ		error			;Carry from logfile =1
				OR		R2 R2 R2
				JNZ		error			;Z=0
				JN		error			;N=1
				JMP		t1flagsok		;flags are correct

t1XZN:			IN		R3				;C=0, Z=1, N=1
				JNZ		error			;Carry from logfile =1
				OR		R2 R2 R2
				JNZ		error			;Z=0
				JNN		error			;N=1
				JMP		t1flagsok		;flags are correct

t1CXX:			IN		R3				;C=1, Z=0, N=0
				JZ		error			;Carry from logfile =0
				OR		R2 R2 R2
				JZ		error			;Z=1
				JN		error			;N=1
				JMP		t1flagsok		;flags are correct

t1CXN:			IN		R3				;C=1, Z=0, N=1
				JZ		error			;Carry from logfile =0
				OR		R2 R2 R2
				JZ		error			;Z=1
				JNN		error			;N=0
				JMP		t1flagsok		;flags are correct

t1CZX:			IN		R3				;C=1, Z=1, N=0
				JZ		error			;Carry from logfile =0
				OR		R2 R2 R2
				JNZ		error			;Z=0
				JN		error			;N=1
				JMP		t1flagsok		;flags are correct

t1CZN:			IN		R3				;C=1, Z=1, N=1
				JZ		error			;Carry from logfile =0
				OR		R2 R2 R2
				JNZ		error			;Z=0
				JNN		error			;N=0
				JMP		t1flagsok		;flags are correct


t2:				LDC		R1 #000			;loop through all possible values with carry=1 and compare with logfile
				
t2_loop:		LDC		R3 #800			
				ADD		R3 R3 R3		;make sure C=1!
				ROLC	R2 R1			;O=0
				JO		error
				JC		t2_C1			;verify C, Z, N flags
				JMP		t2_C0		
t2flagsok:		IN		R3				;load compare value from logfile
				SUB		R2 R2 R3		;compare value
				JNZ		error

				LDC		R3 1			;update loop values...
				ADD		R1 R1 R3
				JZ		t2_endloop
				JMP		t2_loop
t2_endloop:		JMP		t2return

;switch block
t2_C1:			JNZ		t2_C1_Z0
t2_C1_Z1:		JN		t2CZN			
				JMP		t2CZX
t2_C1_Z0:		JN		t2CXN
				JMP		t2CXX
t2_C0:			JNZ		t2_C0_Z0
t2_C0_Z1:		JN		t2XZN
				JMP		t2XZX
t2_C0_Z0:		JN		t2XXN
				JMP		t2XXX

; CZN
t2XXX:			IN		R3				;C=0, Z=0, N=0
				JNZ		error			;Carry from logfile =1
				OR		R2 R2 R2
				JZ		error			;Z=1
				JN		error			;N=1
				JMP		t2flagsok		;flags are correct

t2XXN:			IN		R3				;C=0, Z=0, N=1
				JNZ		error			;Carry from logfile =1
				OR		R2 R2 R2
				JZ		error			;Z=1
				JNN		error			;N=0
				JMP		t2flagsok		;flags are correct

t2XZX:			IN		R3				;C=0, Z=1, N=0
				JNZ		error			;Carry from logfile =1
				OR		R2 R2 R2
				JNZ		error			;Z=0
				JN		error			;N=1
				JMP		t2flagsok		;flags are correct

t2XZN:			IN		R3				;C=0, Z=1, N=1
				JNZ		error			;Carry from logfile =1
				OR		R2 R2 R2
				JNZ		error			;Z=0
				JNN		error			;N=1
				JMP		t2flagsok		;flags are correct

t2CXX:			IN		R3				;C=1, Z=0, N=0
				JZ		error			;Carry from logfile =0
				OR		R2 R2 R2
				JZ		error			;Z=1
				JN		error			;N=1
				JMP		t2flagsok		;flags are correct

t2CXN:			IN		R3				;C=1, Z=0, N=1
				JZ		error			;Carry from logfile =0
				OR		R2 R2 R2
				JZ		error			;Z=1
				JNN		error			;N=0
				JMP		t2flagsok		;flags are correct

t2CZX:			IN		R3				;C=1, Z=1, N=0
				JZ		error			;Carry from logfile =0
				OR		R2 R2 R2
				JNZ		error			;Z=0
				JN		error			;N=1
				JMP		t2flagsok		;flags are correct

t2CZN:			IN		R3				;C=1, Z=1, N=1
				JZ		error			;Carry from logfile =0
				OR		R2 R2 R2
				JNZ		error			;Z=0
				JNN		error			;N=0
				JMP		t2flagsok		;flags are correct


error:			LDC		R0 1
				STOP

;eof