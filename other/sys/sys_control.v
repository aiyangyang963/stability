`timescale 1 ns / 1 ns
module sys_control(
//////////////////////clock
		input	 clk1,clk2,
		
		output wire	clk_250,
		output wire	clk_500,
		output wire	clk_2500,
		output wire	clk_1K,
		output wire	clk_5K,
		output wire	clk_7K,
		output wire	clk_25K,
		output wire	clk_250K,
		output wire	clk_500K,
		
		output wire	clk_2_5m,
		output wire	clk_5m,  
		output wire	clk_7m,  
		output wire	clk_10m, 
		output wire	clk_17m, 
		output wire	clk_25m, 
		output wire	clk_34m, 
		output wire	clk_50m, 
		
		output wire clk_100m,
		output wire clk_200m,
		output wire clk_400m,
//////////////////////led
		output wire	LED_FPGA0,
		output wire	LED_FPGA1,
//////////////////////reset
		input  local_init_done,
		output wire	rst_out0,
	   output wire	rst_out1,
//////////////////////time
		inout sda,
		output wire scl,
		
		input write_start_uart,
		output wire write_over_uart,
		input [47:0]write_dat_uart,
		
		output wire [7:0]ds_MsecondsL,		
		output wire [7:0]ds_MsecondsH,
		output wire [7:0]ds_Seconds,
		output wire [7:0]ds_Minutes,
		output wire [7:0]ds_Hour,
		output wire [7:0]ds_Date,
		output wire [7:0]ds_Month,
		output wire [7:0]ds_Year
		);

wire rst;		
clock_lf clock_lf(
	.rst(rst),
	.clk1(clk1),
	.clk2(clk2),
	
	.clk_250(clk_250),
	.clk_500(clk_500),
	.clk_2500(clk_2500),
	.clk_1K(clk_1K),
	.clk_5K(clk_5K),
	.clk_7K(clk_7K),
	.clk_25K(clk_25K),
	.clk_250K(clk_250K),
	.clk_500K(clk_500K),
	
	.clk_2_5m(clk_2_5m),
	.clk_5m(clk_5m),  
	.clk_7m(clk_7m),  
	.clk_10m(clk_10m), 
	.clk_17m(clk_17m), 
	.clk_25m(clk_25m), 
	.clk_34m(clk_34m), 
	.clk_50m(clk_50m), 
	
	.clk_100m(clk_100m),
	.clk_200m(clk_200m),
	.clk_400m(clk_400m));
	
led_test	led (
	 .CLK_IN(clk_50m),
	 .rst(rst),
	 .LED_FPGA0(LED_FPGA0),
	 .LED_FPGA1(LED_FPGA1)
	);
	
sys_rst sys_rst(
	.clk(clk_50m),
	.local_init_done(local_init_done),
	
	.rst_out0(rst_out0),
	.rst_out1(rst_out1));
	
ds3231_i2c ds3231_i2c(			
	.rst(rst),
	.clk_250k(clk_250K),
	.clk_50m(clk_50m),
	.sda(sda),
	.scl(scl),
	
	.write_start_uart(ds3231_write_start),
	.write_over_uart(ds3231_write_over),
	.write_dat_uart(ds3231_write_dat),
	
	.ds_MsecondsL(ds_MsecondsL),		
	.ds_MsecondsH(ds_MsecondsH),
	.ds_Seconds(ds_Seconds),
	.ds_Minutes(ds_Minutes),
	.ds_Hour(ds_Hour),
	.ds_Date(ds_Date),
	.ds_Month(ds_Month),
	.ds_Year(ds_Year)
	);
	
endmodule