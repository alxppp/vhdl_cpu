use WORK.cpu_defs_pack.all;
use WORK.cpu_subprogram_pack.all;

entity logic_unit is

	port(	A, B	 	: in bit_vector(11 downto 0);
		OP		: in bit_vector(5 downto 0);
		FLAGS		: out bit_vector(2 downto 0);
		D_OUT		: out bit_vector(11 downto 0) );


end logic_unit;

architecture struct of logic_unit is

begin

	process(A,B, OP)

	variable res : bit_vector(11 downto 0);

	begin
	
		case OP is
		when code_not =>
			res := not A;

		when code_and =>
			res := A and B;

		when code_or =>
			res := A or B;
		
		when code_xor =>
			res := A xor B;

		when code_rea =>
			res(0) := reduce_and(A);
			res(11 downto 1) := (others => '0');

		when code_reo =>
			res(0) := reduce_or(A);
			res(11 downto 1) := (others => '0');

		when code_rex =>
			res(0) := reduce_xor(A);
			res(11 downto 1) := (others => '0');

		when others => 
			res := (others => '0');

		end case;
		
		FLAGS(2) <= '0';
        FLAGS(1) <= res(11);
        FLAGS(0) <= '0';
        D_OUT <= res;
        
	end process;

end struct;
