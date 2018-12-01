	component Qsys_system is
		port (
			clk_clk        : in  std_logic := 'X'; -- clk
			reset_reset_n  : in  std_logic := 'X'; -- reset_n
			pio_led_export : out std_logic;        -- export
			pio_key_export : in  std_logic := 'X'  -- export
		);
	end component Qsys_system;

	u0 : component Qsys_system
		port map (
			clk_clk        => CONNECTED_TO_clk_clk,        --     clk.clk
			reset_reset_n  => CONNECTED_TO_reset_reset_n,  --   reset.reset_n
			pio_led_export => CONNECTED_TO_pio_led_export, -- pio_led.export
			pio_key_export => CONNECTED_TO_pio_key_export  -- pio_key.export
		);

