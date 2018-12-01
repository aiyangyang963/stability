	component read_buffer is
		port (
			probe      : in  std_logic_vector(0 downto 0) := (others => 'X'); -- probe
			source     : out std_logic_vector(1 downto 0);                    -- source
			source_ena : in  std_logic                    := 'X';             -- source_ena
			source_clk : in  std_logic                    := 'X'              -- clk
		);
	end component read_buffer;

	u0 : component read_buffer
		port map (
			probe      => CONNECTED_TO_probe,      --     probes.probe
			source     => CONNECTED_TO_source,     --    sources.source
			source_ena => CONNECTED_TO_source_ena, --           .source_ena
			source_clk => CONNECTED_TO_source_clk  -- source_clk.clk
		);

