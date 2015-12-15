entity out_device is
	port (  CLK : 	     in bit;	--3.5.2.1
		RST : 	     in bit;	--3.5.2.2
		enable :     in bit;	--3.5.2.4, active high, to connect with FSM.IO_EN
		out_enable : in bit;	--3.5.2.5, active high,  to connect with FSM.IO_TYP
		data_from_proc :       in bit_vector(11 downto 0);  --3.5.2.6
		data_req_from_outside :in bit ;		    	    --3.5.2.9, active high
		data_to_outside :      out bit_vector(11 downto 0); --3.5.2.7
		ready_to_outside :     out bit;  	  	    --3.5.2.8, active high
		device_ready : 	       out bit );		    --3.5.2.3,  active high, to connect with FSM.DEV.RDY
end out_device;
