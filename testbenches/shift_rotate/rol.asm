;ROL testbench
;use IO to compare and verify results with a logfile
;therefore requires rol_log.txt to be in InDevice.txt

main:			LDC		R0 1			;set error flag
				JMP		t1

t1return:		LDC		R0 0
				STOP

t1:				LDC		R1 #000			;loop through all possible values and compare with logfile
				
t1_loop:		ROL		R2 R1			;C=0, O=0
				JC		error
				JO		error
				JZ		t1if1			;verify Z and N flag
				JMP		t1else1		
t1endif1:		IN		R3				;load compare value from logfile
				SUB		R2 R2 R3		;compare
				JNZ		error
				LDC		R3 1			;update loop values...
				ADD		R1 R1 R3
				JZ		t1_endloop
				JMP		t1_loop
t1_endloop:		JMP		t1return


t1if1:			JN		t1if2			;Z=1, N=1
										;else Z=1, N=0
				OR		R2 R2 R2		;verify for Z=1 --> check if R2==0
				JNZ		error			
				LDC		R3 #800			
				AND		R3 R2 R3		;verify for N=0 --> check if MSB(R2)==0
				JNZ		error
				JMP		t1endif1

t1if2:			LDC		R3 #800
				OR		R2 R2 R2		;verify for Z=1 --> check if R2==0
				JNZ		error
				AND		R3 R2 R3		;verify for N=1 --> check if MSB(R2)==1
				JZ		error
				JMP		t1endif1	

t1else1:		JN		t1else2			;Z=0, N=1
										;else Z=0, N=0
				OR		R2 R2 R2		;verify for Z=0 --> check if R2!=0
				JZ		error
				LDC		R3 #800			;verify for N=0 --> check if MSB(R2)==0
				AND		R3 R2 R3
				JNZ		error
				JMP		t1endif1

t1else2:		OR		R2 R2 R2		;verify for Z=0 --> check if R2!=0
				JZ		error
				LDC		R3 #800
				AND		R3 R2 R3		;verify for N=1 --> check if MSB(R1)==1
				JZ		error
				JMP		t1endif1		

error:			LDC		R0 1
				STOP

;eof