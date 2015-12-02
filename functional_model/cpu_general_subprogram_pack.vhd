package cpu_general_subprogram_pack is

	use WORK.cpu_defs_pack.all;

	function INC(constant PC :in addr_type) return addr_type; --Orestis

	procedure Set_Flags_Logic(constant Data : in data_type;
	                          variable Zero, Carry, Negative, Overflow : out boolean); --Robert

	procedure Set_Flags_Load(constant Data : in data_type;
	                         variable Zero, Carry, Negative, Overflow : inout boolean); --Robert

end cpu_general_subprogram_pack;


package body cpu_general_subprogram_pack is

	function INC(constant PC :in addr_type) return addr_type is
	begin
		return (PC + 1) mod (2**addr_width);
	end INC;

	procedure Set_Flags_Logic(constant Data : in data_type;
	                          variable Zero, Carry, Negative, Overflow : out boolean) is
	begin
		--Zero Flag
		--If Data equals 0x0, the zero flag is set, otherwise it is cleared. (Spec 3.2.4.1.)
		if Data = 0 then
			Zero := TRUE;
		else
			Zero := FALSE;
		end if;
	
		--Carry Flag
		--Carry Flag is cleared by instructions specified in Spec 3.2.5.1.
		Carry := FALSE;
	
		--Negative Flag
		--The most significant bit of Data is assigned to the negative flag. (Spec 3.2.6.2.)
		Negative := boolean'val(Data / 2**(data_width-1));
	
		--Overflow Flag
		--The overflow flag is cleared, when executing logical instructions. (Spec 3.2.7.3.)
		Overflow := FALSE;
	end Set_Flags_Logic;

	--The Set_Flags_Load procedure updates the Flags and should be called after
	--processing every of the following instructions: LDC, LDD, LDR
	procedure Set_Flags_Load( constant Data : in data_type;
	                          variable Zero, Carry, Negative, Overflow : inout boolean) is
	begin
		--Zero Flag
		--If Data equals 0x0, the zero flag is set, otherwise it is cleared. (Spec 3.2.4.1.)
		if Data = 0 then
			Zero := TRUE;
		else
			Zero := FALSE;
		end if;
	
		--Carry Flag
		--is not affected. (Spec 3.2.5.6.)
	
		--Negative Flag
		--The most significant bit of Data is assigned to the negative flag. (Spec 3.2.6.2.)
		Negative := boolean'val(Data / 2**(data_width-1));
		
		--Overflow Flag
		--The overflow flag is cleared, when executing load instructions. (Spec 3.2.7.3.)
		Overflow := false;
	
	end Set_Flags_Load;
	
end cpu_general_subprogram_pack;
