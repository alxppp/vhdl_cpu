package cpu_subprogram_pack_max is

use WORK.cpu_defs_pack.all;
use WORK.bit_vector_natural_pack.all;


procedure EXEC_ROL(constant A : in data_type; variable B : out data_type; variable C,Z,N,O : out Boolean);
procedure EXEC_ROR(constant A : in data_type; variable B : out data_type; variable C,Z,N,O : out Boolean); 
procedure EXEC_ROLC(constant A : in data_type; variable B : out data_type; constant CI : in Boolean; variable CO,Z,N,O : out Boolean); 
procedure EXEC_RORC(constant A : in data_type; variable B : out data_type; constant CI : in Boolean; variable CO,Z,N,O : out Boolean); 



end cpu_subprogram_pack_max;


package body cpu_subprogram_pack_max is

procedure EXEC_ROL(constant A : in data_type; variable B : out data_type; variable C,Z,N,O : out Boolean) is

	variable T : bit_vector(data_width - 1 downto 0);
	variable T_b : bit;
	variable R : integer;

begin

	T := natural2bit_vector(A, data_width);
	T_b := T(T'left);
	T := T(T'left - 1 downto 0) & T_b;

	R := bit_vector2natural(T);
	
	C := FALSE;
	if R = 0 then Z := TRUE;
	else Z := FALSE;
	end if;

	N := Boolean'val(Bit'pos(T(T'left)));

	O := FALSE;

	B := R;

end EXEC_ROL;

procedure EXEC_ROR(constant A : in data_type; variable B : out data_type; variable C,Z,N,O : out Boolean) is

variable T : bit_vector(data_width - 1 downto 0);
	variable T_b : bit;
	variable R : integer;

begin

	T := natural2bit_vector(A, data_width);
	T_b := T(T'right);
	T(T'left - 1 downto 0) := T(T'left downto 1);
	T(T'left) := T_b;

	R := bit_vector2natural(T);
	
	C := FALSE;

	if R = 0 then Z := TRUE;
	else Z := FALSE;
	end if;

	N := Boolean'val(Bit'pos(T(T'left)));

	O := FALSE;

	B := R;

end EXEC_ROR;

procedure EXEC_ROLC(constant A : in data_type; variable B : out data_type; constant CI : in Boolean; variable CO,Z,N,O : out Boolean) is

	variable T : bit_vector(data_width - 1 downto 0);
	variable R : integer;

begin

	T := natural2bit_vector(A, data_width);
	CO := Boolean'val(Bit'pos(T(T'left)));
	T := T(T'left - 1 downto 0) & Bit'val(Boolean'pos(CI));

	R := bit_vector2natural(T);
	
	
	if R = 0 then Z := TRUE;
	else Z := FALSE;
	end if;

	N := Boolean'val(Bit'pos(T(T'left)));

	O := FALSE;

	B := R;

end EXEC_ROLC;

procedure EXEC_RORC(constant A : in data_type; variable B : out data_type; constant CI : in Boolean; variable CO,Z,N,O : out Boolean) is

	variable T : bit_vector(data_width - 1 downto 0);
	variable R : integer;

begin

	T := natural2bit_vector(A, data_width);
	CO := Boolean'val(Bit'pos(T(T'right)));
	T(T'left - 1 downto 0) := T(T'left downto 1);
	T(T'left) := Bit'val(Boolean'pos(CI));

	R := bit_vector2natural(T);
	
	
	if R = 0 then Z := TRUE;
	else Z := FALSE;
	end if;

	N := Boolean'val(Bit'pos(T(T'left)));

	O := FALSE;

	B := R;

end EXEC_RORC;


end cpu_subprogram_pack_max;