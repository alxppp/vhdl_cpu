package mem_defs_pack is --Max

use WORK.cpu_defs_pack.all;

constant memory_content : mem_type;

end mem_defs_pack;



package body mem_defs_pack is


constant memory_content : mem_type :=
			(	0	=> code_nop * 2**(reg_addr_width),
				1	=> code_stop * 2**(reg_addr_width),
				others	=>	0 );


end mem_defs_pack;
