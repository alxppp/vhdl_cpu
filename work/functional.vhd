entity System is --Max
end System;



architecture functional of System is --Ortesis
begin
	process
		use WORK.cpu_defs_pack.all;
		--use WORK.mem_defs_pack.all;

		variable Memory : mem_type;
		variable Reg 	: reg_type;
		variable Instr 	: data_type;
		variable OP	: opcode_type;
		variable X,Y,Z	: reg_addr_type;
		variable PC	: addr_type := 0;
		variable data	: data_type; --Max
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
			when others	=> -- Ortesis
				assert FALSE
				report "Illegal Operation"
				severity error;
		end case;
	end process;

end functional;
