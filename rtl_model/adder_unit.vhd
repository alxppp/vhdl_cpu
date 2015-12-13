use WORK.cpu_defs_pack.all;
use WORK.cpu_subprogram_pack.all;

entity ADDER_UNIT is
    port(A, B : in bit_vector(11 downto 0);
         CIN : in bit;
         OP : in bit_vector(5 downto 0);
         RESULT : out bit_vector(11 downto 0);
         FLAGS_OUT : out bit_vector(2 downto 0)); --C, N, O
end ADDER_UNIT;

architecture RTL of ADDER_UNIT is
signal B_tmp : bit_vector(11 downto 0);
signal CIN_tmp : bit;
signal RES_tmp : bit_vector(11 downto 0);
signal COUT10_tmp : bit;
signal HA11_1_COUT_tmp : bit;
signal HA11_1_Z_tmp : bit;
signal HA11_2_COUT_tmp : bit;
signal COUT_tmp : bit;
--signal HA11_1_Z_tmp : bit;
signal SUB_tmp : bit_vector(11 downto 0);
begin
    --prepare calculation
    SUB_TMP <=  (0 => '1', others => '0') when ((OP=code_sub) or (OP=code_subc))
                 else (others => '0');
    CIN_tmp <=  CIN xor SUB_tmp(0) when OP=code_addc or OP=code_subc
                else '0';
    B_tmp <= B xor SUB_tmp;
    
    --summation for the first 11 bits            
    RCA : entity work.RIPPLECARRYADDER(GENERIC_RTL)
          generic map(11)
          port map(A(10 downto 0), B_tmp(10 downto 0), CIN_tmp, RES_tmp(10 downto 0), COUT10_tmp);
    
    --summation of the MSB and flag computation            
    HA11_1 : entity work.HALFADDER(RTL)
             port map(A(11), B_tmp(11), HA11_1_Z_tmp, HA11_1_COUT_tmp);
    HA11_2 : entity work.HALFADDER(RTL)
             port map(HA11_1_Z_tmp, COUT10_tmp, RES_tmp(11), HA11_2_COUT_tmp);
    RESULT <= RES_tmp;
             
    COUT_tmp <= HA11_1_COUT_tmp xor HA11_2_COUT_tmp;     
    FLAGS_OUT(2) <= COUT_tmp; --Carry flag    
    FLAGS_OUT(1) <= HA11_1_Z_tmp xor COUT_tmp; --Negative flag    
    FLAGS_OUT(0) <= COUT_tmp xor COUT10_tmp; --Overflow flag

end RTL;
