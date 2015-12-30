library IEEE;
use ieee.numeric_bit.all;
use WORK.cpu_defs_pack.all;

entity Memory is

	port (
		clk : in bit;
		rst : in bit;
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
	    if rst = '0' then
	    
		elsif clk = '1' and clk'EVENT and w_en = '1' then
			Mem(addr(11), addr(10), addr(9), addr(8), addr(7), addr(6), addr(5), addr(4), addr(3), addr(2), addr(1), addr(0)) := data_in;

		end if;
		data_out <= Mem(addr(11), addr(10), addr(9), addr(8), addr(7), addr(6), addr(5), addr(4), addr(3), addr(2), addr(1), addr(0));
	end process;

end rtl;

--bootloader modification (Robert)

use WORK.bootloader_program_pack.all;
architecture rtl_bootloader of Memory is

begin
	process (w_en, addr, data_in, clk, rst )
	--type RAM is array(bit, bit, bit, bit, bit, bit, bit, bit, bit, bit, bit, bit) of bit_vector(11 downto 0);
	variable Mem : RAM;
	begin
	    if rst = '0' then
	       Mem := BOOTLOADER_MEM;
		elsif clk = '1' and clk'EVENT and w_en = '1' then
			--Mem(addr(11), addr(10), addr(9), addr(8), addr(7), addr(6), addr(5), addr(4), addr(3), addr(2), addr(1), addr(0)) := data_in;
            Mem(to_integer(UNSIGNED(addr))) := data_in;
		end if;
		data_out <= Mem(to_integer(UNSIGNED(addr)));
		--data_out <= Mem(addr(11), addr(10), addr(9), addr(8), addr(7), addr(6), addr(5), addr(4), addr(3), addr(2), addr(1), addr(0));
	end process;

end rtl_bootloader;

use WORK.cpu_memory_pack.all;
use STD.textio.all;
architecture hex_load of Memory is --for simulation only

    signal Mem : RAM;

begin

    process(clk, rst)
    
        file MemFile : text is in "Memory.hex";
    begin
        if rst = '0' then
        
           init_memory(MemFile, Mem);
           
        elsif clk = '1' and clk'event then
            if w_en = '1' then
                Mem(to_integer(unsigned(addr))) <= data_in;
            end if;
        end if;
    end process;
    
    data_out <= Mem(to_integer(unsigned(addr)));

end hex_load;