module signal_process(
	input rst,
	input clk,	//50M
	input clk1,//400M
	
	input [15:0]Data_template,
	input Data_template_en,
	
	input [15:0]Ch0_Data_ads1,
	input [15:0]Ch1_Data_ads1,
	input [15:0]Ch0_Data_ads2,
	input [15:0]Ch1_Data_ads2,
	
	input Ch1_Data_en_ads2,
	input Ch0_Data_en_ads2,
	input Ch1_Data_en_ads1,
	input Ch0_Data_en_ads1,
	
	output wire[15:0]Ori_Ch0_Dataf_ads1,
	output wire[15:0]Ori_Ch1_Dataf_ads1,
	output wire[15:0]Ori_Ch0_Dataf_ads2,
	output wire[15:0]Ori_Ch1_Dataf_ads2,
	
	output wire Ori_Ch1_Dataf_en_ads2,
	output wire Ori_Ch0_Dataf_en_ads2,
	output wire Ori_Ch1_Dataf_en_ads1,
	output wire Ori_Ch0_Dataf_en_ads1,

	output [15:0]Ch0_Dataf_ads1,
	output [15:0]Ch1_Dataf_ads1,
	output [15:0]Ch0_Dataf_ads2,
	output [15:0]Ch1_Dataf_ads2,
	
	output Ch1_Dataf_en_ads2,
	output Ch0_Dataf_en_ads2,
	output Ch1_Dataf_en_ads1,
	output Ch0_Dataf_en_ads1,
	 
	output wire Ch1_Dataf_sign_ads2,
	output wire Ch0_Dataf_sign_ads2,
	output wire Ch1_Dataf_sign_ads1,
	output wire Ch0_Dataf_sign_ads1);
	
 filter U1(
	.rst(rst),
	.clk(clk),	//50M
	.clk1(clk1),//400M
	
	.Data_template(Data_template),
	.Data_template_en(Data_template_en),
	
	.Ch0_Data_ads1(Ch0_Data_ads1),
	.Ch1_Data_ads1(Ch1_Data_ads1),
	.Ch0_Data_ads2(Ch0_Data_ads2),
	.Ch1_Data_ads2(Ch1_Data_ads2),
	
	.Ch1_Data_en_ads2(Ch1_Data_en_ads2),
	.Ch0_Data_en_ads2(Ch0_Data_en_ads2),
	.Ch1_Data_en_ads1(Ch1_Data_en_ads1),
	.Ch0_Data_en_ads1(Ch0_Data_en_ads1),
	
	.Ori_Ch0_Dataf_ads1(Ori_Ch0_Dataf_ads1),
	.Ori_Ch1_Dataf_ads1(Ori_Ch1_Dataf_ads1),
	.Ori_Ch0_Dataf_ads2(Ori_Ch0_Dataf_ads2),
	.Ori_Ch1_Dataf_ads2(Ori_Ch1_Dataf_ads2),
	
	.Ori_Ch1_Dataf_en_ads2(Ori_Ch1_Dataf_en_ads2),
	.Ori_Ch0_Dataf_en_ads2(Ori_Ch0_Dataf_en_ads2),
	.Ori_Ch1_Dataf_en_ads1(Ori_Ch1_Dataf_en_ads1),
	.Ori_Ch0_Dataf_en_ads1(Ori_Ch0_Dataf_en_ads1),

	.Ch0_Dataf_ads1(Ch0_Dataf_ads1),
	.Ch1_Dataf_ads1(Ch1_Dataf_ads1),
	.Ch0_Dataf_ads2(Ch0_Dataf_ads2),
	.Ch1_Dataf_ads2(Ch1_Dataf_ads2),
	
	.Ch1_Dataf_en_ads2(Ch1_Dataf_en_ads2),
	.Ch0_Dataf_en_ads2(Ch0_Dataf_en_ads2),
	.Ch1_Dataf_en_ads1(Ch1_Dataf_en_ads1),
	.Ch0_Dataf_en_ads1(Ch0_Dataf_en_ads1),
	
	.Ch1_Dataf_sign_ads2(Ch1_Dataf_sign_ads2),
	.Ch0_Dataf_sign_ads2(Ch0_Dataf_sign_ads2),
	.Ch1_Dataf_sign_ads1(Ch1_Dataf_sign_ads1),
	.Ch0_Dataf_sign_ads1(Ch0_Dataf_sign_ads1));
	
endmodule