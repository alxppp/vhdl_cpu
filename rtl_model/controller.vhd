entity controller is
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


begin


end STRUCTURAL;
