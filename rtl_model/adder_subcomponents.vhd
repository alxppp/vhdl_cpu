entity HALFADDER is
    port(X, Y : in bit;
         Z, C_OUT : out bit);
end HALFADDER;

architecture RTL of HALFADDER is
begin
    Z <= X xor Y;
    C_OUT <= X and Y;
end RTL;

entity FULLADDER is
    port(X, Y, C_IN : in bit;
         Z, C_OUT : out bit);
end FULLADDER;

architecture HF_RTL of FULLADDER is
signal Z1, C1, C2 : bit;
begin
HF1 : entity work.HALFADDER(RTL)
      port map(X, Y, Z1, C1);
HF2 : entity work.HALFADDER(RTL)
      port map(Z1, C_IN, Z, C2);
C_OUT <= C1 xor C2;
end HF_RTL;

architecture RTL of FULLADDER is
begin
Z <= X xor Y xor C_IN;
C_OUT <= (X and Y) or ( C_IN and (X or Y) );
end RTL;

entity RippleCarryAdder is
    generic(N : natural);
    port(X, Y : in bit_vector(N-1 downto 0);
         C_IN : in bit;
         Z : out bit_vector(N-1 downto 0);
         C_OUT : out bit);
end RippleCarryAdder;

architecture GENERIC_RTL of RippleCarryAdder is
signal C_tmp : bit_vector(N downto 0);

begin
C_tmp(0) <= C_IN;
C_OUT <= C_tmp(N);
g: for i in 0 to N-1 generate
    FA : entity work.FULLADDER(RTL)
         port map(X(i), Y(i), C_tmp(i), Z(i), C_tmp(i+1));
end generate;

end GENERIC_RTL;