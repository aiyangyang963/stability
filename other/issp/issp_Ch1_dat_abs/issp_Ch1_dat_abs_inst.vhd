	component issp_Ch1_dat_abs is
		port (
			source     : out std_logic_vector(15 downto 0);                    -- source
			source_ena : in  std_logic                     := 'X';             -- source_ena
			probe      : in  std_logic_vector(0 downto 0)  := (others => 'X'); -- probe
			source_clk : in  std_logic                     := 'X'              -- clk
		);
	end component issp_Ch1_dat_abs;

	u0 : component issp_Ch1_dat_abs
		port map (
			source     => CONNECTED_TO_source,     --    sources.source
			source_ena => CONNECTED_TO_source_ena, --           .source_ena
			probe      => CONNECTED_TO_probe,      --     probes.probe
			source_clk => CONNECTED_TO_source_clk  -- source_clk.clk
		);

