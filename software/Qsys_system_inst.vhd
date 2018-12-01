	component Qsys_system is
		port (
			clk_clk         : in  std_logic := 'X'; -- clk
			pio_key_export  : in  std_logic := 'X'; -- export
			pio_led0_export : out std_logic;        -- export
			reset_reset_n   : in  std_logic := 'X'  -- reset_n
		);
	end component Qsys_system;

	u0 : component Qsys_system
		port map (
			clk_clk         => CONNECTED_TO_clk_clk,         --      clk.clk
			pio_key_export  => CONNECTED_TO_pio_key_export,  --  pio_key.export
			pio_led0_export => CONNECTED_TO_pio_led0_export, -- pio_led0.export
			reset_reset_n   => CONNECTED_TO_reset_reset_n    --    reset.reset_n
		);

