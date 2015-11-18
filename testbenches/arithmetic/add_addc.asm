	LDC	R0	#0
	ADD	R2	R0	R0	;R2 = 0, Zero = TRUE

	LDC	R1	#1
	ADD	R2	R1	R0	;R2 = 1
	ADD	R2	R1	R1	;R2 = 2
	LDC	R0	#400
	ADD 	R2	R0	R0	;unsigned interpretation: R2 = 2048 / signed interpretation: R2 = -2048, Overflow = TRUE
	LDC	R3	#800
	ADD	R2	R3	R0	;unsigned interpretation: R2 = 0, Carry = TRUE, ZERO = TRUE / signed interpretatoion: R2 = 0, Negative = TRUE, Overflow = TRUE
	LDC	R0	#FFF
	ADD	R2	R1	R0	;unsigned interpretation: R2 = 0, Carry = TRUE, ZERO = TRUE / signed interpretation: R2 = 0, Zero = TRUE
	LDC	R0	#0
	ADDC	R2	R0	R0	;carry flag is set from previos addition, R2 = 1
	ADD 	R2	R3	R3	;set carry flag
	LDC	R0	#7FF
	LDC	R1	#0
	ADDC	R2	R1	R0	;unsigned interpretation: R2 = 2048 / signed interpretation: R2 = -2048, Overflow = TRUE
	ADD	R2	R3	R3	;set carry flag
	LDC	R0	#FFF
	ADDC	R2	R1	R0	;unsigned interpretation: R2 = 0, Carry = TRUE, Zero = TRUE / signed interpretation: R2 = 0, Zero = TRUE
	STOP

; #800: u = 2048, s = -2048
; #FFF: u = 4095, s = -1


