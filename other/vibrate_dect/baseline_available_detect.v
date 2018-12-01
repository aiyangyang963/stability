`timescale 1ns / 1ns
module baseline_available_detect(
    input clk,rst,
	 	 
	 input [15:0]Ch0_Data,
	 input [15:0]Ch1_Data,
	 input [15:0]Ch2_Data,
	 input [15:0]Ch3_Data,
	 input Ch0_Data_en,
	 input Ch1_Data_en,
	 input Ch2_Data_en,
	 input Ch3_Data_en,
	 
	 input [15:0]Ch0_baseline,
	 input [15:0]Ch1_baseline,
	 input [15:0]Ch2_baseline,
	 input [15:0]Ch3_baseline,
	 
	 output wire Ch0_alarm,
	 output wire Ch1_alarm,
	 output wire Ch2_alarm,
	 output wire Ch3_alarm);
	 
wire [15:0]dat0_max,dat0_min;
wire [15:0]dat1_max,dat1_min;
wire [15:0]dat2_max,dat2_min;
wire [15:0]dat3_max,dat3_min;
wire dat0_max_en,dat1_max_en,dat2_max_en,dat3_max_en;
	 
pass_baseline_pole pass_baseline_pole(
    .clk(clk),
	 .rst(rst),
	 
	 .dat0(Ch0_Data),
	 .dat1(Ch1_Data),
	 .dat2(Ch2_Data),
	 .dat3(Ch3_Data),
	 .dat0_enable(Ch0_Data_en),
	 .dat1_enable(Ch1_Data_en),
	 .dat2_enable(Ch2_Data_en),
	 .dat3_enable(Ch3_Data_en),
	 
	 .dat0_base_line(Ch0_baseline),
	 .dat1_base_line(Ch1_baseline),
	 .dat2_base_line(Ch2_baseline),
	 .dat3_base_line(Ch3_baseline),
	 
	 .dat0_max(dat0_max),
	 .dat1_max(dat1_max),
	 .dat2_max(dat2_max),
	 .dat3_max(dat3_max),
	 .dat0_max_en(dat0_max_en),
	 .dat1_max_en(dat1_max_en),
	 .dat2_max_en(dat2_max_en),
	 .dat3_max_en(dat3_max_en),
	 
	 .dat0_min(at0_min),
	 .dat1_min(at1_min),
	 .dat2_min(at2_min),
	 .dat3_min(at3_min),
	 
	 .dat0_min_en(dat0_min_en),
	 .dat1_min_en(dat1_min_en),
	 .dat2_min_en(dat2_min_en),
	 .dat3_min_en(dat3_min_en)
	 );
	 
search_alarm search_alarm(
    .clk(clk),
	 .rst(rst),
	 	 
	 .dat0_max(dat0_max),
	 .dat1_max(dat1_max),
	 .dat2_max(dat2_max),
	 .dat3_max(dat3_max),
	 .dat0_max_en(dat0_max_en),
	 .dat1_max_en(dat1_max_en),
	 .dat2_max_en(dat2_max_en),
	 .dat3_max_en(dat3_max_en),
	 
	 .dat0_min(at0_min),
	 .dat1_min(at1_min),
	 .dat2_min(at2_min),
	 .dat3_min(at3_min),
	 
	 .dat0_alarm(Ch0_alarm),
	 .dat1_alarm(Ch1_alarm),
	 .dat2_alarm(Ch2_alarm),
	 .dat3_alarm(Ch3_alarm));
	 
endmodule