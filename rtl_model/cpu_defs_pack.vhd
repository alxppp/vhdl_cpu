package cpu_defs_pack is

subtype opcode_type is bit_vector(5 downto 0);

constant code_nop 	: opcode_type := B"000000";
constant code_stop	: opcode_type := B"000001";
constant code_add	: opcode_type := B"000010";
constant code_addc 	: opcode_type := B"000011";
constant code_sub 	: opcode_type := B"000100";
constant code_subc 	: opcode_type := B"000101";
constant code_not 	: opcode_type := B"000110";
constant code_and 	: opcode_type := B"000111";
constant code_or 	: opcode_type := B"001000";
constant code_xor 	: opcode_type := B"001001";
constant code_rea 	: opcode_type := B"001010";
constant code_reo 	: opcode_type := B"001011";
constant code_rex 	: opcode_type := B"001100";
constant code_sll 	: opcode_type := B"001101";
constant code_srl 	: opcode_type := B"001110";
constant code_sra 	: opcode_type := B"001111";
constant code_rol 	: opcode_type := B"010000";
constant code_rolc 	: opcode_type := B"010001";
constant code_ror 	: opcode_type := B"010010";
constant code_rorc 	: opcode_type := B"010011";
constant code_ldc	: opcode_type := B"100000";
constant code_ldd	: opcode_type := B"100001";
constant code_ldr	: opcode_type := B"100010";
constant code_std	: opcode_type := B"100011";
constant code_str	: opcode_type := B"100100";
constant code_in 	: opcode_type := B"100101";
constant code_out 	: opcode_type := B"100110";
constant code_ldpc 	: opcode_type := B"100111";
constant code_stpc 	: opcode_type := B"101000";
constant code_jmp	: opcode_type := B"110000";
constant code_jz	: opcode_type := B"110001";
constant code_jc	: opcode_type := B"110010";
constant code_jn	: opcode_type := B"110011";
constant code_jo	: opcode_type := B"110100";
constant code_jnz	: opcode_type := B"110101";
constant code_jnc	: opcode_type := B"110110";
constant code_jnn	: opcode_type := B"110111";
constant code_jno	: opcode_type := B"111000";

--Definitions for Simulation

subtype data_type is integer range 0 to 4095;
constant data_width : positive := 12;

--Definitions for Memory
--type RAM is array(bit, bit, bit, bit, bit, bit, bit, bit, bit, bit, bit, bit) of bit_vector(11 downto 0);
type RAM is array(0 to 4095) of bit_vector(11 downto 0);
end cpu_defs_pack;