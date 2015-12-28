entity System is
end System;

architecture behavioral of System is

    signal CLK, RST, ACTIVE : bit;
    signal MEM_ADDR, D_OUT, D_IN, MEM_OUT, IN_DEV_OUT : bit_vector(11 downto 0);
    signal IN_DEV_RDY, OUT_DEV_RDY, DEV_RDY, IO_EN, IO_TYPE, SEL_IN, MEM_EN : bit;

begin

    CPU1:       entity WORK.CPU(struct)
                port map(   CLK => CLK,
                            RST => RST,
                            MEM_ADDR => MEM_ADDR,
                            DATA_IN => D_IN,
                            DATA_OUT => D_OUT,
                            SEL_IN => SEL_IN,
                            MEM_W_EN => MEM_EN,
                            IO_EN => IO_EN,
                            IO_TYPE => IO_TYPE,
                            ACTIVE => ACTIVE,
                            DEV_RDY => DEV_RDY );
                        
    IN_MUX:     entity WORK.mux12_2x1(RTL)
                port map(   select_input => SEL_IN,
                            d_in_a => MEM_OUT,
                            d_in_b => IN_DEV_OUT,
                            d_out => D_IN );
                        
    DEV_MUX:    entity WORK.mux_2x1(RTL)
                port map(   sel_in => IO_TYPE,
                            d_in_a => IN_DEV_RDY,
                            d_in_b => OUT_DEV_RDY,
                            d_out => DEV_RDY );
                            
    MEM:        entity WORK.Memory(rtl)
                port map(   clk => CLK,
                            rst => RST,
                            data_in => D_OUT,
                            w_en => MEM_EN,
                            data_out => MEM_OUT );
                        
end behavioral;