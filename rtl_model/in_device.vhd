entity in_device is
	port (  CLK : 	    in bit;	--3.5.2.1
		RST : 	    in bit;	--3.5.2.2
		enable :    in bit;	--3.5.2.4, active high, to connect with FSM.IO_EN
		in_enable : in bit;	--3.5.2.5, active low, to connect with FSM.IO_TYP
		data_from_outside :  in bit_vector(11 downto 0); --3.5.2.11
		ready_from_outside : in bit;  	  	         --3.5.2.12, active high
		data_to_proc :       out bit_vector(11 downto 0);--3.5.2.10
		req_to_outside :out bit ;		         --3.5.2.13, active high
		device_ready : 	     out bit );		         --3.5.2.3,  active high, to connect with FSM.DEV.RDY
end in_device;



architecture in_device_rtl of in_device is

	signal int_reg_enable : bit := '0';
	signal data : bit_vector(11 downto 0);
	
	subtype state_type is integer range 3 downto 0;
	constant nr_ne : state_type := 0; --device not ready and not enabled
	constant nr_e :  state_type := 1; --device not ready and enabled
	constant r_ne :  state_type := 2; --device ready and not enabled
	constant r_e :   state_type := 3; --device ready and enabled
	signal state : state_type := nr_ne;

begin

	int_reg : entity WORK.D_REG12RE(RTL)
		  port map (clk => CLK, RST=>RST, Enable=>enable, D_IN=>data_from_outside, Q_out=>data);

	state_update: process (RST, CLK)
	begin
		if RST = '0' then
			state <= nr_ne;
		end if;
		if CLK ='1' and CLK'event then
			case state is --according to 3.5.3
			when nr_ne =>
				device_ready <= '0';
				data_to_proc <= (others => '0');
				req_to_outside <= '1';
				if ready_from_outside='1' AND (enable='1' and not in_enable='1') then
					int_reg_enable <= '1';
					state <= r_e;
				elsif ready_from_outside='1' then
					int_reg_enable <= '1';
					state <= r_ne;
				elsif enable='1' and not in_enable='1' then
					int_reg_enable <= '0';
					state <= nr_e;
				else
					int_reg_enable <= '0';
					state <= nr_ne;
				end if;
			when nr_e =>
				device_ready <= '0';
				data_to_proc <= (others => '0');
				req_to_outside <= '1';
				if ready_from_outside='1' and (not enable='1' or in_enable='1') then
					int_reg_enable <= '1';
					state <= r_ne;
				elsif ready_from_outside='1' then
					int_reg_enable <= '1';
					state <= r_e;
				elsif not enable='1' or in_enable='1' then
					int_reg_enable <= '0';
					state <= nr_ne;
				else
					int_reg_enable <= '0';
					state <= nr_e;
				end if;
			when r_ne =>
				device_ready <= '1';
				data_to_proc <= (others =>'0');
				req_to_outside <= '0';
				int_reg_enable <= '0';
				if enable='1' and not in_enable='1' then
					state <= r_e;
				else
					state <= r_ne;
				end if;
			when r_e =>	
				device_ready <= '1';
				data_to_proc <= data;
				req_to_outside <= '0';
				int_reg_enable <= '0';
				if not enable='1' or in_enable='1' then
					state <= r_ne;
				else
					state <= r_e;
				end if;
			end case;
		end if;
end process;

end in_device_rtl;