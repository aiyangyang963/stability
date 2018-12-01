	component ds3231_inikey is
		port (
			probe      : in  std_logic_vector(0 downto 0) := (others => 'X'); -- probe
			source_clk : in  std_logic                    := 'X';             -- clk
			source     : out std_logic_vector(0 downto 0);                    -- source
			source_ena : in  std_logic                    := 'X'              -- source_ena
		);
	end component ds3231_inikey;

	u0 : component ds3231_inikey
		port map (
			probe      => CONNECTED_TO_probe,      --     probes.probe
			source_clk => CONNECTED_TO_source_clk, -- source_clk.clk
			source     => CONNECTED_TO_source,     --    sources.source
			source_ena => CONNECTED_TO_source_ena  --           .source_ena
		);

