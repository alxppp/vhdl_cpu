architecture behavioral of System is

    --clock and reset signals
    signal CLK, RST, ACTIVE : bit;
    
    --cpu data signals
    signal D_IN, D_OUT : bit_vector(11 downto 0);
    
    --cpu control signals
    signal SEL_IN, IO_EN, IO_TYPE, DEV_RDY : bit;
    
    --mem signals
    signal MEM_ADDR, MEM_OUT : bit_vector(11 downto 0);
    signal MEM_EN : bit;
    
    --in device signals
    signal IN_DATA_TO_CPU, IN_DATA_FROM_TB : bit_vector(11 downto 0);
    signal IN_DEV_RDY, IN_REQ, IN_RDY : bit;
    
    --out device signals
    signal OUT_DATA_TO_TB : bit_vector(11 downto 0);
    signal OUT_DEV_RDY, OUT_REQ, OUT_RDY : bit;

begin

    RST <= '1' after 10 ns;
    CLK <= not CLK after 5 ns when ACTIVE = '1' else '0';

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
                            d_in_b => IN_DATA_TO_CPU,
                            d_out => D_IN );
                        
    DEV_MUX:    entity WORK.mux_2x1(RTL)
                port map(   sel_in => IO_TYPE,
                            d_in_a => IN_DEV_RDY,
                            d_in_b => OUT_DEV_RDY,
                            d_out => DEV_RDY );
                            
    MEM:        entity WORK.Memory(rtl_bootloader)
               	port map(   clk => CLK,
                            data_in => D_OUT,
			    addr => MEM_ADDR,
                            w_en => MEM_EN,
                            data_out => MEM_OUT );

    IN_DEV:     entity WORK.InDevice(behavioral)
                port map(   CLK => CLK,
                            RST => RST,
                            ACC_EN => IO_EN,
                            ACC_TYPE => IO_TYPE,
                            DATA_RDY => IN_RDY,
                            DATA_IN => IN_DATA_FROM_TB,
                            DEV_RDY => IN_DEV_RDY,
                            DATA_REQ => IN_REQ,
                            DATA_OUT => IN_DATA_TO_CPU );
                            
    OUT_DEV:    entity WORK.OutDevice(behavioral)
                port map(   CLK => CLK,
                            RST => RST,
                            ACC_EN => IO_EN,
                            ACC_TYPE => IO_TYPE,
                            DATA_RDY => OUT_RDY,
                            DATA_IN => D_OUT,
                            DEV_RDY => OUT_DEV_RDY,
                            DATA_REQ => OUT_REQ,
                            DATA_OUT => OUT_DATA_TO_TB );
                            
    IO_TEST:    entity WORK.IO_Testbench(TB)
                port map(   CLK => CLK,
                            RST => RST,
                            IN_REQ => IN_REQ,
                            IN_READY => IN_RDY,
                            IN_DATA => IN_DATA_FROM_TB,
                            OUT_READY => OUT_RDY,
                            OUT_REQ => OUT_REQ,
                            OUT_DATA => OUT_DATA_TO_TB );
            
end behavioral;