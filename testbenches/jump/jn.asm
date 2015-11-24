; Test JN

TEST_1:			 ; Negative flag expected to be set
	LDC	R1	#800
	JN	TEST_2
	JMP ERROR

TEST_2:			 ; Negative flag expected to be cleared
	LDC	R1	#700
	JN	ERROR

TEST_3:			 ; Negative flag expected to be set
	LDC	R1	#000
	LDC R2  #001
	SUB R1 R1 R2
	JN	SUCCESS
	JMP ERROR
	

ERROR:	LDC	R0	0
	STOP

SUCCESS:
	LDC	R0	1
	STOP
