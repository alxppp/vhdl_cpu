entity logic_unit is

	port(	A, B	 	: in bit_vector(11 downto 0);
		OP		: in bit_vector(5 downto 0);
		FLAGS		: out bit_vector(2 downto 0);
		D_OUT		: out bit_vector(11 downto 0) );


end logic_unit;

architecture struct of logic_unit is

	use WORK.cpu_defs_pack.all;

begin

	process(A,B, OP)

	variable res : bit_vector(11 downto 0);

	begin
	
		case OP is
		when code_not =>
			res := not A;
			FLAGS(2) <= '0';
			FLAGS(1) <= res(11);
			FLAGS(0) <= '0';
			D_OUT <= res;

		when code_and =>
			res := A and B;
			FLAGS(2) <= '0';
			FLAGS(1) <= res(11);
			FLAGS(0) <= '0';
			D_OUT <= res;	

		when code_or =>
			res := A or B;
			FLAGS(2) <= '0';
			FLAGS(1) <= res(11);
			FLAGS(0) <= '0';
			D_OUT <= res;			

		when code_xor =>
			res := A xor B;
			FLAGS(2) <= '0';
			FLAGS(1) <= res(11);
			FLAGS(0) <= '0';
			D_OUT <= res;

		when others => 
			D_OUT <= (others => '0');
			FLAGS <= (others => '0');

		end case;
	end process;

end struct;
