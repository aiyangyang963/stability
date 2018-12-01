
module ds3231_value (
	source,
	source_ena,
	probe,
	source_clk);	

	output	[47:0]	source;
	input		source_ena;
	input	[47:0]	probe;
	input		source_clk;
endmodule
