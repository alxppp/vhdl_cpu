package cpu_memory_pack is
use STD.textio.all;
use WORK.cpu_defs_pack.all;

procedure init_memory(
	variable MemoryFile : in text;
	variable Memory : out mem_type );

end package cpu_memory_pack;

package body cpu_memory_pack is

procedure init_memory(
	variable MemoryFile : in text;
	variable Memory : out mem_type
	) is
variable l : line;
variable success : boolean;
variable v : data_type;
variable i : addr_type := 0;

begin
	outest: loop
		exit when endfile(MemoryFile);
		readline (MemoryFile, l);
--		while success loop
		WORK.cpu_textio_pack.read (l, v, success);
		if success then
			Memory (i) := v;
			exit outest when
				i = 2**addr_width-1;
			i := i+1;
		else
			assert FALSE
				report "Reading memory failed line "&addr_type'image(i)
				severity FAILURE;
		end if;
--		end loop;
	end loop;
end init_memory;


end cpu_memory_pack;

