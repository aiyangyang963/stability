	component issp_dat_abs is
		port (
			source_clk : in  std_logic                     := 'X'; -- clk
			source     : out std_logic_vector(15 downto 0);        -- source
			source_ena : in  std_logic                     := 'X'  -- source_ena
		);
	end component issp_dat_abs;

	u0 : component issp_dat_abs
		port map (
			source_clk => CONNECTED_TO_source_clk, -- source_clk.clk
			source     => CONNECTED_TO_source,     --    sources.source
			source_ena => CONNECTED_TO_source_ena  --           .source_ena
		);

