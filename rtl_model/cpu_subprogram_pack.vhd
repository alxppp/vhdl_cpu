package cpu_subprogram_pack is

function reduce_or(data : bit_vector(11 downto 0)) return bit;

end cpu_subprogram_pack;




package body cpu_subprogram_pack is

function reduce_or(data : bit_vector(11 downto 0)) return bit is

	variable res : bit;

begin

	res := '0';

	for i in data'range loop
		res := res or data(i);
	end loop;

	return res;

end reduce_or;

end cpu_subprogram_pack;