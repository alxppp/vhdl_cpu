entity Memory is

	port (
		clk : in bit;
		addr : in bit_vector(0 to 11);
		data_in : in bit_vector(11 downto 0);
		w_en : in bit;
		data_out : out bit_vector(11 downto 0)
	);
end Memory;

architecture rtl of Memory is

begin
	process (w_en, addr, data_in, clk )
	type RAM is array(bit, bit, bit, bit, bit, bit, bit, bit, bit, bit, bit, bit) of bit_vector(11 downto 0);
	variable Mem : RAM;
	begin
		if clk = '1' and clk'EVENT and w_en = '1' then
			Mem(addr(11), addr(10), addr(9), addr(8), addr(7), addr(6), addr(5), addr(4), addr(3), addr(2), addr(1), addr(0)) := data_in;

		end if;
		data_out <= Mem(addr(11), addr(10), addr(9), addr(8), addr(7), addr(6), addr(5), addr(4), addr(3), addr(2), addr(1), addr(0));
	end process;

end rtl;

--bootloader modification (Robert)
library IEEE;
use ieee.numeric_bit.all;
use WORK.cpu_defs_pack.all;
use WORK.bootloader_program_pack.all;
architecture rtl_bootloader of Memory is

begin
	process (w_en, addr, data_in, clk )
	--type RAM is array(bit, bit, bit, bit, bit, bit, bit, bit, bit, bit, bit, bit) of bit_vector(11 downto 0);
	variable Mem : RAM := BOOTLOADER_MEM;
	begin
		if clk = '1' and clk'EVENT and w_en = '1' then
			--Mem(addr(11), addr(10), addr(9), addr(8), addr(7), addr(6), addr(5), addr(4), addr(3), addr(2), addr(1), addr(0)) := data_in;
            Mem(to_integer(UNSIGNED(addr))) := data_in;
		end if;
		data_out <= Mem(to_integer(UNSIGNED(addr)));
		--data_out <= Mem(addr(11), addr(10), addr(9), addr(8), addr(7), addr(6), addr(5), addr(4), addr(3), addr(2), addr(1), addr(0));
	end process;

end rtl_bootloader;