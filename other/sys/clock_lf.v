`timescale 1 ns / 1 ns
module clock_lf(
		input  rst,
		input	 clk1,clk2,
		
(* syn_preserve = 1 *)  output wire	clk_250,
(* syn_preserve = 1 *)  output wire	clk_500,
(* syn_preserve = 1 *)  output wire	clk_2500,
(* syn_preserve = 1 *)  output wire	clk_1K,
(* syn_preserve = 1 *)  output wire	clk_5K,
(* syn_preserve = 1 *)  output reg	clk_7K,
(* syn_preserve = 1 *) output wire	clk_25K,
(* syn_preserve = 1 *)  output wire	clk_250K,
(* syn_preserve = 1 *)  output wire	clk_500K,
		
(* syn_preserve = 1 *)  output wire	clk_2_5m,
(* syn_preserve = 1 *)  output wire	clk_5m,  
(* syn_preserve = 1 *)  output wire	clk_7m,  
(* syn_preserve = 1 *)  output wire	clk_10m, 
(* syn_preserve = 1 *)  output wire	clk_17m, 
(* syn_preserve = 1 *)  output wire	clk_25m, 
(* syn_preserve = 1 *)  output wire	clk_34m, 
(* syn_preserve = 1 *)  output wire	clk_50m, 
	
		output wire clk_100m,
		output wire clk_200m,
		output wire clk_400m);
		
// low speed clock produce
pll_L pll_L(
	.refclk(clk1),   	// refclk.clk
	.rst(rst),      		// reset.reset
	.outclk_0(clk_2_5m), // outclk0.clk
	.outclk_1(clk_5m  ),
	.outclk_2(clk_7m  ),
	.outclk_3(clk_10m ),
	.outclk_4(clk_17m ),
	.outclk_5(clk_25m ),
	.outclk_6(clk_34m ),
	.outclk_7(clk_50m ));
// high speed clock produce
pll_H pll_H(
	.refclk(clk2),   	// refclk.clk
	.rst(rst),      		// reset.reset
	.outclk_0(clk_100m),
	.outclk_1(clk_200m),
	.outclk_2(clk_400m));
		
defparam Gen_250.divdFACTOR=100_000,Gen_250.divdWIDTH=31;
(* syn_preserve = 1 *) gen_divd Gen_250(.reset(rst),.clkin(clk_50m),.clkout(clk_250));	
defparam Gen_500.divdFACTOR=50_000,Gen_500.divdWIDTH=31;
(* syn_preserve = 1 *) gen_divd Gen_500(.reset(rst),.clkin(clk_50m),.clkout(clk_500));	
defparam Gen_1K.divdFACTOR=25_000,Gen_1K.divdWIDTH=31;
(* syn_preserve = 1 *) gen_divd Gen_1K(.reset(rst),.clkin(clk_50m),.clkout(clk_1K));	
defparam Gen_5K.divdFACTOR=5000,Gen_5K.divdWIDTH=31;
(* syn_preserve = 1 *) gen_divd Gen_5K(.reset(rst),.clkin(clk_50m),.clkout(clk_5K));
defparam Gen_25K.divdFACTOR=1000,Gen_25K.divdWIDTH=31;
(* syn_preserve = 1 *) gen_divd Gen_25K(.reset(rst),.clkin(clk_50m),.clkout(clk_25K));
defparam Gen_250K.divdFACTOR=100,Gen_250K.divdWIDTH=31;
(* syn_preserve = 1 *) gen_divd Gen_250K(.reset(rst),.clkin(clk_50m),.clkout(clk_250K));	
defparam Gen_500K.divdFACTOR=50,Gen_500K.divdWIDTH=31;
(* syn_preserve = 1 *) gen_divd Gen_500K(.reset(rst),.clkin(clk_50m),.clkout(clk_500K));	
defparam Gen_2500.divdFACTOR=1_000,Gen_2500.divdWIDTH=15;
(* syn_preserve = 1 *) gen_divd Gen_2500(.reset(rst),.clkin(clk_50m),.clkout(clk_2500));

integer	clk_7k_cnt = 10'd0;
always @(posedge clk_7m)begin
	if (clk_7k_cnt ==10'd1000)  begin
		clk_7k_cnt <= 1'b0;
	end
	else begin
		clk_7k_cnt<=clk_7k_cnt+1;
		if (clk_7k_cnt <10'd500) begin
		clk_7K <= 1'b1;
		end
		else begin
		clk_7K <= 1'b0;
		end
	end
end

endmodule