package cpu_subprogram_pack_orestis is

	use WORK.cpu_defs_pack.all;
	use WORK.bit_vector_natural_pack.all;

	function INC(constant PC :in addr_type) return addr_type;

	-- ADDC implementation appropriate both for ADD and ADDC instructons. See Skript 152-153.
	procedure EXEC_ADDC ( constant A,B	: in data_type;
			      variable R	: out data_type;
			      variable Z	: out Boolean;
			      variable C	: inout Boolean;
			      variable N,O	: out Boolean );
	
	--REA: Use AND operator on all bits of Y and assign the result to the LSb of X. All other bits of X are cleared.
	procedure EXEC_REA ( variable A		: out data_type;
			     constant B		: in data_type;
			     variable Z,C,N,O	: out Boolean );

	--REO: Use OR operator on all bits of Y and assign the result to the LSb of X. All other bits of X are cleared.
	procedure EXEC_REO ( variable A		: out data_type;
			     constant B		: in data_type;
			     variable Z,C,N,O	: out Boolean );	

	--REA: Use XOR operator on all bits of Y and assign the result to the LSb of X. All other bits of X are cleared.
	procedure EXEC_REX ( variable A		: out data_type;
			     constant B		: in data_type;
			     variable Z,C,N,O	: out Boolean );

end cpu_subprogram_pack_orestis;





package body cpu_subprogram_pack_orestis is

	function INC(constant PC :in addr_type) return addr_type is
	begin
		return (PC + 1) mod (2**addr_width);
	end INC;



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



	procedure EXEC_REA (variable A		: out data_type;
			    constant B		: in data_type;
			    variable Z,C,N,O	: out Boolean ) is
	begin
		if B = 2**data_width - 1 then --result is 1 iff all bits of Y are 1
			A := 1;
			Z := FALSE;
		else
			A := 0;
			Z := TRUE;
		end if;
		C := FALSE;
		N := FALSE;
		O := FALSE;
	end EXEC_REA;



	procedure EXEC_REO (variable A		: out data_type;
			    constant B		: in data_type;
			    variable Z,C,N,O	: out Boolean ) is
	begin
		if B > 0 then --result is 1 if at least one bit in Y is 1
			A := 1;
			Z := FALSE;
		else
			A := 0;
			Z := TRUE;
		end if;
		C := FALSE;
		N := FALSE;
		O := FALSE;
	end EXEC_REO;



	procedure EXEC_REX (variable A		: out data_type;
			    constant B		: in data_type;
			    variable Z,C,N,O	: out Boolean ) is
		variable B_bv	: bit_vector(data_width-1 downto 0) := natural2bit_vector(B, data_width);
		variable result	: bit := B_bv(data_width-1) ;
	begin
		for i in data_width-2 downto 0 loop
			result := result XOR B_bv(i);
		end loop;
		if  result = '1' then 
			A := 1;
			Z := FALSE;
		else
			A := 0;
			Z := TRUE;
		end if;
		C := FALSE;
		N := FALSE;
		O := FALSE;
	end EXEC_REX;





end cpu_subprogram_pack_orestis;
