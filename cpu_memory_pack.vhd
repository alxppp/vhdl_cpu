package cpu_memory_pack is
use STD.textio.all;
use WORK.cpu_defs_pack.all;
use WORK.mem_defs_pack.all;

procedure init_memory(
	variable MemoryFile : in text;
	variable Memory : out mem_type );

procedure read(
	variable l : in line;
	variable v : out data_type;
	success : out boolean );

procedure hex2int(
	constant c : in character;	
	variable d : out integer;
	variable success : out boolean);

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
		read (l, v, success);
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

procedure read(
	variable l : in line;
	variable v : out data_type;
	variable success : out boolean 
	) is
constant char_count : natural := data_width/4;
variable success_t : boolean;
--type hex_type is range 0 to 15;
--type tmp_array is array(integer range 0 to char_count-1) of integer;
--variable x : tmp_array;	
variable x : integer;
variable v_t : data_type := 0;
begin
	if l'RIGHT /= char_count then
		success := FALSE;
		assert FALSE
			report "Line does not contain "&natural'image(char_count)&" characters!"
			severity ERROR;
		return;
	end if;	
	outest: for I in 0 to (char_count-1) loop
		--hex2int(l(I+1), x(I), success_t);
		hex2int(l(I+1), x, success_t);		
		if not success_t then
			success := success_t;
			return;
		end if;
		
		v_t := v_t + x * (2**4)**(char_count-1-I);
	end loop;
	
	v := v_t;
	success := TRUE;
end read;

procedure hex2int(
	constant c : in character;	
	variable d : out integer;
	variable success : out boolean) is
constant i : integer := character'pos(c);
variable tmp : integer := -1;
begin
	if i >= 97 then
		tmp := i - 87;
	elsif i >= 65 then
		tmp := i - 55;
	elsif i >= 48 then
		tmp := i - 48;
--	else
--		tmp := -1;
--		success := FALSE;
--		assert FALSE
--			report "not a hexadecimal character!"
--			severity ERROR;
	end if;

	if tmp<0 or tmp > 15 then
		assert FALSE
			report character'image(c)&" is not a hexadecimal character!"
			severity ERROR;
		success := FALSE;
	else
		d := tmp;
		success := TRUE;
	end if;
end hex2int;

end cpu_memory_pack;

