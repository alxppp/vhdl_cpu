package mem_defs_pack is --Max

use WORK.cpu_defs_pack.all;

constant memory_content : mem_type;

end mem_defs_pack;



package body mem_defs_pack is


constant memory_content : mem_type :=
			(	0	=> code_nop * (2**reg_addr_width)**3,
				1	=> code_ldd * (2**reg_addr_width)**3 + 1 * (2**reg_addr_width)**2,
				2	=> 0,
				3	=> code_jmp * (2**reg_addr_width)**3,
				4	=> 10,
				10	=> code_stop * (2**reg_addr_width)**3,
				others	=>	0 );


end mem_defs_pack;
