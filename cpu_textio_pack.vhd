package cpu_textio_pack is

	use STD.textio.all;
	use WORK.cpu_defs_pack.all;



	function hex_image(d : data_type) return string;
	function bool_character(b : Boolean) return character;
	

	procedure read(variable l : in line; variable v : out data_type; success : out boolean );
	procedure asciihex2int(constant c : in character; variable d : out integer; variable success : out boolean);


end cpu_textio_pack;

package body cpu_textio_pack is

	function hex_image(d : data_type) return string is

	constant hex_table : string (1 to 16) := "0123456789ABCDEF";
	variable result : string ( 1 to 3);

	begin

		result(3) := hex_table(d mod 16 + 1);
		result(2) := hex_table((d / 16) mod 16 + 1);
		result(1) := hex_table((d / 256) mod 16 + 1);

		return result;
	
	end hex_image;

	function bool_character(b : Boolean) return character is

	begin

		if b then return 'T';
		else return 'F';
		end if;

	end bool_character;

	procedure read(variable l : in line; variable v : out data_type; variable success : out boolean) is

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
			--asciihex2int(l(I+1), x(I), success_t);
			asciihex2int(l(I+1), x, success_t);		
			if not success_t then
				success := success_t;
				return;
			end if;
			
			v_t := v_t + x * (2**4)**(char_count-1-I);
		end loop;
		
		v := v_t;
		success := TRUE;
	end read;


	procedure asciihex2int(constant c : in character; variable d : out integer; variable success : out boolean) is

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
	end asciihex2int;
	
end cpu_textio_pack;
