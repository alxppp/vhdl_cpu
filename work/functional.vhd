entity System is --Max
end System;



architecture functional of System is --Orestis
begin
	process
		use WORK.cpu_defs_pack.all;
		use WORK.cpu_subprogram_pack_orestis.all;
		--use WORK.mem_defs_pack.all;

		variable Memory : mem_type;
		variable Reg 	: reg_type;
		variable Instr 	: data_type;
		variable OP	: opcode_type;
		variable X,Y,Z	: reg_addr_type;
		variable PC	: addr_type := 0;
		variable data	: data_type; --Max
		variable Carry, Zero, Negative, Overflow : boolean;
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
			when code_nop	=> 	null;
			when code_stop 	=> 	wait;
			when code_str	=>	data := Reg(X); --Max
						Memory(Reg(Y)) := data; 
			when code_ldpc	=>	data := PC; --Max
						Reg(X) := PC;
			when code_stpc	=>	data := Reg(X); --Max
						PC := Reg(X);
			when code_jmp	=>	PC := Memory(PC); --Max	
			when code_add	=> 	Carry := FALSE;
					   	EXEC_ADDC(Reg(Y), Reg(Z), Reg(X), Zero, Carry, Negative, Overflow); -- EXEC_ADDC also works for ADD, if we give assign FLASE to Carry parameter.
			when code_addc	=> 	EXEC_ADDC(Reg(Y), Reg(Z), Reg(X), Zero, Carry, Negative, Overflow);
			when code_jz	=> if Zero then
						PC := Memory(PC);
					    else
						PC := INC(PC);
					    end if;
			when code_jnz	=> if not Zero then
						PC := Memory(PC);
					    else
						PC := INC(PC);
					    end if;
			when code_jc	=>  if Carry then
						PC := Memory(PC);
					    else
						PC := INC(PC);
					    end if;
			when code_jnc	=>  if not Carry then
						PC := Memory(PC);
					    else
						PC := INC(PC);
					    end if;
			when code_jn	=>  if Negative then
						PC := Memory(PC);
					    else
						PC := INC(PC);
					    end if;
			when code_jnn	=>  if not Negative then
						PC := Memory(PC);
					    else
						PC := INC(PC);
					    end if;
			when code_jo	=>  if Overflow then
						PC := Memory(PC);
					    else
						PC := INC(PC);
					    end if;
			when code_jno	=>  if not Overflow then
						PC := Memory(PC);
					    else
						PC := INC(PC);
					    end if;
			when others	=> -- Orestis
				assert FALSE
				report "Illegal Operation"
				severity error;
		end case;
	end process;

end functional;
