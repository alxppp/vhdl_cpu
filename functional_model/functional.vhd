entity System is --Max
end System;



architecture functional of System is --Orestis
begin
	process

		use STD.textio.all;
		use WORK.cpu_defs_pack.all;
		use WORK.cpu_memory_pack.all;
		use WORK.cpu_trace_pack.all;
		use WORK.cpu_general_subprogram_pack.all;
		use WORK.cpu_arithmetic_pack.all;
		use WORK.cpu_logic_pack.all;
		use WORK.cpu_shift_rotate_pack.all;
		use WORK.cpu_IN_OUT_pack.all;

		variable Memory : mem_type;
		variable Reg 	: reg_type;
		variable Instr 	: data_type;
		variable OP	: opcode_type;
		variable X,Y,Z	: reg_addr_type;
		variable PC	: addr_type := 0;
		variable data	: data_type; --Max
		variable Carry, Zero, Negative, Overflow : boolean := FALSE; --Max
		variable l	: line;
		file TraceFile  : text is out "Trace.txt";
		file MemoryFile : text is in "Memory.hex";
		file MemoryDumpFile : text is out "MemoryDump.txt";
		-- Input and Output devices are simulated as two txt files.
		file InDevice   : Text is in "InDevice.txt";	--Orestis
		file OutDevice  : Text is out "OutDevice.txt";  --Orestis
		variable run 	: Boolean := TRUE;

	begin
		init_memory(MemoryFile, Memory);

		write_header(TraceFile);

		while run loop

		-- fetch
		Instr := Memory(PC);
		-- decode
		OP := Instr / (2**reg_addr_width)**3;
		X := ( Instr / (2**reg_addr_width)**2 ) mod 2**reg_addr_width;
		Y := ( Instr / 2**reg_addr_width ) mod 2**reg_addr_width;
		Z := Instr mod 2**reg_addr_width;
		write_PC_CMD(l, PC, OP, X, Y, Z);
		PC := INC(PC);
		-- execute
		case OP is
			-- miscellaneous instructions (NOP, STOP)

			when code_nop	=> 	write_noParam(l); --Orestis
						null;

			when code_stop 	=> 	write_noParam(l); --Orestis
						run := FALSE;

			-- arithmetic instructions (ADD, ADDC, SUB, SUBC)

			when code_add	=> 	Carry := FALSE; --Orestis
						EXEC_ADDC(Reg(Y), Reg(Z), Reg(X), Zero, Carry, Negative, Overflow); -- EXEC_ADDC also works for ADD, if we give assign FLASE to Carry parameter.
						write_noParam(l);

			when code_addc	=> 	EXEC_ADDC(Reg(Y), Reg(Z), Reg(X), Zero, Carry, Negative, Overflow); --Orestis
						write_noParam(l);

			when code_sub	=>	Carry := FALSE; --Robert
						EXEC_SUBC(Reg(Y), Reg(Z), Reg(X), Zero, Carry, Negative, Overflow);
						write_noParam(l);

			when code_subc	=>	EXEC_SUBC(Reg(Y), Reg(Z), Reg(X), Zero, Carry, Negative, Overflow); --Robert
						write_noParam(l);

			-- logical instructions (NOT, AND, OR, XOR, REA, REO, REX) --Robert & Orestis

			when code_not	=>	data := not Reg(Y); Reg(X) := data; --Robert
						Set_Flags_Logic(data, Zero, Carry, Negative, Overflow);
						write_noParam(l);

			when code_and	=>	data := Reg(Y) and Reg(Z); Reg(X) := data; --Robert
						Set_Flags_Logic(data, Zero, Carry, Negative, Overflow);
						write_noParam(l);

			when code_or	=>	data := Reg(Y) or Reg(Z); Reg(X) := data; --Robert
						Set_Flags_Logic(data, Zero, Carry, Negative, Overflow);
						write_noParam(l);

			when code_xor	=>	data := Reg(Y) xor Reg(Z); Reg(x) := data; --Robert
						Set_Flags_Logic(data, Zero, Carry, Negative, Overflow);
						write_noParam(l);

			when code_rea	=>	EXEC_REA(Reg(X), Reg(Y)); --Robert
						Set_Flags_Logic(Reg(X), Zero, Carry, Negative, Overflow);
						write_noParam(l);

			when code_reo	=>	EXEC_REO(Reg(X), Reg(Y));
						Set_Flags_Logic(Reg(X), Zero, Carry, Negative, Overflow);
						write_noParam(l);

			when code_rex	=>	EXEC_REX(Reg(X), Reg(Y));
						Set_Flags_Logic(Reg(X), Zero, Carry, Negative, Overflow);
						write_noParam(l);

			-- shift / rotate instructions (SLL, SRL, SRA, ROL, ROLC, ROR, RORC)

			when code_sll	=>	EXEC_SLL(Reg(Y), Reg(X), Zero, Carry, Negative, Overflow);
						write_noParam(l);

			when code_srl	=>	EXEC_SRL(Reg(Y), Reg(X), Zero, Carry, Negative, Overflow);
						write_noParam(l);

			when code_sra	=>	EXEC_SRA(Reg(Y), Reg(X), Zero, Carry, Negative, Overflow);
						write_noParam(l);

			when code_rol	=>	EXEC_ROL(Reg(Y), Reg(X), Zero, Carry, Negative, Overflow);
						write_noParam(l);

			when code_rolc	=>	EXEC_ROLC(Reg(Y), Reg(X), Zero, Carry, Carry, Negative, Overflow);
						write_noParam(l);

			when code_ror	=>	EXEC_ROR(Reg(Y), Reg(X), Zero, Carry, Negative, Overflow);
						write_noParam(l);

			when code_rorc	=>	EXEC_RORC(Reg(Y), Reg(X), Zero, Carry, Carry, Negative, Overflow);
						write_noParam(l);

			-- memory access instructions (LDC, LDD, LDR, STD, STR)
			when code_ldc	=>	Reg(X) := Memory(PC); -- Alex
						write_param(l, Memory(PC));
						PC := INC(PC);
						Set_Flags_Load(Reg(X), Zero, Carry, Negative, Overflow);

			when code_ldd	=>	Reg(X) := Memory(Memory(PC)); -- Alex
						write_Param(l, Memory(PC));
						PC := INC(PC);
						Set_Flags_Load(Reg(X), Zero, Carry, Negative, Overflow);

			when code_ldr	=>	Reg(X) := Memory(Reg(Y)); -- Alex
						write_noParam(l);
						Set_Flags_Load(Reg(X), Zero, Carry, Negative, Overflow);

			when code_std	=>	data := Reg(X); -- Alex
						Memory(Memory(PC)) := data;
						write_paraM(l, Memory(PC));
						PC := INC(PC);

			when code_str	=>	data := Reg(X); --Max
						Memory(Reg(Y)) := data;
						write_noParam(l);

			-- I/O instructions (IN, OUT)
			when code_in	=>	EXEC_IN(Reg(X), InDevice); --Orestis
						set_flags_load(Reg(X), Zero, Carry, Negative, Overflow);
						write_noParam(l);

			when code_out	=>	EXEC_OUT(Reg(X), OutDevice); --Orestis
						write_noParam(l);


			-- PC instructions (LDPC, STPC)
			when code_ldpc	=>	data := PC; --Max
						Reg(X) := PC;
						write_noParam(l);

			when code_stpc	=>	data := Reg(X); --Max
						PC := Reg(X);
						write_noParam(l);


			-- jump instructions (JMP, JZ, JC, JN, JO, JNZ, JNC, JNN, JNO)

			when code_jmp	=>	write_Param(l, Memory(PC)); --Max
						PC := Memory(PC); 

			when code_jz	=> 	write_Param(l, Memory(PC)); --Robert
						if Zero then PC := Memory(PC);
					    	else PC := INC(PC);
					    	end if;

			when code_jnz	=> 	write_Param(l, Memory(PC)); --Orestis
						if not Zero then PC := Memory(PC);
					    	else PC := INC(PC);
					    	end if;

			when code_jc	=>  	write_Param(l, Memory(PC)); --Robert
						if Carry then PC := Memory(PC);
					    	else PC := INC(PC);
					    	end if;

			when code_jnc	=>  	write_Param(l, Memory(PC)); --Orestis
						if not Carry then PC := Memory(PC);
					    	else PC := INC(PC);
					   	end if;

			when code_jn	=>  	write_Param(l, Memory(PC)); --Robert
						if Negative then PC := Memory(PC);
					    	else PC := INC(PC);
					    	end if;

			when code_jnn	=>  	write_Param(l, Memory(PC)); --Orestis
						if not Negative then PC := Memory(PC);
					    	else PC := INC(PC);
					    	end if;

			when code_jo	=>  	write_Param(l, Memory(PC)); --Robert
						if Overflow then PC := Memory(PC);
					    	else PC := INC(PC);
					    	end if;

			when code_jno	=>  	write_Param(l, Memory(PC)); --Orestis
						if not Overflow then PC := Memory(PC);
					    	else PC := INC(PC);
					    	end if;

			when others	=>      -- Orestis
						assert FALSE
						report "Illegal Operation"
						severity error;
		end case;

			for i in 0 to 2**reg_addr_width - 1 loop

				write_Reg(l, Reg(i));

			end loop;

			write_flags(l, Zero, Carry, Negative, Overflow);
			writeline(TraceFile, l);

		end loop;
		write_tail(TraceFile);
		dump_memory(MemoryDumpFile, Memory);
		wait;

	end process;

end functional;
