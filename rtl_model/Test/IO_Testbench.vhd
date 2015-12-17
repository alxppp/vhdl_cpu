library IEEE;
use IEEE.numeric_bit.all;

use STD.textio.all;
use WORK.cpu_defs_pack.all;
use WORK.cpu_IN_OUT_pack.all;


entity IO_Testbench is
	port(	--Reset and Clock signals
		CLK : in bit;
		RST : in bit;
	
		--Input Device Signals
		IN_REQ : in bit;
		IN_READY : out bit;
		IN_DATA : out bit_vector(11 downto 0);

		--Output Device Signals
		OUT_READY : in bit;
		OUT_REQ : out bit;
		OUT_DATA : in bit_vector(11 downto 0) );
end IO_Testbench;

architecture TB of IO_Testbench is
begin

	process(RST, CLK)

		variable TMP : data_type; -- integer type to reuse cpu_IN_OUT_pack from functional model
		file InDevice   : Text is in "InDevice.txt";
		file OutDevice  : Text is out "OutDevice.txt";

	begin
		if(RST = '0') then
			IN_READY <= '0';
			IN_DATA <= (others => '0');
			OUT_REQ <= '1';

		elsif CLK = '1' and CLK'event then

			if IN_REQ = '1' and not endfile(InDevice) then
				IN_READY <= '0';
				EXEC_IN(TMP, InDevice);
				IN_DATA <= bit_vector(TO_UNSIGNED(TMP, 12));
				IN_READY <= '1';
			else 
				IN_READY <= '0';
			end if;

			if OUT_READY = '1' then
				OUT_REQ <= '0';
				TMP := TO_INTEGER(UNSIGNED(OUT_DATA));
				EXEC_OUT(TMP, OutDevice);
			end if;

		end if;
	end process;


end TB;

