package cpu_subprogram_pack_orestis is

	use WORK.cpu_defs_pack.all;

	function INC(constant PC :in addr_type) return addr_type;
	procedure EXEC_ADDC (   constant A,B	: in data_type;
				variable R	: out data_type;
				variable Z	: out Boolean;
				variable C	: inout Boolean;
				variable N,O	: out Boolean );


end cpu_subprogram_pack_orestis;





package body cpu_subprogram_pack_orestis is

	function INC(constant PC :in addr_type) return addr_type is
	begin
		return (PC + 1) mod (2**addr_width);
	end INC;


	-- ADDC implementation appropriate both for ADD and ADDC instructons. See Skript 152-153.
	procedure EXEC_ADDC (   constant A,B	: in data_type;
				variable R	: out data_type;
				variable Z	: out Boolean;
				variable C	: inout Boolean;
				variable N,O	: out Boolean ) is
		variable A_s, B_s, T_s : integer;
		variable T 	       : integer := A + B + Boolean'Pos(C);
	begin
		if A >= 2**(data_width - 1) then
			A_s := A - 2**data_width;
		else
			A_s := A;
		end if;

		if  B >= 2**(data_width - 1) then 
			B_s := B - 2**data_width;
		else
			B_s := B;
		end if;

		T_s := A_S + B_s + Boolean'Pos(C);
		
		if T >= 2**data_width then
			R := T - 2**data_width;
			C := TRUE;
		else
			R := T;
			C := FALSE;
		end if;

		if T mod 2**data_width = 0 then
			Z := TRUE;
		else
			Z := FALSE;
		end if;

		if T_s < 0 then
			N := TRUE;
		else
			N := FALSE;
		end if;

		if (T_s < -2**(data_width - 1)) or (T_s >= 2**(data_width - 1)) then
			O := TRUE;
		else
			O := FALSE;
		end if;
	end EXEC_ADDC;	

end cpu_subprogram_pack_orestis;
