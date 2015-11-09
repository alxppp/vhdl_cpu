package cpu_trace_pack is

use WORK.cpu_defs_pack.all;
use STD.textio.all;

function hex_image(d : data_type) return string;
function bool_character(b : Boolean) return character;

procedure write_header(variable f : out text);
procedure write_PC_CMD(variable l : inout line; constant PC : in addr_type; constant OP : in opcode_type; constant X,Y,Z : in reg_addr_type); 
procedure write_noParam( l : inout line);
procedure write_Param(l : inout line; constant p : in data_type);
procedure write_Reg(l : inout line; R : data_type);
procedure write_tail(variable f : out text);
procedure write_flags(variable l : inout line; constant Z,C,N,O : in Boolean);

end cpu_trace_pack;


package body cpu_trace_pack is


function hex_image(d : data_type) return string is

constant hex_table : string (1 to 16) := "0123456789ABCDEF";
variable result : string ( 1 to 3);

begin

	result(3) := hex_table(d mod 16 + 1);
	result(2) := hex_table((d / 16) mod 16 + 1);
	result(1) := hex_table((d / 256) mod 16 + 1);

	return result;
	
end hex_image;

function bool_character(b : Boolean) return character is

begin

	if b then return 'T';
	else return 'F';
	end if;

end bool_character;

procedure write_header( variable f : out text) is 

	variable l : line;

begin

	write(l, string'("PC  | CMD  | XYZ | P   | R0  | R1  | R2  | R3  | ZCNO"));
	writeline(f, l);
	write(l, string'("-----------------------------------------------------"));
	writeline(f, l);

end write_header;

procedure write_PC_CMD(variable l : inout line; constant PC : in addr_type; constant OP : in opcode_type; constant X,Y,Z : in reg_addr_type) is

begin

	write(l, hex_image(PC), left, 3);
	write(l, string'(" | "));
	write(l, cmd_img_table(OP), left, 4);
	write(l, string'(" | "));
	write(l, X, left, 1);
	write(l, Y, left, 1);
	write(l, Z, left, 1);
	write(l, string'(" | "));


end write_PC_CMD;


procedure write_noParam( l : inout line) is

begin 

	write(l, string'("--- | "));

end write_noParam;

procedure write_Param(l : inout line; constant p : in data_type) is

begin

	write(l, hex_image(p));
	write(l, string'(" | "));


end write_Param;

procedure write_Reg(l : inout line; R : data_type) is

begin

	write(l, hex_image(R));
	write(l, string'(" | "));

end write_Reg;

procedure write_tail(variable f : out text) is

	variable l : line;

begin

	write(l, string'("-----------------------------------------------------"));
	writeline(f, l);

end write_tail;

procedure write_flags(variable l : inout line; constant Z,C,N,O : in Boolean) is
begin

	write(l, bool_character(C));
	write(l, bool_character(Z));
	write(l, bool_character(N));
	write(l, bool_character(O));


end write_flags;


end cpu_trace_pack;