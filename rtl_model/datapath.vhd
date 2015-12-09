library IEEE;
use IEEE.numeric_bit.all;

use WORK.cpu_defs_pack.all;
use WORK.cpu_subprogram_pack.all;

entity datapath is

	port(	--clock, reset
		RST, CLK : in bit;
		--data input
		D_IN : in bit_vector(11 downto 0);
		--data output, flags
		D_OUT_1, D_OUT_2 : out bit_vector(11 downto 0);
		FLAGS : out bit_vector(3 downto 0);
		--control signals
		SEL_IN, SEL_OUT_A, SEL_OUT_B, SEL_OUT_C : in bit_vector(1 downto 0);
		FC_SEL, REG_EN : in bit;
		OP :in bit_vector(5 downto 0) );
		
		
end datapath;

architecture mixed of datapath is

	type reg_type is array (0 to 3) of bit_vector(11 downto 0);

	signal REG: reg_type;
	signal FLAGS_TMP : bit_vector(3 downto 0);
	signal D_OUT_2_TMP, ALU_IN, ALU_RES : bit_vector(11 downto 0);
	signal ALU_FLAGS : bit_vector(2 downto 0); --(C, N, O)
begin 

    ALU:    entity WORK.ALU(struct)
            port map(ALU_IN, D_OUT_2_TMP, FLAGS_TMP(2), OP, ALU_FLAGS, ALU_RES);
            
	process(CLK, RST)

		variable RF_IN : bit_vector(11 downto 0);
		variable FLAGS_IN : bit_vector(3 downto 0); --(Z, C, N, O)

	begin
		if RST = '0' then

			REG <= (others	=> (others => '0'));
			FLAGS_IN := (others => '0');	

		elsif CLK = '1' and CLK'event then

			if FC_SEL = '0' then
				RF_IN := ALU_RES;
				FLAGS_IN(2 downto 0) := ALU_FLAGS;
			else
				RF_IN := D_IN;
				FLAGS_IN(2) := FLAGS_TMP(2);
				FLAGS_IN(1) := D_IN(11);
				FLAGS_IN(0) := '0';
			end if;
			
			FLAGS_IN(3) := not reduce_or(RF_IN);

			if REG_EN = '1' then
				REG(TO_INTEGER(UNSIGNED(SEL_IN))) <= RF_IN;
				FLAGS_TMP <= FLAGS_IN;
			end if;	
					
		end if;
	end process;
	ALU_IN <= REG(TO_INTEGER(UNSIGNED(SEL_OUT_A)));
	D_OUT_2_TMP <= REG(TO_INTEGER(UNSIGNED(SEL_OUT_B)));
	D_OUT_1 <= REG(TO_INTEGER(UNSIGNED(SEL_OUT_C)));
	FLAGS <= FLAGS_TMP;
	D_OUT_2 <= D_OUT_2_TMP;
	
end mixed;