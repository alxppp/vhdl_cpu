package cpu_logic_pack is

	use WORK.cpu_defs_pack.all;
	use WORK.bit_vector_natural_pack.all;

	function "NOT" (constant A : data_type) --Robert 
		return data_type;

	function "AND" (constant A, B : data_type) --Robert
		return data_type;

	function "OR" (constant A, B : data_type) --Robert
		return data_type;

	function "XOR" (constant A, B : data_type) --Robert
		return data_type;

	--REA: Use AND operator on all bits of Y and assign the result to the LSb of X. All other bits of X are cleared.
	procedure EXEC_REA ( variable A		: out data_type; --Orestis
			     constant B		: in data_type );

	--REO: Use OR operator on all bits of Y and assign the result to the LSb of X. All other bits of X are cleared.
	procedure EXEC_REO ( variable A		: out data_type; --Orestis
			     constant B		: in data_type );	

	--REA: Use XOR operator on all bits of Y and assign the result to the LSb of X. All other bits of X are cleared.
	procedure EXEC_REX ( variable A		: out data_type; --Orestis
			     constant B		: in data_type );

end cpu_logic_pack;



package body cpu_logic_pack is

	function "NOT" (constant A : data_type)
		return data_type is
	begin
		return  WORK.bit_vector_natural_pack.bit_vector2natural(
		        NOT WORK.bit_vector_natural_pack.natural2bit_vector( A, data_width ) );
	end "NOT";

	function "AND" (constant A, B: data_type)
		return data_type is
	begin
		return  WORK.bit_vector_natural_pack.bit_vector2natural(
		        WORK.bit_vector_natural_pack.natural2bit_vector(A, data_width) AND 
		        WORK.bit_vector_natural_pack.natural2bit_vector(B, data_width) );
	end "AND";

	function "OR" (constant A, B: data_type)
		return data_type is
	begin
		return  WORK.bit_vector_natural_pack.bit_vector2natural(
		        WORK.bit_vector_natural_pack.natural2bit_vector(A, data_width) OR
		        WORK.bit_vector_natural_pack.natural2bit_vector(B, data_width) );
	end "OR";

	function "XOR" ( constant A, B: data_type)
		return data_type is 
	begin
		return  WORK.bit_vector_natural_pack.bit_vector2natural(
		        WORK.bit_vector_natural_pack.natural2bit_vector(A, data_width) XOR
		        WORK.bit_vector_natural_pack.natural2bit_vector(B, data_width) );
	end "XOR";

	procedure EXEC_REA (variable A		: out data_type;
			    constant B		: in data_type ) is
		variable result : natural;
	begin
		if B = 2**data_width - 1 then --result is 1 iff all bits of Y are 1
			result := 1;
		else
			result := 0;
		end if;
		A := result;
	end EXEC_REA;



	procedure EXEC_REO (variable A		: out data_type;
			    constant B		: in data_type ) is
		variable result	: natural;
	begin
		if B > 0 then --result is 1 if at least one bit in Y is 1
			result := 1;
		else
			result := 0;
		end if;
		A := result;
	end EXEC_REO;



	procedure EXEC_REX (variable A		: out data_type;
			    constant B		: in data_type) is
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
	end EXEC_REX;

end cpu_logic_pack;
