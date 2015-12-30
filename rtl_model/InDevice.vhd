entity InDevice is

    Port (  CLK         : in bit;
            RST         : in bit;
            ACC_EN      : in bit;
            ACC_TYPE    : in bit;
            DATA_RDY    : in bit;
            DATA_IN     : in bit_vector(11 downto 0);
            DEV_RDY     : out bit;
            DATA_REQ    : out bit;
            DATA_OUT    : out bit_vector(11 downto 0) );
            
end InDevice;

architecture Behavioral of InDevice is

    signal D_REG : bit_vector(11 downto 0);
    signal D_EMPTY : bit;

begin
    DATA_OUT <= D_REG   when ACC_EN = '1' and ACC_TYPE = '0' and D_EMPTY = '0'
                        else (others => '0');                         
    DEV_RDY <= not D_EMPTY; 
    DATA_REQ <= D_EMPTY;
    
    process(RST, CLK)
    
    begin
        if RST = '0' then
            D_REG <= (others => '0');
            D_EMPTY <= '1';
        elsif CLK = '1' and CLK'event then
            
            if DATA_RDY = '1' and D_EMPTY = '1' then
                D_REG <= DATA_IN;
                D_EMPTY <= '0';
            end if;
            
            if ACC_EN = '1' and ACC_TYPE = '0' and D_EMPTY = '0' then
                D_EMPTY <= '1';
            end if;
--            if ACC_EN = '1' and ACC_TYPE = '0' and D_EMPTY = '0' then
--                DATA_OUT <= D_REG;
--            else
--                DATA_OUT <= (others => '0');                
--            end if;
            
--            DATA_REQ <= D_EMPTY;
--            DEV_RDY <= not D_EMPTY;
            
--            if DATA_RDY = '1' and D_EMPTY = '1' then
--                D_REG <= DATA_IN;
--                D_EMPTY <= '0';
--            end if;
                
        end if;
    end process;
    

end Behavioral;
