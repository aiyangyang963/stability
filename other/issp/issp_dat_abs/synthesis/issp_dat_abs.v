// issp_dat_abs.v

// Generated using ACDS version 16.1 203

`timescale 1 ps / 1 ps
module issp_dat_abs (
		input  wire        source_clk, // source_clk.clk
		output wire [15:0] source,     //    sources.source
		input  wire        source_ena  //           .source_ena
	);

	altsource_probe_top #(
		.sld_auto_instance_index ("YES"),
		.sld_instance_index      (0),
		.instance_id             ("abs"),
		.probe_width             (0),
		.source_width            (16),
		.source_initial_value    ("4"),
		.enable_metastability    ("YES")
	) in_system_sources_probes_0 (
		.source     (source),     //    sources.source
		.source_ena (source_ena), //           .source_ena
		.source_clk (source_clk)  // source_clk.clk
	);

endmodule
