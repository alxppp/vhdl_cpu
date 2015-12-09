-- 2x1 multiplexer
entity mux12_2x1 is
	port (
		select_input	: in  bit;
		d_in_a, d_in_b	: in  bit_vector (11 downto 0);
		d_out			: out bit_vector (11 downto 0)
	);
end mux12_2x1;

architecture RTL of mux12_2x1 is
begin
	process (d_in_a, d_in_b, select_input)
		variable select_vector, select_vector_bar : bit_vector (11 downto 0);
	begin
		select_vector := (others => select_input);
		select_vector_bar := (others => not select_vector);

		d_out <= (d_in_a AND select_vector) OR (d_in_b AND select_vector_bar);
	end process;
end RTL;


-- 4x1 multiplexer
entity mux12_4x1 is
	port (
		select_input	: in  bit_vector (1 downto 0);
		d_in_a, d_in_b	: in  bit_vector (11 downto 0);
		d_in_c, d_in_d	: in  bit_vector (11 downto 0);
		d_out			: out bit_vector (11 downto 0)
	);
end mux12_4x1;

architecture RTL of mux12_4x1 is
begin
	process (d_in_a, d_in_b, d_in_c, d_in_d)
	begin
		if    select_input = "11" then d_out <= d_in_d;
		elsif select_input = "10" then d_out <= d_in_c;
		elsif select_input = "01" then d_out <= d_in_b;
		else                           d_out <= d_in_a;
		end if;
	end process;
end RTL;
