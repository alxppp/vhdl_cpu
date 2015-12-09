entity alu is

	port(	OP1, OP2	: in bit_vector(11 downto 0);
		C_IN		: in bit;
		OP		: in bit_vector(5 downto 0);
		FLAGS		: out bit_vector(2 downto 0);
		RES		: out bit_vector(11 downto 0) );

end alu;

architecture struct of alu is

	use WORK.cpu_defs_pack.all;

	signal RES_LU : bit_vector(11 downto 0);
	signal FLAGS_LU : bit_vector(2 downto 0);

begin

	LU:	entity WORK.logic_unit(struct)
		port map(OP1, OP2, OP, FLAGS_LU, RES_LU);

	process(RES_LU, FLAGS_LU)
	begin

		case(OP) is
		
		when code_not | code_and | code_or | code_xor | code_rea | code_reo | code_rex =>
			FLAGS <= FLAGS_LU;
			RES <= RES_LU;
		when others =>
			FLAGS <= (others => '0');
			RES <= (others => '0');
		end case;
	end process;

end struct;
