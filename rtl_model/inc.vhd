entity INC is
    port(   D_IN  : in bit_vector(11 downto 0);
            D_OUT : out bit_vector(11 downto 0) );

end INC;

architecture behav of INC is

begin

    process(D_IN)
        variable c : bit;
    begin
    
        c := '1';
        for i in 0 to 11 loop
            D_OUT(i) <= c xor D_IN(i);
            c := D_IN(i) and c;
        end loop;
    
    end process;

end behav;