entity TB_ROLC_GEN_LOG is
end TB_ROLC_GEN_LOG;
--generate logfile for ROLC testbench
architecture BEHAVIOUR of TB_ROLC_GEN_LOG is

signal x : bit;

begin
process(x)
use std.TEXTIO.all;
use WORK.cpu_defs_pack.all;
use WORK.cpu_IN_OUT_pack.all;

file logfile : text is out "testbenches/shift_rotate/rolc_log.txt";
variable d : data_type := 0;
variable x : integer := 0;
variable c_out : data_type := 0;
begin	
	--first test run with input carry = 0
	for i in 0 to data_type'HIGH loop
		--msb := i / 2**(data_width-1);
		x := i*2 ;--+ msb; --shift left and done (because c=0)
		d := x mod 2**data_width;
		c_out := x / 2**data_width;
		EXEC_OUT(c_out, logfile); --first save carry out
		EXEC_OUT(d, logfile);		
	end loop;

	--second test run with input carry = 1
	for i in 0 to data_type'HIGH loop
		x := i*2 + 1;--(because c=1)
		d := x mod 2**data_width;
		c_out := x / 2**data_width;
		EXEC_OUT(c_out, logfile); --first save carry out
		EXEC_OUT(d, logfile);		
	end loop;

end process;

end BEHAVIOUR;
