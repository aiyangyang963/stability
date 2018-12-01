	component ddr_ads_contol is
		port (
			source     : out std_logic_vector(3 downto 0);        -- source
			source_ena : in  std_logic                    := 'X'; -- source_ena
			source_clk : in  std_logic                    := 'X'  -- clk
		);
	end component ddr_ads_contol;

	u0 : component ddr_ads_contol
		port map (
			source     => CONNECTED_TO_source,     --    sources.source
			source_ena => CONNECTED_TO_source_ena, --           .source_ena
			source_clk => CONNECTED_TO_source_clk  -- source_clk.clk
		);

