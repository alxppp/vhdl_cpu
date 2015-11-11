package cpu_subprogram_pack_alex is

	use WORK.cpu_defs_pack.all;
	use WORK.bit_vector_natural_pack.all;

	procedure EXEC_SLL(constant A : in data_type; variable B : out data_type; variable Z, C, N, O : out Boolean);
	procedure EXEC_SRL(constant A : in data_type; variable B : out data_type; variable Z, C, N, O : out Boolean);
	procedure EXEC_SRA(constant A : in data_type; variable B : out data_type; variable Z, C, N, O : out Boolean);

end cpu_subprogram_pack_alex;

package body cpu_subprogram_pack_alex is

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

		B := R;

	end EXEC_SLL;

	-- Shift Y right by one bit (not conserving sign bit) and assign the result to X (3.1.2.4.)
	procedure EXEC_SRL(constant A : in data_type; variable B : out data_type; variable Z, C, N, O : out Boolean) is
		variable T : bit_vector(data_width - 1 downto 0);
		variable R : data_type;

	begin
		C := Boolean'val(Bit'pos(T(T'right)));
		T := '0' & T(T'left downto 1);
		R := bit_vector2natural(T);
		B := R;

	end EXEC_SRL;

	-- Shift Y right by one bit (conserving sign bit) and assign the result to X (3.1.2.4.)
	procedure EXEC_SRA(constant A : in data_type; variable B : out data_type; variable Z, C, N, O : out Boolean) is
		variable T : bit_vector(data_width - 1 downto 0);
		variable R : data_type;

	begin
		C := Boolean'val(Bit'pos(T(T'right)));
		T := T(T'right) & T(T'left downto 1);
		R := bit_vector2natural(T);
		B := R;

	end EXEC_SRA;

end cpu_subprogram_pack_alex;
