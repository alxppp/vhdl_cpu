entity TB_REX_GEN_LOG is
end TB_REX_GEN_LOG;
--generate logfile for rex testbench
architecture BEHAVIOUR of TB_REX_GEN_LOG is

signal x : bit;

begin
process(x)
use std.TEXTIO.all;
use WORK.cpu_defs_pack.all;
use WORK.cpu_IN_OUT_pack.all;

file logfile : text is out "testbenches/logic/rex_log.txt";
variable tgl : boolean := FALSE;
variable d : data_type := 0;
variable x : boolean := FALSE;
begin	
	for i in 0 to data_type'HIGH loop
		x := boolean'VAL(i / 2**(data_width-1)); --MSB
		for j in data_width-2 downto 0 loop
			x := x XOR boolean'VAL((i / 2**j) mod 2);
		end loop;
		d := boolean'POS(x);
		EXEC_OUT(d, logfile);
	end loop;

end process;

end BEHAVIOUR;