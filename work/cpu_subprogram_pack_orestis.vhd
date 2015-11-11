package cpu_subprogram_pack_orestis is

	use WORK.cpu_defs_pack.all;
	use WORK.bit_vector_natural_pack.all;
	use STD.textio.all;

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

	-- IN uses the txt 'InDevice' (defined in cpu_defs_pack) file as an Input Port, reads the first number (integer format)
	-- written on the first (or next, for consequtive calls) line and saves it on the Register defined by parameter D.
	procedure EXEC_IN ( variable D : out data_type;
			    variable InDevice :in text );

	-- OUT uses the txt 'OutDevice' (defined in cpu_defs_pack) file as an Output Port, 
	-- and writes on it the value of the Register defined by parameter S.
	procedure EXEC_OUT ( variable S : in data_type;
			     variable OutDevice : out text  );

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
		variable result : natural;
	begin
		if B = 2**data_width - 1 then --result is 1 iff all bits of Y are 1
			result := 1;
		else
			result := 0;
		end if;
		A := result;
		WORK.cpu_subprogram_pack_robert.set_flags_logic(result, Z, C, N, O);
	end EXEC_REA;



	procedure EXEC_REO (variable A		: out data_type;
			    constant B		: in data_type;
			    variable Z,C,N,O	: out Boolean ) is
		variable result	: natural;
	begin
		if B > 0 then --result is 1 if at least one bit in Y is 1
			result := 1;
		else
			result := 0;
		end if;
		A := result;
		WORK.cpu_subprogram_pack_robert.set_flags_logic(result, Z, C, N, O);
	end EXEC_REO;



	procedure EXEC_REX (variable A		: out data_type;
			    constant B		: in data_type;
			    variable Z,C,N,O	: out Boolean ) is
		variable B_bv		: bit_vector(data_width-1 downto 0) := natural2bit_vector(B, data_width);
		variable total_xor	: bit := B_bv(data_width-1);
		variable result		: natural;
	begin
		for i in data_width-2 downto 0 loop
			total_xor := total_xor XOR B_bv(i);
		end loop;
		if  total_xor = '1' then 
			result := 1;
		else
			result := 0;
		end if;
		A := result;
		WORK.cpu_subprogram_pack_robert.set_flags_logic(result, Z, C, N, O);
	end EXEC_REX;

	
	
	procedure EXEC_IN ( variable D : out data_type;
			    variable InDevice : in text ) is
		variable l 	: line;
		variable v 	: data_type;
		variable success: boolean;
	begin
		if not endfile(InDevice) then
			readline(InDevice, l);
			read (l, v, success);
			if success then
				D := v;
			else 
				assert FALSE report "Wrong value at Input Port" severity error;
			end if;
		end if;
	end EXEC_IN;



	procedure EXEC_OUT ( variable S : in data_type;
			     variable OutDevice : out text ) is
		variable l : line;
	begin
		write (l, S);
		writeline(OutDevice, l);
	end EXEC_OUT;

	

end cpu_subprogram_pack_orestis;
