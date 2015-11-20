entity TB_ROL_GEN_LOG is
end TB_ROL_GEN_LOG;
--generate logfile for rol testbench
architecture BEHAVIOUR of TB_ROL_GEN_LOG is

signal x : bit;

begin
process(x)
use std.TEXTIO.all;
use WORK.cpu_defs_pack.all;
use WORK.cpu_IN_OUT_pack.all;

file logfile : text is out "testbenches/shift_rotate/rol_log.txt";
variable d : data_type := 0;
variable x : integer := 0;
variable msb : integer := 0;
begin	
	for i in 0 to data_type'HIGH loop
		msb := i / 2**(data_width-1);
		x := i*2 + msb; --shift left and append msb
		d := x mod 2**data_width;
		EXEC_OUT(d, logfile);		
	end loop;

end process;

end BEHAVIOUR;
