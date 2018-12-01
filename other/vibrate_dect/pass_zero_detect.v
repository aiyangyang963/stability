`timescale 1ns / 1ns
module pass_zero_detect(
    input clk,rst,
	 	 
	 input [15:0]Ch0_Data_ads1,
	 input [15:0]Ch1_Data_ads1,
	 input [15:0]Ch2_Data_ads1,
	 input [15:0]Ch3_Data_ads1,
	 input Ch0_Data_en_ads1,
	 input Ch1_Data_en_ads1,
	 input Ch2_Data_en_ads1,
	 input Ch3_Data_en_ads1,
	 
	 output wire Ch0_alarm_ads1,
	 output wire Ch1_alarm_ads1,
	 output wire Ch2_alarm_ads1,
	 output wire Ch3_alarm_ads1,
	 
	 input [15:0]Ch0_Data_ads2,
	 input [15:0]Ch1_Data_ads2,
	 input [15:0]Ch2_Data_ads2,
	 input [15:0]Ch3_Data_ads2,
	 input Ch0_Data_en_ads2,
	 input Ch1_Data_en_ads2,
	 input Ch2_Data_en_ads2,
	 input Ch3_Data_en_ads2,
	 
	 output wire Ch0_alarm_ads2,
	 output wire Ch1_alarm_ads2,
	 output wire Ch2_alarm_ads2,
	 output wire Ch3_alarm_ads2);

wire [15:0]dat_max_ch0_ads1,dat_min_ch0_ads1;
wire [15:0]dat_max_ch1_ads1,dat_min_ch1_ads1;
wire [15:0]dat_max_ch2_ads1,dat_min_ch2_ads1;
wire [15:0]dat_max_ch3_ads1,dat_min_ch3_ads1;
wire dat_max_en_ch0_ads1,dat_max_en_ch1_ads1,dat_max_en_ch2_ads1,dat_max_en_ch3_ads1;
	
	 pass_zero_max pass_zero_max_ads1(
		.clk(clk),
		.rst(rst),
	 
	   .dat0_enable(Ch0_Data_en_ads1),
		.dat0(Ch0_Data_ads1),
		.dat1_enable(Ch1_Data_en_ads1),
		.dat1(Ch1_Data_ads1),
		.dat2_enable(Ch2_Data_en_ads1),
		.dat2(Ch2_Data_ads1),
		.dat3_enable(Ch3_Data_en_ads1),
		.dat3(Ch3_Data_ads1),
	 
		.dat0_max(dat_max_ch0_ads1),
		.dat0_min(dat_min_ch0_ads1),
		.dat0_max_en(dat_max_en_ch0_ads1),
		.dat1_max(dat_max_ch1_ads1),
		.dat1_min(dat_min_ch1_ads1),
		.dat1_max_en(dat_max_en_ch1_ads1),
		.dat2_max(dat_max_ch2_ads1),
		.dat2_min(dat_min_ch2_ads1),
		.dat2_max_en(dat_max_en_ch2_ads1),
		.dat3_max(dat_max_ch3_ads1),
		.dat3_min(dat_min_ch3_ads1),
		.dat3_max_en(dat_max_en_ch3_ads1));
		
	pass_zero_max pass_zero_max_ads2(
		.clk(clk),
		.rst(rst),
	 
	   .dat0_enable(Ch0_Data_en_ads2),
		.dat0(Ch0_Data_ads2),
		.dat1_enable(Ch1_Data_en_ads2),
		.dat1(Ch1_Data_ads2),
		.dat2_enable(Ch2_Data_en_ads2),
		.dat2(Ch2_Data_ads2),
		.dat3_enable(Ch3_Data_en_ads2),
		.dat3(Ch3_Data_ads2),
	 
		.dat0_max(dat_max_ch0_ads2),
		.dat0_min(dat_min_ch0_ads2),
		.dat0_max_en(dat_max_en_ch0_ads2),
		.dat1_max(dat_max_ch1_ads2),
		.dat1_min(dat_min_ch1_ads2),
		.dat1_max_en(dat_max_en_ch1_ads2),
		.dat2_max(dat_max_ch2_ads2),
		.dat2_min(dat_min_ch2_ads2),
		.dat2_max_en(dat_max_en_ch2_ads2),
		.dat3_max(dat_max_ch3_ads2),
		.dat3_min(dat_min_ch3_ads2),
		.dat3_max_en(dat_max_en_ch3_ads2));

	wire alarm_ch0_ads1;
	wire alarm_ch1_ads1;
	wire alarm_ch2_ads1;
	wire alarm_ch3_ads1;
	
	assign Ch0_alarm_ads1=alarm_ch0_ads1;
	assign Ch1_alarm_ads1=alarm_ch1_ads1;
	assign Ch2_alarm_ads1=alarm_ch2_ads1;
	assign Ch3_alarm_ads1=alarm_ch3_ads1;
		
	pass_zero_alarm pza_ads1(
		.clk(clk),
		.rst(rst),
	 	 
		.dat0_max(dat_max_ch0_ads1),
		.dat0_min(dat_min_ch0_ads1),
		.dat0_max_en(dat_max_en_ch0_ads1),
		.dat0_alarm(alarm_ch0_ads1),
		
		.dat1_max(dat_max_ch1_ads1),
		.dat1_min(dat_min_ch1_ads1),
		.dat1_max_en(dat_max_en_ch1_ads1),
		.dat1_alarm(alarm_ch1_ads1),
		
		.dat2_max(dat_max_ch2_ads1),
		.dat2_min(dat_min_ch2_ads1),
		.dat2_max_en(dat_max_en_ch2_ads1),
		.dat2_alarm(alarm_ch2_ads1),
		
		.dat3_max(dat_max_ch3_ads1),
		.dat3_min(dat_min_ch3_ads1),
		.dat3_max_en(dat_max_en_ch3_ads1),
		.dat3_alarm(alarm_ch3_ads1)
		);

	wire alarm_ch0_ads2;
	wire alarm_ch1_ads2;
	wire alarm_ch2_ads2;
	wire alarm_ch3_ads2;
	assign Ch0_alarm_ads2=alarm_ch0_ads2;
	assign Ch1_alarm_ads2=alarm_ch1_ads2;
	assign Ch2_alarm_ads2=alarm_ch2_ads2;
	assign Ch3_alarm_ads2=alarm_ch3_ads2;
	
//	wire [15:0]dat_max_ch0_ads2,dat_min_ch0_ads2;
//	wire [15:0]dat_max_ch1_ads2,dat_min_ch1_ads2;
//	wire [15:0]dat_max_ch2_ads2,dat_min_ch2_ads2;
//	wire [15:0]dat_max_ch3_ads2,dat_min_ch3_ads2;
//	wire dat_max_en_ch0_ads2,dat_max_en_ch1_ads2,dat_max_en_ch2_ads2,dat_max_en_ch3_ads2;
	
	pass_zero_alarm pza_ads2(
		.clk(clk),
		.rst(rst),
	 	 
		.dat0_max(dat_max_ch0_ads2),
		.dat0_min(dat_min_ch0_ads2),
		.dat0_max_en(dat_max_en_ch0_ads2),
		.dat0_alarm(alarm_ch0_ads2),
		
		.dat1_max(dat_max_ch1_ads2),
		.dat1_min(dat_min_ch1_ads2),
		.dat1_max_en(dat_max_en_ch1_ads2),
		.dat1_alarm(alarm_ch1_ads2),
		
		.dat2_max(dat_max_ch2_ads2),
		.dat2_min(dat_min_ch2_ads2),
		.dat2_max_en(dat_max_en_ch2_ads2),
		.dat2_alarm(alarm_ch2_ads2),
		
		.dat3_max(dat_max_ch3_ads2),
		.dat3_min(dat_min_ch3_ads2),
		.dat3_max_en(dat_max_en_ch3_ads2),
		.dat3_alarm(alarm_ch3_ads2)
		);
		
endmodule