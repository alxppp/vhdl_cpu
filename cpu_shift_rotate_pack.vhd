package cpu_shift_rotate_pack is

	use WORK.cpu_defs_pack.all;
	use WORK.bit_vector_natural_pack.all;

	procedure EXEC_SLL(constant A : in data_type; variable B : out data_type; variable Z, C, N, O : out Boolean);
	procedure EXEC_SRL(constant A : in data_type; variable B : out data_type; variable Z, C, N, O : out Boolean);
	procedure EXEC_SRA(constant A : in data_type; variable B : out data_type; variable Z, C, N, O : out Boolean);
	procedure EXEC_ROL(constant A : in data_type; variable B : out data_type; variable Z,C,N,O : out Boolean);
	procedure EXEC_ROR(constant A : in data_type; variable B : out data_type; variable Z,C,N,O : out Boolean);
	procedure EXEC_ROLC(constant A : in data_type; variable B : out data_type; variable Z : out boolean; constant CI : in Boolean; variable CO,N,O : out Boolean);
	procedure EXEC_RORC(constant A : in data_type; variable B : out data_type; variable Z : out boolean; constant CI : in Boolean; variable CO,N,O : out Boolean);

end cpu_shift_rotate_pack;



package body cpu_shift_rotate_pack is

	-- Shift Y left by one bit and assign the result to X (3.1.2.4.)
	procedure EXEC_SLL(constant A : in data_type; variable B : out data_type; variable Z, C, N, O : out Boolean) is
		variable T : bit_vector(data_width - 1 downto 0);
		variable T_b : bit;
		variable R : data_type;

	begin
		T := natural2bit_vector(A, data_width);
		T_b := T(T'left);
		T := T(T'left - 1 downto 0) & '0';

		R := bit_vector2natural(T);

		C := Boolean'val(Bit'pos(T_b));

		if R = 0 then Z := TRUE;
		else Z := FALSE;
		end if;

		O := T_b /= T(T'left);

		B := R;

	end EXEC_SLL;

	-- Shift Y right by one bit (not conserving sign bit) and assign the result to X (3.1.2.4.)
	procedure EXEC_SRL(constant A : in data_type; variable B : out data_type; variable Z, C, N, O : out Boolean) is
		variable T : bit_vector(data_width - 1 downto 0);
		variable R : data_type;

	begin
		T := natural2bit_vector(A, data_width);

		C := Boolean'val(Bit'pos(T(T'right)));

		T := '0' & T(T'left downto 1);

		R := bit_vector2natural(T);
		if R = 0 then Z := TRUE;
		else Z := FALSE;
		end if;

		B := R;

	end EXEC_SRL;

	-- Shift Y right by one bit (conserving sign bit) and assign the result to X (3.1.2.4.)
	procedure EXEC_SRA(constant A : in data_type; variable B : out data_type; variable Z, C, N, O : out Boolean) is
		variable T : bit_vector(data_width - 1 downto 0);
		variable R : data_type;

	begin
		T := natural2bit_vector(A, data_width);

		C := Boolean'val(Bit'pos(T(T'right)));

		T := T(T'left) & T(T'left downto 1);

		R := bit_vector2natural(T);
		if R = 0 then Z := TRUE;
		else Z := FALSE;
		end if;

		B := R;

	end EXEC_SRA;

	procedure EXEC_ROL(constant A : in data_type; variable B : out data_type; variable Z,C,N,O : out Boolean) is

		variable T : bit_vector(data_width - 1 downto 0);
		variable T_b : bit;
		variable R : data_type;

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

	procedure EXEC_ROR(constant A : in data_type; variable B : out data_type; variable Z,C,N,O : out Boolean) is

		variable T : bit_vector(data_width - 1 downto 0);
		variable T_b : bit;
		variable R : data_type;

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

	procedure EXEC_ROLC(constant A : in data_type; variable B : out data_type; variable Z : out boolean; constant CI : in Boolean; variable CO,N,O : out Boolean) is

		variable T : bit_vector(data_width - 1 downto 0);
		variable R : data_type;

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

	procedure EXEC_RORC(constant A : in data_type; variable B : out data_type; variable Z : out boolean; constant CI : in Boolean; variable CO,N,O : out Boolean) is

		variable T : bit_vector(data_width - 1 downto 0);
		variable R : data_type;

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


end cpu_shift_rotate_pack;
