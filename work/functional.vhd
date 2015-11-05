entity System is --Max
end System;



architecture functional of System is --Orestis
begin
	process
		use WORK.cpu_defs_pack.all;
		use WORK.cpu_subprogram_pack_orestis.all;
		use WORK.cpu_subprogram_pack_max.all;
		use WORK.cpu_subprogram_pack_robert.all;
		use WORK.mem_defs_pack.all;

		variable Memory : mem_type := memory_content;
		variable Reg 	: reg_type;
		variable Instr 	: data_type;
		variable OP	: opcode_type;
		variable X,Y,Z	: reg_addr_type;
		variable PC	: addr_type := 0;
		variable data	: data_type; --Max
		variable Carry, Zero, Negative, Overflow : boolean; --Max
		
	begin
		-- fetch
		Instr := Memory(PC);
		PC := PC + 1;
		-- decode
		OP := Instr / (2**reg_addr_width)**3;
		X := ( Instr / (2**reg_addr_width)**2 ) mod 2**reg_addr_width;
		Y := ( Instr / 2**reg_addr_width ) mod 2**reg_addr_width;
		Z := Instr mod 2**reg_addr_width;
		-- execute
		case OP is
			-- miscellaneous instructions (NOP, STOP)

			when code_nop	=> 	null;
			when code_stop 	=> 	wait;

			-- arithmetic instructions (ADD, ADDC, SUB, SUBC)

			when code_add	=> 	Carry := FALSE;
						EXEC_ADDC(Reg(Y), Reg(Z), Reg(X), Zero, Carry, Negative, Overflow); -- EXEC_ADDC also works for ADD, if we give assign FLASE to Carry parameter.
			when code_addc	=> 	EXEC_ADDC(Reg(Y), Reg(Z), Reg(X), Zero, Carry, Negative, Overflow);
			
			-- logical instructions (NOT, AND, OR, XOR, REA, REO, REX) --Robert

			when code_not	=>	data := not Reg(Y); Reg(X) := data;
						Set_Flags_Logic(data, Zero, Carry, Negative, Overflow);

			when code_and	=>	data := Reg(Y) and Reg(Z); Reg(X) := data;
						Set_Flags_Logic(data, Zero, Carry, Negative, Overflow);

			when code_or	=>	data := Reg(Y) or Reg(Z); Reg(X) := data;
						Set_Flags_Logic(data, Zero, Carry, Negative, Overflow);

			when code_xor	=>	data := Reg(Y) xor Reg(Z); Reg(x) := data;
						Set_Flags_Logic(data, Zero, Carry, Negative, Overflow);				

			-- shift / rotate instructions (SLL, SRL, SRA, ROL, ROLC, ROR, RORC)

			when code_rol	=>	EXEC_ROL(Reg(X), Reg(Y), Carry, Zero, Negative, Overflow);

			when code_rolc	=>	EXEC_ROLC(Reg(X), Reg(Y), Carry, Carry, Zero, Negative, Overflow);

			when code_ror	=>	EXEC_ROR(Reg(X), Reg(Y), Carry, Zero, Negative, Overflow);

			when code_rorc	=>	EXEC_RORC(Reg(X), Reg(Y), Carry, Carry, Zero, Negative, Overflow);

			-- memory access instructions (LDC, LDD, LDR, STD, STR)
			when code_str	=>	data := Reg(X); --Max
						Memory(Reg(Y)) := data; 

			-- I/O instructions (IN, OUT)

			-- PC instructions (LDPC, STPC)
			when code_ldpc	=>	data := PC; --Max
						Reg(X) := PC;
			when code_stpc	=>	data := Reg(X); --Max
						PC := Reg(X);

			-- jump instructions (JMP, JZ, JC, JN, JO, JNZ, JNC, JNN, JNO)

			when code_jmp	=>	PC := Memory(PC); --Max	
			
			when code_jz	=> 	if Zero then PC := Memory(PC);
					    	else PC := INC(PC);
					    	end if;

			when code_jnz	=> 	if not Zero then PC := Memory(PC);
					    	else PC := INC(PC);
					    	end if;

			when code_jc	=>  	if Carry then PC := Memory(PC);
					    	else PC := INC(PC);
					    	end if;

			when code_jnc	=>  	if not Carry then PC := Memory(PC);
					    	else PC := INC(PC);
					   	end if;

			when code_jn	=>  	if Negative then PC := Memory(PC);
					    	else PC := INC(PC);
					    	end if;

			when code_jnn	=>  	if not Negative then PC := Memory(PC);
					    	else PC := INC(PC);
					    	end if;

			when code_jo	=>  	if Overflow then PC := Memory(PC);
					    	else PC := INC(PC);
					    	end if;

			when code_jno	=>  	if not Overflow then PC := Memory(PC);
					    	else PC := INC(PC);
					    	end if;

			when others	=> -- Orestis
						assert FALSE
						report "Illegal Operation"
						severity error;
		end case;
	end process;

end functional;
