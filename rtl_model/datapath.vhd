library IEEE;
use IEEE.numeric_bit_unsigned.all;

entity datapath is

	generic( N : natural);
	port(	--clock, reset
		RST, CLK : in bit;
		--data input
		D_IN : in bit_vector(N-1 downto 0);
		--data output, flags
		D_OUT_1, D_OUT_2 : buffer bit_vector(N-1 downto 0);
		FLAGS : buffer bit_vector(3 downto 0);
		--control signals
		SEL_IN, SEL_OUT_A, SEL_OUT_B, SEL_OUT_C : in bit_vector(1 downto 0);
		FC_SEL, REG_EN : in bit;
		OP : bit_vector(5 downto 0) );
		
		
end datapath;

architecture behavioral of datapath is

	type reg_type is array (0 to 3) of bit_vector(N-1 downto 0);

	signal REG: reg_type;
begin 
	process(CLK, RST)

		variable ALU_IN, ALU_RES, RF_IN : bit_vector(N-1 downto 0);
		variable ALU_FLAGS : bit_vector(2 downto 0);
		variable FLAG_IN : bit_vector(3 downto 0); --(Z, C, N, O)

	begin
		if RST = '0' then

			REG <= (others	=> (others => '0'));
			FLAG_IN := B"0000";	

		elsif CLK = '1' and CLK'event then
			ALU_IN := REG(TO_INTEGER(SEL_OUT_A));
			case OP is
				when B"00_0111" => 
					ALU_RES := D_OUT_2 and ALU_IN;
				when others => assert FALSE severity ERROR;
			end case;

			if FC_SEL = '0' then
				RF_IN := ALU_RES;
				FLAG_IN(2 downto 0) := ALU_FLAGS;
			else
				RF_IN := D_IN;
				FLAG_IN(2) := FLAGS(2);
				FLAG_IN(1) := D_IN(N-1);
				FLAG_IN(0) := '0';
			end if;
			--FLAG_IN(3) := nor reduce_or(RF_IN);

			if REG_EN = '1' then
				REG(TO_INTEGER(SEL_IN)) <= RF_IN;
				FLAGS <= FLAG_IN;
			end if;

			
		end if;

	end process;
	D_OUT_2 <= REG(TO_INTEGER(SEL_OUT_B));
	D_OUT_1 <= REG(TO_INTEGER(SEL_OUT_C));
	
end behavioral;