	component ds3231_value is
		port (
			source     : out std_logic_vector(47 downto 0);                    -- source
			source_ena : in  std_logic                     := 'X';             -- source_ena
			probe      : in  std_logic_vector(47 downto 0) := (others => 'X'); -- probe
			source_clk : in  std_logic                     := 'X'              -- clk
		);
	end component ds3231_value;

	u0 : component ds3231_value
		port map (
			source     => CONNECTED_TO_source,     --    sources.source
			source_ena => CONNECTED_TO_source_ena, --           .source_ena
			probe      => CONNECTED_TO_probe,      --     probes.probe
			source_clk => CONNECTED_TO_source_clk  -- source_clk.clk
		);

