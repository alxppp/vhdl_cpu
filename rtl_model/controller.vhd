entity CONTROLLER is
  Port ( CLK             : in bit;
         RST             : in bit;
         
         --- command and address in, flags
         D_IN            : in bit_vector(11 downto 0);
         A_IN_1, A_IN_2  : in bit_vector(11 downto 0);
         FLAGS           : in bit_vector(3 downto 0);
         
         --- datapath signals
         FC_SEL, REG_EN  : out bit;
         SEL_IN          : out bit_vector(1 downto 0);
         SEL_OUT_A       : out bit_vector(1 downto 0);
         SEL_OUT_B       : out bit_vector(1 downto 0);
         SEL_OUT_C       : out bit_vector(1 downto 0);
         OP              : out bit_vector(5 downto 0);
         D_OUT           : out bit_vector(11 downto 0);
         
         --- memory and other external interface
         DEV_RDY         : in bit;
         A_OUT           : out bit_vector(11 downto 0);
         W_EN, D_IN_MUX  : out bit;
         IO_TYPE, IO_EN  : out bit;
         
         --- active signal
         ACTIVE          : out bit);
end controller;

architecture STRUCTURAL of controller is

--- FSM input signals
signal TAKE_JMP : bit;
signal STORE : bit;
signal CMD_CALC : bit;
signal CMD_CONST : bit;
signal CMD_DIR : bit;
signal CMD_REG : bit;
signal CMD_IO : bit;
signal CMD_PC : bit;
signal CMD_JMP : bit;
signal CMD_STOP : bit;

--- FSM internal output signals
signal INSTR_EN : bit;
signal PC_MUX : bit;
signal PC_EN : bit;
signal ADDR_EN : bit;
signal A_OUT_MUX : bit_vector(1 downto 0);
signal D_OUT_MUX : bit;

--- ADDR, PC, INSTR
signal ADDR : bit_vector(11 downto 0);
signal PC : bit_vector(11 downto 0);
signal INC_OUT : bit_vector(11 downto 0);
signal PC_IN : bit_vector(11 downto 0);
signal INSTR : bit_vector(11 downto 0);

signal A_OUT_TMP : bit_vector(11 downto 0);

signal GND : bit_vector(11 downto 0);
begin
GND <= (others => '0');
A_OUT <= A_OUT_TMP;

-- Entities
ID : entity work.instruction_decoder(case_driven_with_default_assignment)
     port map( INSTR=>INSTR, 
               FLAGS=>FLAGS,
               OP=>OP, 
               SEL_IN=>SEL_IN,
               SEL_OUT_A=>SEL_OUT_A, 
               SEL_OUT_B=>SEL_OUT_B, 
               SEL_OUT_C=>SEL_OUT_C,
               TAKE_JMP=>TAKE_JMP, 
               STORE=>STORE,
               CMD_CALC=>CMD_CALC,
               CMD_CONST=>CMD_CONST,
               CMD_DIR=>CMD_DIR,
               CMD_REG=>CMD_REG,
               CMD_IO=>CMD_IO,
               CMD_PC=>CMD_PC,
               CMD_JMP=>CMD_JMP,
               CMD_STOP=>CMD_STOP );

FSM : entity work.FSM(MEALY)
      port map( TAKE_JMP=>TAKE_JMP,
                STORE=>STORE,
                CMD_CALC=>CMD_CALC,
                CMD_CONST=>CMD_CONST,
                CMD_DIR=>CMD_DIR,
                CMD_REG=>CMD_REG,
                CMD_IO=>CMD_IO,
                CMD_PC=>CMD_PC,
                CMD_JMP=>CMD_JMP,
                CMD_STOP=>CMD_STOP,
                DEV_RDY=>DEV_RDY,
                CLK=>CLK,
                RST=>RST,
                A_OUT_MUX=>A_OUT_MUX,
                INSTR_EN=>INSTR_EN,
                ADDR_EN=>ADDR_EN,
                PC_EN=>PC_EN,
                PC_MUX=>PC_MUX,
                REG_EN=>REG_EN,
                FC_SEL=>FC_SEL,
                D_IN_MUX=>D_IN_MUX,
                D_OUT_MUX=>D_OUT_MUX,
                W_EN=>W_EN,
                IO_TYPE=>IO_TYPE,
                IO_EN=>IO_EN,
                ACTIVE=>ACTIVE );

Instr_reg : entity work.D_REG12RE(RTL)
        port map( D_IN => D_IN,
                  RST => RST,
                  CLK => CLK,
                  ENABLE => INSTR_EN,
                  Q_OUT => INSTR );

Addr_reg : entity work.D_REG12RE(RTL)
        port map( D_IN => D_IN,
                  RST => RST,
                  CLK => CLK,
                  ENABLE => ADDR_EN,
                  Q_OUT => ADDR );
                  
PC_reg : entity work.D_REG12RE(RTL)
     port map( D_IN => PC_IN,
               RST => RST,
               CLK => CLK,
               ENABLE => PC_EN,
               Q_OUT => PC );

INC : entity work.INC(behav)
      port map( D_IN => A_OUT_TMP,
                D_OUT => INC_OUT);

--- Muxes

MUX_D_OUT : entity work.mux12_2x1(RTL)
      port map( select_input => D_OUT_MUX,
                d_in_a => D_IN, 
                d_in_b => PC, 
                d_out => D_OUT );
                
MUX_PC_IN : entity work.mux12_2x1(RTL)
            port map( select_input => PC_MUX,
                      d_in_a => INC_OUT, 
                      d_in_b => A_IN_2, 
                      d_out => PC_IN );
                      
MUX_A_OUT : entity work.mux12_4x1(RTL)
            port map( select_input => A_OUT_MUX,
                      d_in_a => PC,
                      d_in_b => ADDR,
                      d_in_c => A_IN_1,
                      d_in_d => GND,
                      d_out  => A_OUT_TMP );
                      
end STRUCTURAL;
