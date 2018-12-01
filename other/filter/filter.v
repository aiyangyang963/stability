module filter(
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
	 output wire Ch0_Dataf_sign_ads1,
	 
	 input [11:0]signal_nco,
	 input [11:0]signal_out_6Hz_decimate,signal_out_15Hz_decimate,signal_out_mix_decimate,
	 input signal_6Hz_enable_decimate,signal_15Hz_enable_decimate,signal_mix_enable_decimate,
	 input signal_enable,
	 input sample_clk
	 
    );
	 
filter_outersignal filter_ads(
	  .rst(rst),
	  .clk(clk),  //50M	
	  .clk1(clk1),//400M
	  
	  .Data_template(Data_template),
	  .Data_template_en(Data_template_en),
	  
	  .Ori_Ch0_Dataf_ads1(Ori_Ch0_Dataf_ads1),
     .Ori_Ch1_Dataf_ads1(Ori_Ch1_Dataf_ads1),
     .Ori_Ch0_Dataf_ads2(Ori_Ch0_Dataf_ads2),
     .Ori_Ch1_Dataf_ads2(Ori_Ch1_Dataf_ads2),
	 
	  .Ori_Ch1_Dataf_en_ads2(Ori_Ch1_Dataf_en_ads2),
     .Ori_Ch0_Dataf_en_ads2(Ori_Ch0_Dataf_en_ads2),
     .Ori_Ch1_Dataf_en_ads1(Ori_Ch1_Dataf_en_ads1),
     .Ori_Ch0_Dataf_en_ads1(Ori_Ch0_Dataf_en_ads1),
	 
	  .Ch0_Data_ads1(Ch0_Data_ads1),
	  .Ch1_Data_ads1(Ch1_Data_ads1),
	  .Ch0_Data_ads2(Ch0_Data_ads2),
	  .Ch1_Data_ads2(Ch1_Data_ads2),
	  
	  .Ch1_Data_en_ads2(Ch1_Data_en_ads2),
	  .Ch0_Data_en_ads2(Ch0_Data_en_ads2),
	  .Ch1_Data_en_ads1(Ch1_Data_en_ads1),
	  .Ch0_Data_en_ads1(Ch0_Data_en_ads1),
	 
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
	  
filter_intersignal filter_nco(
	  .rst(rst),
	  .clk1(clk1),//50M
	 
	  .signal_nco(signal_nco),
	  .signal_out_6Hz_decimate(signal_out_6Hz_decimate),
	  .signal_out_15Hz_decimate(signal_out_15Hz_decimate),
	  .signal_out_mix_decimate(signal_out_mix_decimate),
	  .signal_enable_decimate(signal_mix_enable_decimate),
	  
	  .sample_clk(sample_clk));
	 
endmodule