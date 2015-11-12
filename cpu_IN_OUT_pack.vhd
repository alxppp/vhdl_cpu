package cpu_IN_OUT_pack is

	use STD.textio.all;
	use WORK.cpu_defs_pack.all;
	use WORK.cpu_textio_pack.all;

	-- IN uses the txt 'InDevice' (defined in cpu_defs_pack) file as an Input Port, reads the first number (integer format)
	-- written on the first (or next, for consequtive calls) line and saves it on the Register defined by parameter D.
	procedure EXEC_IN ( variable D : out data_type;
			    variable InDevice :in text );

	-- OUT uses the txt 'OutDevice' (defined in cpu_defs_pack) file as an Output Port, 
	-- and writes on it the value of the Register defined by parameter S.
	procedure EXEC_OUT ( variable S : in data_type;
			     variable OutDevice : out text  );


end cpu_IN_OUT_pack;





package body cpu_IN_OUT_pack is

	procedure EXEC_IN ( variable D : out data_type;
			    variable InDevice : in text ) is
		variable l 	: line;
		variable v 	: data_type;
		variable success: boolean;
	begin
		if not endfile(InDevice) then
			readline(InDevice, l);
			WORK.cpu_textio_pack.read(l, v, success);
			if success then
				D := v;
			else 
				assert FALSE report "Wrong value at Input Port" severity error;
			end if;
		end if;
	end EXEC_IN;



	procedure EXEC_OUT ( variable S : in data_type;
			     variable OutDevice : out text ) is
		variable l : line;
		variable S_hex : string ( 1 to 3);
	begin
		S_hex := hex_image(S);
		write (l, S_hex);
		writeline(OutDevice, l);
	end EXEC_OUT;

end cpu_IN_OUT_pack;
