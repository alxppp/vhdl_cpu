entity tb_robert_exec_subc is
end tb_robert_exec_subc;

architecture BEHAVIOUR of tb_robert_exec_subc is
use work.cpu_defs_pack.all;
use work.cpu_subprogram_pack_robert.EXEC_SUBC;

signal START : bit := '0';

begin
START <= '1';

process (START)
variable r, x, y : data_type;
variable Z, N, C, O : boolean;
variable r_exp : data_type;
variable Z_exp, N_exp, C_exp, O_exp : boolean;
begin
	report "Basic Testbench of EXEC_SUBC started." severity NOTE;

	--Test#1 (test zero-flag) -1 - (-1) = 0
	x := 2**data_width-1;
	y := 2**data_width-1;
	C := FALSE;
	r_exp := 0;
	Z_exp := TRUE; N_exp := FALSE; C_exp := TRUE; O_exp := FALSE;
	EXEC_SUBC(x,y,r, Z, C, N, O);
	
	assert (r=r_exp) and (Z=Z_exp) and (N=N_exp) and (C=C_exp) and (O=O_exp)
		report "Unexpected result in Test-Case #1" severity ERROR;
	
	--Test#2 (test carry-flag)
	x := 2**data_width-1;
	y := 1;
	C := FALSE;
	r_exp := 2**data_width -2; -- -1 -1 = -2
	Z_exp := FALSE; N_exp := TRUE; C_exp := TRUE; O_exp := FALSE;
	EXEC_SUBC(x,y,r, Z, C, N, O);
	
	assert (r=r_exp) and (Z=Z_exp) and (N=N_exp) and (C=C_exp) and (O=O_exp)
		report "Unexpected result in Test-Case #2" severity ERROR;

	
	--Test#3 (test overflow) -2^(n-1) - (2^(n-1)-1) -1 = -2^n
	x := (2**data_width - 2**(data_width-1)) mod 2**data_width; --minimum value
	y := 2**(data_width-1)-1; --maximum value
	C := TRUE;
	r_exp := 0; -- -2^n mod 2^n = 0
	Z_exp := TRUE; N_exp := TRUE; C_exp := TRUE; O_exp := TRUE;
	EXEC_SUBC(x,y,r, Z, C, N, O);
	
	assert (r=r_exp) and (Z=Z_exp) and (N=N_exp) and (C=C_exp) and (O=O_exp)
		report "Unexpected result in Test-Case #3" severity ERROR;

	report "Testbench of EXEC_SUBC finished." severity NOTE;

end process;

end BEHAVIOUR;
