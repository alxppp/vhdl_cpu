; test JO

TEST1:										; Overflow flag expected to be set
				LDC			R1 #800
				SLL			R1 R1
				JO			TEST2
				JMP ERROR
TEST2:										; Overflow flag expected to be cleared
				LDC			R1 #000
				SLL			R1 R1
				JO			ERROR
				JMP SUCCESS
				
			
ERROR:	LDC	R0	0
	STOP

SUCCESS:
	LDC	R0	1
	STOP