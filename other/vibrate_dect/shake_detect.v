`timescale 1 ns / 1 ns
`define FIR_ON
module shake_detect(
    input clk,clk1,rst,
	 input detect_enable,
	 	 
	 input [15:0]Ch0_Data_ads1,
	 input [15:0]Ch1_Data_ads1,
	 input [15:0]Ch2_Data_ads1,
	 input [15:0]Ch3_Data_ads1,
	 input Ch0_Data_en_ads1,
	 input Ch1_Data_en_ads1,
	 input Ch2_Data_en_ads1,
	 input Ch3_Data_en_ads1,
	 
	 input [15:0]Ch0_Data_ads2,
	 input [15:0]Ch1_Data_ads2,
	 input [15:0]Ch2_Data_ads2,
	 input [15:0]Ch3_Data_ads2,
	 input Ch0_Data_en_ads2,
	 input Ch1_Data_en_ads2,
	 input Ch2_Data_en_ads2,
	 input Ch3_Data_en_ads2,
	 
	 input [15:0]Ch0_Dataf_ads1,
	 input [15:0]Ch1_Dataf_ads1,
	 input [15:0]Ch0_Dataf_ads2,
	 input [15:0]Ch1_Dataf_ads2,
	 
	 input Ch1_Dataf_en_ads2,
	 input Ch0_Dataf_en_ads2,
	 input Ch1_Dataf_en_ads1,
	 input Ch0_Dataf_en_ads1,
	 
	 input Ch1_Dataf_sign_ads2,
	 input Ch0_Dataf_sign_ads2,
	 input Ch1_Dataf_sign_ads1,
	 input Ch0_Dataf_sign_ads1,
	 
	 output wire Ch0_alarm_ads1,
	 output wire Ch1_alarm_ads1,
	 output wire Ch2_alarm_ads1,
	 output wire Ch3_alarm_ads1,
	 output wire Ch0_alarm_ads2,
	 output wire Ch1_alarm_ads2,
	 output wire Ch2_alarm_ads2,
	 output wire Ch3_alarm_ads2
	 );

zero_swing_detect U2(
    .clk(clk),
	 .rst(rst),
	 .detect_enable(detect_enable),
	 
	 .Ch0_Data(Ch0_Dataf_ads1),
	 .Ch1_Data(Ch1_Dataf_ads1),
	 .Ch2_Data(Ch0_Dataf_ads2),
	 .Ch3_Data(Ch1_Dataf_ads2),
	 .Ch0_Data_en(Ch0_Dataf_en_ads1),
	 .Ch1_Data_en(Ch1_Dataf_en_ads1),
	 .Ch2_Data_en(Ch0_Dataf_en_ads2),
	 .Ch3_Data_en(Ch1_Dataf_en_ads2),
	 
	 .Ch0_Data_sign(Ch0_Dataf_sign_ads1),
	 .Ch1_Data_sign(Ch1_Dataf_sign_ads1),
	 .Ch2_Data_sign(Ch0_Dataf_sign_ads2),
	 .Ch3_Data_sign(Ch1_Dataf_sign_ads2),
	 
	 .Ch0_alarm(Ch0_alarm_ads1),
	 .Ch1_alarm(Ch1_alarm_ads1),
	 .Ch2_alarm(Ch0_alarm_ads2),
	 .Ch3_alarm(Ch1_alarm_ads2));
	 
baseline_available_detect U3(
    .clk(clk),
	 .rst(rst),
	 
`ifdef FIR_ON
	 
	 .Ch0_Data(Ch0_Dataf_ads1),
	 .Ch1_Data(Ch1_Dataf_ads1),
	 .Ch2_Data(Ch0_Dataf_ads2),
	 .Ch3_Data(Ch1_Dataf_ads2),
	 .Ch0_Data_en(Ch0_Dataf_en_ads1),
	 .Ch1_Data_en(Ch1_Dataf_en_ads1),
	 .Ch2_Data_en(Ch0_Dataf_en_ads2),
	 .Ch3_Data_en(Ch1_Dataf_en_ads2),

`else
	 
	 .Ch0_Data(Ch0_Data_ads1),
	 .Ch1_Data(Ch1_Data_ads1),
	 .Ch2_Data(Ch0_Data_ads2),
	 .Ch3_Data(Ch1_Data_ads2),
	 .Ch0_Data_en(Ch0_Data_en_ads1),
	 .Ch1_Data_en(Ch1_Data_en_ads1),
	 .Ch2_Data_en(Ch0_Data_en_ads2),
	 .Ch3_Data_en(Ch1_Data_en_ads2),
		
`endif
	 
	 .Ch0_baseline(12'h7ff),
	 .Ch1_baseline(12'h7ff),
	 .Ch2_baseline(12'h7ff),
	 .Ch3_baseline(12'h7ff),
	 
	 .Ch0_alarm(),
	 .Ch1_alarm(),
	 .Ch2_alarm(),
	 .Ch3_alarm());
	 
pass_zero_detect U4(
    .clk(clk),
	 .rst(rst),
	 	 
	 .Ch0_Data_ads1(Ch0_Data_ads1),
	 .Ch1_Data_ads1(Ch1_Data_ads1),
	 .Ch2_Data_ads1(Ch2_Data_ads1),
	 .Ch3_Data_ads1(Ch3_Data_ads1),
	 .Ch0_Data_en_ads1(Ch0_Data_en_ads1),
	 .Ch1_Data_en_ads1(Ch1_Data_en_ads1),
	 .Ch2_Data_en_ads1(Ch2_Data_en_ads1),
	 .Ch3_Data_en_ads1(Ch3_Data_en_ads1),
	 
	 .Ch0_alarm_ads1(),
	 .Ch1_alarm_ads1(),
	 .Ch2_alarm_ads1(),
	 .Ch3_alarm_ads1(),
	 
	 .Ch0_Data_ads2(Ch0_Data_ads2),
	 .Ch1_Data_ads2(Ch1_Data_ads2),
	 .Ch2_Data_ads2(Ch2_Data_ads2),
	 .Ch3_Data_ads2(Ch3_Data_ads2),
	 .Ch0_Data_en_ads2(Ch0_Data_en_ads2),
	 .Ch1_Data_en_ads2(Ch1_Data_en_ads2),
	 .Ch2_Data_en_ads2(Ch2_Data_en_ads2),
	 .Ch3_Data_en_ads2(Ch3_Data_en_ads2),
	 
	 .Ch0_alarm_ads2(),
	 .Ch1_alarm_ads2(),
	 .Ch2_alarm_ads2(),
	 .Ch3_alarm_ads2());	 
	 
search_peak_detect U5(
     .clk(clk),
	  .rst(rst),
	 	
	  .Ch0_Data_ads1(),
	  .Ch1_Data_ads1(),
	  .Ch2_Data_ads1(),
	  .Ch3_Data_ads1(),
	  .Ch0_Data_en_ads1(),
	  .Ch1_Data_en_ads1(),
	  .Ch2_Data_en_ads1(),
	  .Ch3_Data_en_ads1(),
	 
	  .Ch0_alarm_ads1(),
	  .Ch1_alarm_ads1(),
	  .Ch2_alarm_ads1(),
	  .Ch3_alarm_ads1(),
	 
	  .Ch0_Data_ads2(Ch0_Data_ads2),
	  .Ch1_Data_ads2(),
	  .Ch2_Data_ads2(),
	  .Ch3_Data_ads2(),
	  .Ch0_Data_en_ads2(Ch0_Data_en_ads2),
	  .Ch1_Data_en_ads2(),
	  .Ch2_Data_en_ads2(),
	  .Ch3_Data_en_ads2(),
	 
	  .Ch0_alarm_ads2(),
	  .Ch1_alarm_ads2(),
	  .Ch2_alarm_ads2(),
	  .Ch3_alarm_ads2());
		
endmodule