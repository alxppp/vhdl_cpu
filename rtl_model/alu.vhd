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
	signal RES_AU : bit_vector(11 downto 0); --Robert
	signal FLAGS_AU : bit_vector(2 downto 0); --Robert

begin

	LU:	entity WORK.logic_unit(struct)
		port map(OP1, OP2, OP, FLAGS_LU, RES_LU);

	AU:	entity WORK.ADDER_UNIT(RTL) --Robert
		port map(OP1, OP2, OP, C_IN, RES_AU, FLAGS_AU); --Robert

	process(RES_LU, FLAGS_LU, FLAGS_AU, RES_AU, OP)
	begin

		case(OP) is
		
		when code_not | code_and | code_or | code_xor | code_rea | code_reo | code_rex =>
			FLAGS <= FLAGS_LU;
			RES <= RES_LU;
		when code_add | code_addc | code_sub | code_subc => --Robert
			FLAGS <= FLAGS_AU; --Robert
			RES <= RES_AU; --Robert
		when others =>
			FLAGS <= (others => '0');
			RES <= (others => '0');
		end case;
	end process;

end struct;
