entity alu is

	port(	OP1, OP2	: in bit_vector(11 downto 0);
		C_IN		: in bit;
		OP		: in bit_vector(5 downto 0);
		FLAGS		: out bit_vector(2 downto 0); --C,N,O
		RES		: out bit_vector(11 downto 0) );

end alu;

architecture struct of alu is

	use WORK.cpu_defs_pack.all;

	signal RES_LU : bit_vector(11 downto 0); --Max
	signal FLAGS_LU : bit_vector(2 downto 0); --Max
	signal RES_AU : bit_vector(11 downto 0); --Robert
	signal FLAGS_AU : bit_vector(2 downto 0); --Robert
	signal RES_SU : bit_vector(11 downto 0); -- Alex
	signal FLAGS_SU : bit_vector(2 downto 0); -- Alex

begin

	LU:	entity WORK.logic_unit(struct) --Max
		port map(OP1, OP2, OP, FLAGS_LU, RES_LU); --Max

	AU:	entity WORK.ADDER_UNIT(RTL) --Robert
		port map(OP1, OP2, OP, C_IN, RES_AU, FLAGS_AU); --Robert

	SU:	entity WORK.SHIFTER_UNIT(RTL) -- Alex
		port map(OP1, OP2, OP, C_IN, RES_SU, FLAGS_SU); -- Alex

	process(RES_LU, FLAGS_LU, FLAGS_AU, RES_AU, OP, RES_SU, FLAGS_SU) --Max
	begin

		case(OP) is

		when code_not | code_and | code_or | code_xor | code_rea | code_reo | code_rex => --Max
			FLAGS <= FLAGS_LU; --Max
			RES <= RES_LU; --Max
		when code_add | code_addc | code_sub | code_subc => --Robert
			FLAGS <= FLAGS_AU; --Robert
			RES <= RES_AU; --Robert
		when code_sll | code_srl | code_sra | code_rol | code_ror | code_rolc | code_rorc => -- Alex
			FLAGS <= FLAGS_SU; -- Alex
			RES <= RES_SU; -- Alex
		when others =>
			FLAGS <= (others => '0');
			RES <= (others => '0');
		end case;
	end process;

end struct;

configuration ALU_CONFIG of ALU is

	for struct
	end for;

end ALU_CONFIG;