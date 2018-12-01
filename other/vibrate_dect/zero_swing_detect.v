`timescale 1ns / 1ns
module zero_swing_detect(
    input clk,rst,
	 input detect_enable,
	 	 
	 input [15:0]Ch0_Data,
	 input [15:0]Ch1_Data,
	 input [15:0]Ch2_Data,
	 input [15:0]Ch3_Data,
	 input Ch0_Data_en,
	 input Ch1_Data_en,
	 input Ch2_Data_en,
	 input Ch3_Data_en,
	 
	 input Ch0_Data_sign,
	 input Ch1_Data_sign,
	 input Ch2_Data_sign,
	 input Ch3_Data_sign,

	 output wire Ch0_alarm,
	 output wire Ch1_alarm,
	 output wire Ch2_alarm,
	 output wire Ch3_alarm);
	 
wire [15:0]dat0_max,dat1_max,dat2_max,dat3_max;
wire dat0_max_en,dat1_max_en,dat2_max_en,dat3_max_en;
wire [15:0]dat0_min,dat1_min,dat2_min,dat3_min;
wire dat0_min_en,dat1_min_en,dat2_min_en,dat3_min_en;
	 
search_pole U1(
    .clk(clk),
	 .rst(rst),
	 .detect_enable(detect_enable),
	 
	 .dat0(Ch0_Data),
	 .dat1(Ch1_Data),
	 .dat2(Ch2_Data),
	 .dat3(Ch3_Data),
	 .dat0_enable(Ch0_Data_en),
	 .dat1_enable(Ch1_Data_en),
	 .dat2_enable(Ch2_Data_en),
	 .dat3_enable(Ch3_Data_en),
	 
	 .Ch0_Data_sign(Ch0_Data_sign),
	 .Ch1_Data_sign(Ch1_Data_sign),
	 .Ch2_Data_sign(Ch2_Data_sign),
	 .Ch3_Data_sign(Ch3_Data_sign),

	 .dat0_max(dat0_max),
	 .dat1_max(dat1_max),
	 .dat2_max(dat2_max),
	 .dat3_max(dat3_max),
	 .dat0_max_en(dat0_max_en),
	 .dat1_max_en(dat1_max_en),
	 .dat2_max_en(dat2_max_en),
	 .dat3_max_en(dat3_max_en),
	 
	 .dat0_min(dat0_min),
	 .dat1_min(dat1_min),
	 .dat2_min(dat2_min),
	 .dat3_min(dat3_min),
	 .dat0_min_en(dat0_min_en),
	 .dat1_min_en(dat1_min_en),
	 .dat2_min_en(dat2_min_en),
	 .dat3_min_en(dat3_min_en)
	 );
	 
generate_alarm U2(
    .clk(clk),
	 .rst(rst),
	 .detect_enable(detect_enable),
	 	 
	 .dat0_max(dat0_max),
	 .dat1_max(dat1_max),
	 .dat2_max(dat2_max),
	 .dat3_max(dat3_max),
	 .dat0_max_en(dat0_max_en),
	 .dat1_max_en(dat1_max_en),
	 .dat2_max_en(dat2_max_en),
	 .dat3_max_en(dat3_max_en),
	 
	 .dat0_min(dat0_min),
	 .dat1_min(dat1_min),
	 .dat2_min(dat2_min),
	 .dat3_min(dat3_min),
	 .dat0_min_en(dat0_min_en),
	 .dat1_min_en(dat1_min_en),
	 .dat2_min_en(dat2_min_en),
	 .dat3_min_en(dat3_min_en),
	 
	 .dat0_alarm(Ch0_alarm),
	 .dat1_alarm(Ch1_alarm),
	 .dat2_alarm(Ch2_alarm),
	 .dat3_alarm(Ch3_alarm)

	 );
	 
endmodule