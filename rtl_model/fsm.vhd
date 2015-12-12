entity FSM is
port(   TAKE_JMP   : in bit;
        STORE       : in bit;
        CMD_CALC    : in bit;
        CMD_CONST   : in bit;
        CMD_DIR     : in bit;
        CMD_REG     : in bit;
        CMD_IO      : in bit;
        CMD_PC      : in bit;
        CMD_JMP     : in bit;
        CMD_STOP    : in bit;
        DEV_RDY     : in bit;
        CLK         : in bit;
        RST         : in bit;
        A_OUT_MUX   : out bit_vector(1 downto 0);
        INSTR_EN    : out bit;
        ADDR_EN     : out bit;
        PC_EN       : out bit; 
        PC_MUX      : out bit;
        REG_EN      : out bit;
        FC_SEL      : out bit;
        D_IN_MUX    : out bit;
        D_OUT_MUX   : out bit;
        W_EN        : out bit;
        IO_TYPE     : out bit;
        IO_EN       : out bit;
        ACTIVE      : out bit);
end FSM;


architecture MEALY of FSM is

subtype state_type is bit_vector(4 downto 0);
constant i_IF : natural         := 0;
constant i_PFEX : natural       := 1;
constant i_IO : natural         := 2;
constant i_MEM : natural        := 3;
constant i_STOP : natural       := 4;

constant s_IF : state_type      := (i_IF    => '1', others => '0');
constant s_PFEX : state_type    := (i_PFEX  => '1', others => '0');
constant s_IO : state_type      := (i_IO    => '1', others => '0');
constant s_MEM : state_type     := (i_MEM   => '1', others => '0');
constant s_STOP : state_type    := (i_STOP  => '1', others => '0');

signal s_STATE : state_type     := s_IF;
begin

state_update: process (CLK, RST)
begin
    if RST = '0' then
        s_STATE <= s_IF;
    elsif CLK = '1' and CLK'event then
        case s_STATE is
            when s_IF => s_STATE <= s_PFEX;
            when s_PFEX =>
                if STORE = '1' then
                    s_STATE <= s_MEM;
                elsif CMD_IO = '1' then
                    s_STATE <= s_IO;
                elsif CMD_STOP = '1' then
                    s_STATE <= s_STOP;
                else
                    s_STATE <= s_IF;
                end if;
            when s_IO =>
                if (not DEV_RDY) = '0' then
                    s_STATE <= s_IF;
                end if;
            when s_MEM => s_STATE <= s_PFEX;
            when s_STOP => s_STATE <= s_STOP;
            when others =>
                s_STATE <= s_STOP;
                assert FALSE report "invalid FSM state" severity error;                
        end case;
    end if;
end process state_update;

    --output LUT
    A_OUT_MUX(1)    <= s_STATE(i_PFEX) and CMD_REG;
    A_OUT_MUX(0)    <= (s_STATE(i_IF) and TAKE_JMP) or s_STATE(i_MEM);
    INSTR_EN        <= s_STATE(i_IF);
    ADDR_EN         <= s_STATE(i_PFEX) and (CMD_DIR or CMD_JMP);
    PC_EN           <= s_STATE(i_IF) or (s_STATE(i_PFEX) and (CMD_CONST or CMD_DIR or (CMD_PC and STORE) or CMD_JMP));
    PC_MUX          <= s_STATE(i_PFEX) and CMD_PC;
    REG_EN          <= (s_STATE(i_PFEX) and (CMD_CALC or CMD_CONST or ((CMD_REG or CMD_PC) and (not STORE)))) or (s_STATE(i_MEM) and (not STORE)) or (s_STATE(i_IO) and DEV_RDY and (not STORE));
    FC_SEL          <= NOT CMD_CALC;
    D_IN_MUX        <= s_STATE(i_IO);
    D_OUT_MUX       <= CMD_PC;
    W_EN            <= (s_STATE(i_PFEX) and CMD_REG and STORE) or (s_STATE(i_MEM) and STORE);
    IO_TYPE         <= (s_STATE(i_PFEX) and CMD_IO and STORE) or (s_STATE(i_IO) and STORE);
    IO_EN           <= (s_STATE(i_IO) and DEV_RDY);
    ACTIVE          <= NOT s_STATE(i_STOP);  
 
end MEALY;
