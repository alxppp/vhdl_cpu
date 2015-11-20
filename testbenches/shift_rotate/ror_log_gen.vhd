entity TB_ROR_GEN_LOG is
end TB_ROR_GEN_LOG;
--generate logfile for ROR testbench
architecture BEHAVIOUR of TB_ROR_GEN_LOG is

signal x : bit;

begin
process(x)
use std.TEXTIO.all;
use WORK.cpu_defs_pack.all;
use WORK.cpu_IN_OUT_pack.all;

file logfile : text is out "testbenches/shift_rotate/ror_log.txt";
variable d : data_type := 0;
variable x : integer := 0;
variable lsb : integer := 0;
begin	
	for i in 0 to data_type'HIGH loop
		lsb := i mod 2;
		x := i/2 + lsb*2**(data_width-1); --shift right and append lsb
		d := x mod 2**data_width;
		EXEC_OUT(d, logfile);		
	end loop;

end process;

end BEHAVIOUR;
