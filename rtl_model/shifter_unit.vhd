use WORK.cpu_defs_pack.all;
use WORK.cpu_subprogram_pack.all;

entity SHIFTER_UNIT is
    port(A, B      : in  bit_vector(11 downto 0);
         OP        : in  bit_vector(5 downto 0);
         CIN       : in  bit;
         RESULT    : out bit_vector(11 downto 0);
         FLAGS_OUT : out bit_vector(2 downto 0)); -- C, N, O
end SHIFTER_UNIT;

architecture RTL of SHIFTER_UNIT is

begin

    process(A, B, OP, CIN)

        variable res : bit_vector(11 downto 0);

    begin

    case OP is
        -- Shift Y left by one bit and assign the result to X (3.1.2.4.)
        when code_sll =>
            res := A(10 downto 0) & '0';

            FLAGS_OUT(2) <= A(11); -- Carry
            FLAGS_OUT(0) <= res(11) xor A(11); -- Overflow

        -- Shift Y right by one bit (not conserving sign bit) and assign the result to X (3.1.2.4.)
        when code_srl =>
            res := '0' & A(11 downto 1);

            FLAGS_OUT(2) <= A(0); -- Carry
            FLAGS_OUT(0) <= '0'; -- Overflow

        -- Shift Y right by one bit (conserving sign bit) and assign the result to X (3.1.2.4.)
        when code_sra =>
            res := A(11) & A(11 downto 1);

            FLAGS_OUT(2) <= A(0); -- Carry
            FLAGS_OUT(0) <= '0'; -- Overflow

        -- Rotate Y left by one bit and assign the result to X (3.3.1.17)
        when code_rol =>
            res := A(10 downto 0) & A(11);

            FLAGS_OUT(2) <= '0'; -- Carry
            FLAGS_OUT(0) <= '0'; -- Overflow

        -- Rotate Y right by one bit and assign the result to X (3.3.1.19)
        when code_ror =>
            res := A(0) & A(11 downto 1);

            FLAGS_OUT(2) <= '0'; -- Carry
            FLAGS_OUT(0) <= '0'; -- Overflow

        -- Rotate Y left by one bit through Carry and assign the result to X (3.3.1.18)
        when code_rolc =>
            res := A(10 downto 0) & CIN;

            FLAGS_OUT(2) <= A(11); -- Carry
            FLAGS_OUT(0) <= '0'; -- Overflow

        -- Rotate Y right by one bit through Carry and assign the result to X (3.3.1.20)
        when code_rorc =>
            res := CIN & A(11 downto 1);

            FLAGS_OUT(2) <= A(0); -- Carry
            FLAGS_OUT(0) <= '0'; -- Overflow

        when others =>
            res := (others => '0');

            FLAGS_OUT(2) <= '0'; -- Carry
            FLAGS_OUT(0) <= '0'; -- Overflow
    end case;

    FLAGS_OUT(1) <= res(11); -- Negative

    RESULT <= res;

    end process;

end RTL;

configuration SHIFTER_UNIT_CONFIG of SHIFTER_UNIT is
    for RTL
    end for;
end SHIFTER_UNIT_CONFIG;
