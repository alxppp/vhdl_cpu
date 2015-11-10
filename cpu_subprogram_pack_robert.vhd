package cpu_subprogram_pack_robert is


--use WORK.cpu_subprogram_pack_orestis.EXEC_ADDC;
use WORK.cpu_defs_pack.all;
use WORK.bit_vector_natural_pack.all;

function "NOT" (constant A : data_type)
	return data_type;

function "AND" (constant A, B : data_type)
	return data_type;

function "OR" (constant A, B : data_type)
	return data_type;

function "XOR" (constant A, B : data_type)
	return data_type;

procedure Set_Flags_Logic(constant Data : in data_type;
                          variable Zero, Carry, Negative, Overflow : out boolean);

procedure Set_Flags_Load(constant Data : in data_type;
                         variable Zero, Carry, Negative, Overflow : out boolean);

procedure EXEC_SUBC ( constant A,B	: in data_type;
                      variable R	: out data_type; --Result
                      variable Z	: out Boolean; --Zero Flag
                      variable C	: inout Boolean; --Carry Flag [inout]
                      variable N,O	: out Boolean ); --Negative, Overflow Flag

end cpu_subprogram_pack_robert;

package body cpu_subprogram_pack_robert is

function "NOT" (constant A : data_type)
	return data_type is
begin
return WORK.bit_vector_natural_pack.bit_vector2natural(
        NOT WORK.bit_vector_natural_pack.natural2bit_vector( A, data_width ) );
end "NOT";

function "AND" (constant A, B: data_type)
	return data_type is
begin
return WORK.bit_vector_natural_pack.bit_vector2natural(
        WORK.bit_vector_natural_pack.natural2bit_vector(A, data_width) AND 
        WORK.bit_vector_natural_pack.natural2bit_vector(B, data_width) );
end "AND";

function "OR" (constant A, B: data_type)
	return data_type is
begin
return WORK.bit_vector_natural_pack.bit_vector2natural(
        WORK.bit_vector_natural_pack.natural2bit_vector(A, data_width) OR
        WORK.bit_vector_natural_pack.natural2bit_vector(B, data_width) );
end "OR";

function "XOR" ( constant A, B: data_type)
	return data_type is 
begin
return WORK.bit_vector_natural_pack.bit_vector2natural(
        WORK.bit_vector_natural_pack.natural2bit_vector(A, data_width) XOR
        WORK.bit_vector_natural_pack.natural2bit_vector(B, data_width) );
end "XOR";

--The Set_Flags_Logic procedure updates the Flags and should be called after
--processing every of the following instructions: NOT, AND, OR, XOR, 
--                                                (REA, REO, REX, ROL, ROR)
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
	Overflow := false;
end Set_Flags_Logic;

--The Set_Flags_Load procedure updates the Flags and should be called after
--processing every of the following instructions: LDC, LDD, LDR
procedure Set_Flags_Load( constant Data : in data_type;
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
	--is not affected. (Spec 3.2.5.6.)

	--Negative Flag
	--The most significant bit of Data is assigned to the negative flag. (Spec 3.2.6.2.)
	Negative := boolean'val(Data / 2**(data_width-1));
	
	--Overflow Flag
	--The overflow flag is cleared, when executing load instructions. (Spec 3.2.7.3.)
	Overflow := false;

end Set_Flags_Load;

--Alternative implementation using only EXEC_ADDC:
--procedure EXEC_SUBC ( constant A,B	: in data_type;
--                      variable R	: out data_type; --Result
--                      variable Z	: out Boolean; --Zero Flag
--                      variable C	: inout Boolean; --Carry Flag [inout]
--                      variable N,O	: out Boolean ) is --Negative, Overflow Flag
--variable C_inv : Boolean := not C;
--variable R_a : data_type;
--variable Z_a, N_a, O_a : Boolean;
--begin
--	EXEC_ADDC(A, not B, R_a, Z_a, C_inv, N_a, O_a );
--	Z := Z_a;
--	C := C_inv;
--	R := R_a;
--	N := N_a;
--	O := O_a;
--end EXEC_SUBC;

procedure EXEC_SUBC ( constant A,B	: in data_type;
                      variable R	: out data_type; --Result
                      variable Z	: out Boolean; --Zero Flag
                      variable C	: inout Boolean; --Carry Flag [inout]
                      variable N,O	: out Boolean ) is --Negative, Overflow Flag
variable T : integer;
variable B_C : integer := (2**(data_width) - B) mod (2**data_width); --Two's complement of B
variable C_C : integer := (2**(data_width) - boolean'pos(C)) mod (2**data_width); --Two's complement of Carry
variable A_s, B_s, T_s : integer;
begin
	--two's complement calculation
	T := A + B_C + C_C;

	--prepare signed calculation
	if A >= 2**(data_width-1) then
		A_s := A-2**(data_width); --A negative
	else
		A_s := A;
	end if;

	if B >= 2**(data_width-1) then
		B_s := B-2**(data_width); --B negative
	else
		B_s := B;
	end if;
	
	--signed calculation
	T_s := A_s - B_s - boolean'pos(C);

	--compute result and Carry-Flag
	if T >= 2**data_width then --check carry
		T := T mod (2**data_width);
		C := TRUE;
	else
		C := FALSE;
	end if;
	R := T; 

	--check Zero-Flag
	if T = 0 then
		Z := TRUE;
	else
		Z := FALSE;
	end if;

	--check Negative-Flag
	if T_s < 0 then
		N := TRUE;
	else
		N := FALSE;
	end if;

	--check Overflow-Flag
	if (T_s < -2**(data_width-1)) or (T_s >= 2**(data_width-1)) then
		O := TRUE; --signed value out of range --> Overflow
	else
		O := FALSE;
	end if;

end EXEC_SUBC;

end cpu_subprogram_pack_robert;