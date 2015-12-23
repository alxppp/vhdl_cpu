entity CPU is

	port(	--reset and clock signals
		RST, CLK : in bit;
		--memory signals
		MEM_ADDR : out bit_vector(11 downto 0);
		--data signals
		DATA_IN : in bit_vector(11 downto 0);
		DATA_OUT : out bit_vector(11 downto 0);
		--control signals
		SEL_IN : out bit;
		MEM_W_EN : out bit;
		IO_EN : out bit;
		IO_TYPE : out bit;
		DEV_RDY : in bit );

end CPU;


architecture struct of CPU is
	--signals between datapath and controller
	signal DAT_TO_DATPATH, DAT_1_TO_CONTR, DAT_2_TO_CONTR : bit_vector(11 downto 0);
	signal OP_TO_DATPATH : bit_vector(5 downto 0);
	signal FLAGS_TO_CONTR : bit_vector(3 downto 0);
	signal SEL_IN_TO_DATPATH, SEL_A_TO_DATPATH, SEL_B_TO_DATPATH, SEL_C_TO_DATPATH : bit_vector(1 downto 0);
	signal FC_SEL_TO_DATPATH, REG_EN_TO_DATPATH : bit;

begin

	DATPATH : 	entity WORK.datapath(mixed)
			port map(	CLK => CLK, 
					RST => RST,	
					OP => OP_TO_DATPATH,
					D_IN => DAT_TO_DATPATH,
					FLAGS => FLAGS_TO_CONTR,
					SEL_IN => SEL_IN_TO_DATPATH,
					SEL_OUT_A => SEL_A_TO_DATPATH,
					SEL_OUT_B => SEL_B_TO_DATPATH,
					SEL_OUT_C => SEL_C_TO_DATPATH,
					D_OUT_1 => DAT_1_TO_CONTR,
					D_OUT_2 => DAT_2_TO_CONTR,
					FC_SEL => FC_SEL_TO_DATPATH,
					REG_EN => REG_EN_TO_DATPATH );
					

end struct;

configuration CPU_CONFIG of CPU is
	for struct
	end for;
end CPU_CONFIG;