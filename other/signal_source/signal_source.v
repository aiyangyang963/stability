`timescale 1ns / 1ns
`define USE_NCO_SIGNAL

module signal_source(
	 input rst,clk_50m,clk_500K,clk_ads,
	 
    output wire  cs_ads1,sclk_ads1,sdo_ads1,
	 output wire  cs_ads2,sclk_ads2,sdo_ads2,
	 input sdi_ads1,sdi_ads2,
	 
	 output wire [15:0]Ch0_Data,
	 output wire [15:0]Ch1_Data,
	 output wire [15:0]Ch2_Data,
	 output wire [15:0]Ch3_Data,
	 
	 
	 output wire Ch0_Data_en,
	 output wire Ch1_Data_en,
	 output wire Ch2_Data_en,
	 output wire Ch3_Data_en,
	 
	 output wire [15:0]Data_template,
	 output wire Data_template_en
    );
	 
wire [15:0]Ch0_Data_ads;
wire [15:0]Ch1_Data_ads;
wire [15:0]Ch2_Data_ads;
wire [15:0]Ch3_Data_ads;
wire Ch0_Data_en_ads;
wire Ch1_Data_en_ads;
wire Ch2_Data_en_ads;
wire Ch3_Data_en_ads;

`ifdef USE_NCO_SIGNAL
assign Ch0_Data=((Ch0_Data_nco)/Ch0_Data_ABS_div);
assign Ch1_Data=((Ch1_Data_nco)/Ch1_Data_ABS_div);
assign Ch2_Data=((Ch2_Data_nco)/Ch2_Data_ABS_div);
assign Ch3_Data=((Ch3_Data_nco)/Ch3_Data_ABS_div);

assign Ch0_Data_en=Ch0_Data_en_nco;
assign Ch1_Data_en=Ch1_Data_en_nco;
assign Ch2_Data_en=Ch2_Data_en_nco;
assign Ch3_Data_en=Ch3_Data_en_nco;
`else
assign Ch0_Data=Ch0_Data_ads;
assign Ch1_Data=Ch1_Data_ads;
assign Ch2_Data=Ch2_Data_ads;
assign Ch3_Data=Ch3_Data_ads;

assign Ch0_Data_en=Ch0_Data_en_ads;
assign Ch1_Data_en=Ch1_Data_en_ads;
assign Ch2_Data_en=Ch2_Data_en_ads;
assign Ch3_Data_en=Ch3_Data_en_ads;
`endif
	 
ads_top U1(
	 .rst(rst),
	 .clk(clk_50m),
	 .clk_ads(clk_ads),
	 
    .cs_ads1(cs_ads1),
	 .sclk_ads1(sclk_ads1),
	 .sdo_ads1(sdo_ads1),
	 .cs_ads2(cs_ads2),
	 .sclk_ads2(sclk_ads2),
	 .sdo_ads2(sdo_ads2),
	 
	 .sdi_ads1(sdi_ads1),
	 .sdi_ads2(sdi_ads2),
	 

	 .Ch0_Data_ads1(Ch0_Data_ads),
	 .Ch1_Data_ads1(Ch1_Data_ads),	 	 
	 .Ch2_Data_ads1(),
	 .Ch3_Data_ads1(),
	 
	 .Ch0_Data_ads2(Ch2_Data_ads),
	 .Ch1_Data_ads2(Ch3_Data_ads),
	 .Ch2_Data_ads2(),
	 .Ch3_Data_ads2(),
	 
	 .Ch0_Data_en_ads1(Ch0_Data_en_ads),
	 .Ch1_Data_en_ads1(Ch1_Data_en_ads),
	 .Ch2_Data_en_ads1(),
	 .Ch3_Data_en_ads1(),
	 
	 .Ch0_Data_en_ads2(Ch2_Data_en_ads),
	 .Ch1_Data_en_ads2(Ch3_Data_en_ads),
	 .Ch2_Data_en_ads2(),
	 .Ch3_Data_en_ads2()
    );	

wire [15:0]Ch0_Data_nco;
wire [15:0]Ch1_Data_nco;
wire [15:0]Ch2_Data_nco;
wire [15:0]Ch3_Data_nco;
wire Ch0_Data_en_nco;
wire Ch1_Data_en_nco;
wire Ch2_Data_en_nco;
wire Ch3_Data_en_nco;
assign Data_template=Ch1_Data_nco;
assign Data_template_en=Ch1_Data_en_nco;

signal_produce U2(
	.rst(rst),
	.clk(clk_50m),
	.clk_500K(clk_500K),
	  
	.dat_ch0_ads1_sim(),//1Hz
	.dat_ch1_ads1_sim(),//8Hz
	.dat_ch0_ads2_sim(),//4Hz
	.dat_ch1_ads2_sim(),//15Hz
	.enable_ch0_ads1_sim(),									 
	.enable_ch1_ads1_sim(),	
	.enable_ch0_ads2_sim(),
	.enable_ch1_ads2_sim(),
	
	.dat_ch0_ads1_sim_decim(Ch0_Data_nco[15:4]),//1Hz
	.dat_ch1_ads1_sim_decim(Ch1_Data_nco[15:4]),//8Hz
	.dat_ch0_ads2_sim_decim(Ch2_Data_nco[15:4]),//4Hz
	.dat_ch1_ads2_sim_decim(Ch3_Data_nco[15:4]),//15Hz
	.enable_ch0_ads1_sim_decim(Ch0_Data_en_nco),									 
	.enable_ch1_ads1_sim_decim(Ch1_Data_en_nco),	
	.enable_ch0_ads2_sim_decim(Ch2_Data_en_nco),
	.enable_ch1_ads2_sim_decim(Ch3_Data_en_nco),
 
	.signal_out_8Hz_s(),
	.signal_out_15Hz_s(),
	.signal_out_1Hz_s(),
	.signal_out_4Hz(),
	.signal_out_mix_s(),
	
	.signal_out_8Hz_decimate (),
	.signal_out_15Hz_decimate(),
	.signal_out_1Hz_decimate (),
	.signal_out_mix_decimate (),
	
	.signal_enable(),
	.signal_8Hz_enable_decimate (),
	.signal_15Hz_enable_decimate(),
	.signal_1Hz_enable_decimate (),
	.signal_mix_enable_decimate (),
	
	.sample_clk()
	 );
	 
(* syn_preserve = 1 *)wire [15:0]Data_ABS0,Data_ABS1,Data_ABS2,Data_ABS3;	 
(* syn_preserve = 1 *)wire [15:0]Ch0_Data_ABS_div=Data_ABS0;
(* syn_preserve = 1 *)wire [15:0]Ch1_Data_ABS_div=Data_ABS1;
(* syn_preserve = 1 *)wire [15:0]Ch2_Data_ABS_div=Data_ABS2;
(* syn_preserve = 1 *)wire [15:0]Ch3_Data_ABS_div=Data_ABS3;

issp_dat_abs issp_dat_abs0 (
	.source(Data_ABS0),
	.source_ena(1),
	.source_clk(clk_50m));	

issp_dat_abs issp_dat_abs1 (
	.source(Data_ABS1),
	.source_ena(1),
	.source_clk(clk_50m));	
	 
issp_dat_abs issp_dat_abs2 (
	.source(Data_ABS2),
	.source_ena(1),
	.source_clk(clk_50m));	

issp_dat_abs issp_dat_abs3 (
	.source(Data_ABS3),
	.source_ena(1),
	.source_clk(clk_50m));

endmodule