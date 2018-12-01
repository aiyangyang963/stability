`timescale 1ns / 1ns
module signal_detect(
    input clk,clk1,rst,
	 	 
	 input [07:0]control_infor,//from k64 control information	
		 
	 input [15:0]Ch0_Data,
	 input [15:0]Ch1_Data,
	 input [15:0]Ch2_Data,
	 input [15:0]Ch3_Data,
	 input Ch0_Data_en,
	 input Ch1_Data_en,
	 input Ch2_Data_en,
	 input Ch3_Data_en,
	 
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
	 
	 output wire Ch0_alarm,
	 output wire Ch1_alarm,
	 output wire Ch2_alarm,
	 output wire Ch3_alarm,
	 
	 output wire Ch0_disconnect,
	 output wire Ch1_disconnect,
	 output wire Ch2_disconnect,
	 output wire Ch3_disconnect,
	 
	 output wire Ch0_trouble,
	 output wire Ch1_trouble,
	 output wire Ch2_trouble,
	 output wire Ch3_trouble,
	 output wire trouble_detect_over,
	 
	 output wire incident_inform,
	 output wire[7:0]incident_b0,
	 output wire[7:0]incident_b1,
	 output wire[7:0]incident_b2,
	 output wire[7:0]incident_b3
	 
	 );
	 
shake_detect U1(
    .clk(clk),
	 .clk1(clk1),
	 .rst(rst),
	 	 
	 .detect_enable(1),	 
	 .Ch0_Data_ads1(Ch0_Data),
	 .Ch1_Data_ads1(Ch1_Data),
	 .Ch2_Data_ads1(),
	 .Ch3_Data_ads1(),
	 .Ch0_Data_en_ads1(Ch0_Data_en),
	 .Ch1_Data_en_ads1(Ch1_Data_en),
	 .Ch2_Data_en_ads1(),
	 .Ch3_Data_en_ads1(),
	 
	 .Ch0_Data_ads2(Ch2_Data),
	 .Ch1_Data_ads2(Ch3_Data),
	 .Ch2_Data_ads2(),
	 .Ch3_Data_ads2(),
	 .Ch0_Data_en_ads2(Ch2_Data_en),
	 .Ch1_Data_en_ads2(Ch3_Data_en),
	 .Ch2_Data_en_ads2(),
	 .Ch3_Data_en_ads2(),
	 
	 .Ch0_Dataf_ads1(Ch0_Dataf_ads1),
	 .Ch1_Dataf_ads1(Ch1_Dataf_ads1),
	 .Ch0_Dataf_ads2(Ch0_Dataf_ads2),
	 .Ch1_Dataf_ads2(Ch1_Dataf_ads2),

	 .Ch0_Dataf_en_ads1(Ch0_Dataf_en_ads1),
	 .Ch1_Dataf_en_ads1(Ch1_Dataf_en_ads1),
	 .Ch0_Dataf_en_ads2(Ch0_Dataf_en_ads2),
	 .Ch1_Dataf_en_ads2(Ch1_Dataf_en_ads2),
	 
	 .Ch0_Dataf_sign_ads1(Ch0_Dataf_sign_ads1),
	 .Ch1_Dataf_sign_ads1(Ch1_Dataf_sign_ads1),
	 .Ch0_Dataf_sign_ads2(Ch0_Dataf_sign_ads2),
	 .Ch1_Dataf_sign_ads2(Ch1_Dataf_sign_ads2),
	 
	 .Ch0_alarm_ads1(Ch0_alarm),
	 .Ch1_alarm_ads1(Ch1_alarm),
	 .Ch2_alarm_ads1(),
	 .Ch3_alarm_ads1(),
	 .Ch0_alarm_ads2(Ch2_alarm),
	 .Ch1_alarm_ads2(Ch3_alarm),
	 .Ch2_alarm_ads2(),
	 .Ch3_alarm_ads2());
	 
disconnect_detect U2(
    .clk(clk),
	 .rst(rst),
	 	 
	 .Ch0_Data(Ch0_Data),
	 .Ch1_Data(Ch1_Data),
	 .Ch2_Data(Ch2_Data),
	 .Ch3_Data(Ch3_Data),
	 .Ch0_Data_en(Ch0_Data_en),
	 .Ch1_Data_en(Ch1_Data_en),
	 .Ch2_Data_en(Ch2_Data_en),
	 .Ch3_Data_en(Ch3_Data_en),
	 
	 .Ch0_disconnect(Ch0_disconnect),
	 .Ch1_disconnect(Ch1_disconnect),
	 .Ch2_disconnect(Ch2_disconnect),
	 .Ch3_disconnect(Ch3_disconnect)
	 );
	
trouble_detect U3(
    .clk(clk),
	 .rst(rst),
	 
	 .Ch0_detect_en(control_infor[2]),
	 .Ch1_detect_en(control_infor[2]),
	 .Ch2_detect_en(control_infor[2]),
	 .Ch3_detect_en(control_infor[2]),
	 	 
	 .Ch0_Data(Ch0_Data),
	 .Ch1_Data(Ch1_Data),
	 .Ch2_Data(Ch2_Data),
	 .Ch3_Data(Ch3_Data),
	 .Ch0_Data_en(Ch0_Data_en),
	 .Ch1_Data_en(Ch1_Data_en),
	 .Ch2_Data_en(Ch2_Data_en),
	 .Ch3_Data_en(Ch3_Data_en),
	 
	 .Ch0_trouble(Ch0_trouble),
	 .Ch1_trouble(Ch1_trouble),
	 .Ch2_trouble(Ch2_trouble),
	 .Ch3_trouble(Ch3_trouble),
	 
	 .trouble_detect_over(trouble_detect_over)
	 );
	 
incident_process U4(
    .clk(clk),
	 .rst(rst),
	 
	 .Ch0_alarm(Ch0_alarm),
	 .Ch1_alarm(Ch1_alarm),
	 .Ch2_alarm(Ch2_alarm),
	 .Ch3_alarm(Ch3_alarm),
	 
	 .Ch0_disconnect(Ch0_disconnect),
	 .Ch1_disconnect(Ch1_disconnect),
	 .Ch2_disconnect(Ch2_disconnect),
	 .Ch3_disconnect(Ch3_disconnect),
	 
	 .Ch0_trouble(Ch0_trouble),
	 .Ch1_trouble(Ch1_trouble),
	 .Ch2_trouble(Ch2_trouble),
	 .Ch3_trouble(Ch3_trouble),
	 .trouble_detect_over(trouble_detect_over),
	 
	 .incident_inform(incident_inform),
	 .incident_b0(incident_b0),
	 .incident_b1(incident_b1),
	 .incident_b2(incident_b2),
	 .incident_b3(incident_b3));
	 
//(* syn_preserve = 1 *)wire [3:0]troub_det_ena;	 
//trouble_detect_enable trouble_detect_enable (
//	.source(trouble_detect_enable),
//	.source_ena(1),
//	.source_clk(clk));	
	 
endmodule