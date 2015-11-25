package cpu_arithmetic_pack is

	use WORK.cpu_defs_pack.all;

	-- ADDC implementation appropriate both for ADD and ADDC instructons. See Skript 152-153.
	procedure EXEC_ADDC ( constant A,B	: in data_type; --Orestis
			      variable R	: out data_type;
			      variable Z	: out Boolean;
			      variable C	: inout Boolean;
			      variable N,O	: out Boolean );

	procedure EXEC_SUBC ( constant A,B	: in data_type; --Robert
	                      variable R	: out data_type; --Result
	                      variable Z	: out Boolean; --Zero Flag
	                      variable C	: inout Boolean; --Carry Flag [inout]
	                      variable N,O	: out Boolean ); --Negative, Overflow Flag


end cpu_arithmetic_pack;



package body cpu_arithmetic_pack is

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

	procedure EXEC_SUBC ( constant A,B	: in data_type;
	                      variable R	: out data_type; --Result
	                      variable Z	: out Boolean; --Zero Flag
	                      variable C	: inout Boolean; --Carry Flag [inout]
	                      variable N,O	: out Boolean ) is --Negative, Overflow Flag
	variable T : integer;
	variable B_C : integer := (2**(data_width) - B) mod (2**data_width); --Two's complement of B
	variable C_C : integer := (2**(data_width) - boolean'pos(C)) mod (2**data_width); --Two's complement of Carry
	variable A_s, B_s, T_s : integer;
	begin
		--two's complement calculation
		T := A + B_C + C_C;
	
		--prepare signed calculation
		if A >= 2**(data_width-1) then
			A_s := A-2**(data_width); --A negative
		else
			A_s := A;
		end if;

		if B >= 2**(data_width-1) then
			B_s := B-2**(data_width); --B negative
		else
			B_s := B;
		end if;
		
		--signed calculation
		T_s := A_s - B_s - boolean'pos(C);
	
		--compute result and Carry-Flag
		if T >= 2**data_width then --check carry
			T := T mod (2**data_width);
			C := TRUE;
		else
			C := FALSE;
		end if;
		R := T; 
	
		--check Zero-Flag
		if T = 0 then
			Z := TRUE;
		else
			Z := FALSE;
		end if;
	
		--check Negative-Flag
		if T_s < 0 then
			N := TRUE;
		else
			N := FALSE;
		end if;
	
		--check Overflow-Flag
		if (T_s < -2**(data_width-1)) or (T_s >= 2**(data_width-1)) then
			O := TRUE; --signed value out of range --> Overflow
		else
			O := FALSE;
		end if;
	
	end EXEC_SUBC;




end cpu_arithmetic_pack;
