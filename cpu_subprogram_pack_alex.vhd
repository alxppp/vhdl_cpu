package cpu_subprogram_pack_alex is

use WORK.cpu_defs_pack.all;
use WORK.bit_vector_natural_pack.all;
use WORK.casts_pack.all;

	procedure EXEC_SLL(constant A : in data_type; variable B : out data_type; variable Z, C, N, O : out Boolean);

end cpu_subprogram_pack_alex;

package body cpu_subprogram_pack_alex is

	procedure EXEC_SLL(constant A : in data_type; variable B : out data_type; variable Z, C, N, O : out Boolean) is
		variable T : bit_vector(data_width - 1 downto 0);
		variable T_b : bit;
		variable R : data_type;

	begin
		T := natural2bit_vector(A, data_width);
		T_b := T(T'left);
		T := T(T'left - 1 downto 0) & '0';

		R := bit_vector2natural(T);

		C := bit2boolean(T_b);

		B := R;

	end EXEC_SLL;

end cpu_subprogram_pack_alex;
