`timescale 1ns / 1ns
module search_peak_detect(
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

wire[15:0]Ch0_PData_ads2;
wire Ch0_PData_en_ads2;
wire[15:0]Ch0_VData_ads2;
wire Ch0_VData_en_ads2;


defparam peak_detect_ads.DATAWIDTH=16;	 
peak_detect peak_detect_ads(
	.clk(clk),
	.rst(rst),
	 	 
	.Data0(Ch0_Data_ads2),
	.Data1(),
	.Data2(),
	.Data3(),
	.Data0_en(Ch0_Data_en_ads2),
	.Data1_en(),
	.Data2_en(),
	.Data3_en(),
	
	.PData0(Ch0_PData_ads2),
	.PData0_en(Ch0_PData_en_ads2),
	.VData0(Ch0_VData_ads2),
	.VData0_en(Ch0_VData_en_ads2));

peak_alarm peak_alarm(
	.clk(clk),
	.rst(rst),
	
	.Ch0_PData_ads2(Ch0_PData_ads2),
	.Ch0_PData_en_ads2(Ch0_PData_en_ads2),
	.Ch0_VData_ads2(Ch0_VData_ads2),
	.Ch0_VData_en_ads2(Ch0_VData_en_ads2),
	
	.Ch0_alarm_ads2(Ch0_alarm_ads2));
	 
endmodule