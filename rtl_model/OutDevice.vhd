
entity OutDevice is

    Port (  CLK         : in bit;
            RST         : in bit;
            ACC_EN      : in bit;
            ACC_TYPE    : in bit;
            DATA_RDY    : out bit;
            DATA_IN     : in bit_vector(11 downto 0);
            DEV_RDY     : out bit;
            DATA_REQ    : in bit;
            DATA_OUT    : out bit_vector(11 downto 0) );
            
end OutDevice;

architecture Behavioral of OutDevice is

    signal D_REG : bit_vector(11 downto 0);
    signal D_EMPTY : bit;

begin
    
    DEV_RDY <= not D_EMPTY;
                 
    DATA_RDY <= '1' when DATA_REQ = '1' and D_EMPTY = '0'
		   else '0';

    DATA_OUT <= D_REG when DATA_REQ = '1' and D_EMPTY = '0'
		   else (others =>'0');
    
    process(RST, CLK)
    begin
        if RST = '0' then
            D_REG <= (others => '0');
            D_EMPTY <= '1';
        elsif CLK = '1' and CLK'event then
            
            if ACC_EN = '1' and ACC_TYPE = '1' and D_EMPTY = '1' then
                D_REG <= DATA_IN;
                D_EMPTY <= '0';
            end if;
            
            if DATA_REQ = '1' and D_EMPTY = '0' then
                D_EMPTY <= '1';
            end if;
        
        end if;
    end process;
    

end Behavioral;