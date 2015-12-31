use WORK.cpu_defs_pack.all;

entity instruction_decoder is

	port(	-- inputs
		INSTR 		: in bit_vector(11 downto 0);
		FLAGS 		: in bit_vector(3 downto 0);
		-- control signals for datapath
		OP 		: out bit_vector(5 downto 0);
		SEL_IN 		: out bit_vector(1 downto 0);
		SEL_OUT_A 	: out bit_vector(1 downto 0);
		SEL_OUT_B 	: out bit_vector(1 downto 0);
		SEL_OUT_C 	: out bit_vector(1 downto 0);
		-- control signals for FSM
		TAKE_JMP	: out bit;
		STORE		: out bit;
		CMD_CALC	: out bit;
		CMD_CONST	: out bit;
		CMD_DIR		: out bit;
		CMD_REG		: out bit;
		CMD_IO		: out bit;
		CMD_PC		: out bit;
		CMD_JMP		: out bit;
		CMD_STOP	: out bit );
		
end instruction_decoder;


architecture case_driven_with_default_assignment of instruction_decoder is
begin
	process(INSTR, FLAGS)
	begin
		OP 		<= INSTR(11 downto 6);
		SEL_IN		<= INSTR(5 downto 4);
		--SEL_OUT_A	<= INSTR(5 downto 4);
		SEL_OUT_C   <= INSTR(5 downto 4); --bugfix
		SEL_OUT_B	<= INSTR(3 downto 2);
		--SEL_OUT_C	<= INSTR(1 downto 0); 
		SEL_OUT_A	<= INSTR(1 downto 0); --bugfix
		
		-- default assignment
		TAKE_JMP <= '0'; STORE <= '0'; CMD_CALC <= '0'; CMD_CONST <= '0'; CMD_DIR <= '0'; 
		CMD_REG <= '0'; CMD_IO <= '0'; CMD_PC <= '0'; CMD_JMP <= '0'; CMD_STOP <= '0';

		case INSTR(11 downto 6) is

		when code_stop => CMD_STOP <= '1';
		when code_add | code_addc | code_sub |  code_subc | code_not | code_and | code_or |
			 code_xor | code_rea | code_reo | code_rex | code_sll | code_srl | code_sra |
			 code_rol | code_rolc | code_ror | code_rorc => CMD_CALC <= '1';
		when code_ldc => CMD_CONST <= '1';
		when code_ldd => CMD_DIR <= '1';
		when code_ldr => CMD_REG <= '1';
		when code_std => CMD_DIR <= '1'; STORE <= '1';
		when code_str => CMD_REG <= '1'; STORE <= '1';
		when code_in => CMD_IO <= '1'; 
		when code_out => CMD_IO <= '1'; STORE <= '1';
		when code_ldpc => CMD_PC <= '1';
		when code_stpc => CMD_PC <= '1'; STORE <= '1';
		when code_jmp => CMD_JMP <= '1'; TAKE_JMP <= '1';
		when code_jz => CMD_JMP <= '1'; TAKE_JMP <= FLAGS(3);
		when code_jc => CMD_JMP <= '1'; TAKE_JMP <= FLAGS(2);
		when code_jn => CMD_JMP <= '1'; TAKE_JMP <= FLAGS(1);
		when code_jo => CMD_JMP <= '1'; TAKE_JMP <= FLAGS(0);
		when code_jnz => CMD_JMP <= '1'; TAKE_JMP <= not FLAGS(3);
		when code_jnc => CMD_JMP <= '1'; TAKE_JMP <= not FLAGS(2);
		when code_jnn => CMD_JMP <= '1'; TAKE_JMP <= not FLAGS(1);
		when code_jno => CMD_JMP <= '1'; TAKE_JMP <= not FLAGS(0);
		when others => null;
	
		end case;
	end process;
end case_driven_with_default_assignment;
