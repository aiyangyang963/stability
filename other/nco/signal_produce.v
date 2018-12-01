`timescale 1ns / 1ns

module signal_produce(
	 input rst,
	 input clk,
	 input clk_500K,
	 
	 output reg[SIGNALWIDTH-1:0]dat_ch0_ads1_sim,//1Hz
										 dat_ch1_ads1_sim,//4Hz
										 dat_ch0_ads2_sim,//8Hz
										 dat_ch1_ads2_sim,//15Hz
	 output wire enable_ch0_ads1_sim,									 
	 output wire enable_ch1_ads1_sim,	
    output wire enable_ch0_ads2_sim,
    output wire enable_ch1_ads2_sim,
	 
	 output wire[SIGNALWIDTH-1:0]dat_ch0_ads1_sim_decim,//1Hz
										 dat_ch1_ads1_sim_decim,//4Hz
										 dat_ch0_ads2_sim_decim,//8Hz
										 dat_ch1_ads2_sim_decim,//15Hz
	 output wire enable_ch0_ads1_sim_decim,									 
	 output wire enable_ch1_ads1_sim_decim,	
    output wire enable_ch0_ads2_sim_decim,
    output wire enable_ch1_ads2_sim_decim,
										 
	 output wire[SIGNALWIDTH-1:0]signal_out_8Hz_decimate,
										 signal_out_15Hz_decimate,
										 signal_out_1Hz_decimate,
										 signal_out_mix_decimate,
	 output wire signal_enable,
					 signal_8Hz_enable_decimate,
					 signal_15Hz_enable_decimate,
					 signal_1Hz_enable_decimate,
					 signal_mix_enable_decimate,
	 output reg sample_clk
	 
    );
	 
parameter SIGNALWIDTH=12;
//------------------simulate ads signal-------------------
always@(posedge clk_500K)
	begin
		if(rst)
			begin
				dat_ch0_ads1_sim<=0;
			   dat_ch1_ads1_sim<=0;
			   dat_ch0_ads2_sim<=0;
			   dat_ch1_ads2_sim<=0;
			end
		else 
			begin
				if(~sample_clk)
					begin
						dat_ch0_ads1_sim<=signal_out_8Hz;
						dat_ch0_ads2_sim<=signal_out_8Hz;
						dat_ch1_ads1_sim<=dat_ch1_ads1_sim;
						dat_ch1_ads2_sim<=dat_ch1_ads2_sim;
					end
				else
					begin
						dat_ch1_ads1_sim<=signal_out_4Hz;
						dat_ch1_ads2_sim<=signal_out_4Hz;
						dat_ch0_ads1_sim<=dat_ch0_ads1_sim;
						dat_ch0_ads2_sim<=dat_ch0_ads2_sim;
					end
			end
	end
assign enable_ch0_ads1_sim = clk_500K & sample_clk;
assign enable_ch0_ads2_sim = clk_500K & sample_clk;

assign enable_ch1_ads1_sim = clk_500K & (~sample_clk);
assign enable_ch1_ads2_sim = clk_500K & (~sample_clk);

//-------------------------clock--------------------------	
always@(posedge clk_500K)
	begin
		if(rst)sample_clk<=0;
		else sample_clk<=~sample_clk;
	end	
	
wire pos_clk_500K,neg_clk_500K;
reg clk_500K_r0,clk_500K_r1,clk_500K_r2;
always@(posedge clk)
	begin
		clk_500K_r0<=clk_500K;
		clk_500K_r1<=clk_500K_r0;
		clk_500K_r2<=clk_500K_r1;
	end
assign pos_clk_500K=(~clk_500K_r2)&clk_500K_r1;
assign neg_clk_500K=clk_500K_r2&(~clk_500K_r1);  
assign signal_enable=clk_500K;

//----------------------sign express------------------------
wire[SIGNALWIDTH-1:0]signal_out_1Hz,signal_out_2Hz,signal_out_4Hz,signal_out_6Hz,signal_out_8Hz,signal_out_15Hz,signal_out_mix;	
wire	f_1Hz_out_valid,f_2Hz_out_valid,f_4Hz_out_valid,f_6Hz_out_valid,f_8Hz_out_valid,f_15Hz_out_valid;							 
(* syn_preserve = 1 *)reg [11:0]f_1Hz_sin_o,f_2Hz_sin_o,f_4Hz_sin_o,f_6Hz_sin_o,f_8Hz_sin_o,f_15Hz_sin_o,f_20Hz_sin_o;


signal_band_externalL signal_1Hz(
	.clk(clk_500K),
	.reset_n(~rst),
	.clken(1),
	.phi_inc_i(8590),//1Hz
//.phi_inc_i(858993),//100Hz
	.fsin_o(f_1Hz_sin_o),
	.fcos_o(),
	.out_valid(f_1Hz_out_valid));	

signal_move signal_move_1Hz(
	 .clk(clk_500K),
	 
    .sigin(f_1Hz_sin_o),
	 .sigout(signal_out_1Hz)
	 
    );

signal_band_internalL signal_4Hz(
	.clk(clk_500K),
	.reset_n(~rst),
	.clken(1),
	.phi_inc_i(34360),//4Hz
//.phi_inc_i(3435974),//400Hz
	.fsin_o(f_4Hz_sin_o),
	.fcos_o(),
	.out_valid(f_4Hz_out_valid));	
	
signal_move signal_move_4Hz(
	 .clk(clk_500K),
	 
    .sigin(f_4Hz_sin_o),
	 .sigout(signal_out_4Hz)
	 
    );
	
signal_band_internal signal_8Hz(
	.clk(clk_500K),
	.reset_n(~rst),
	.clken(1),
	.phi_inc_i(68719),//8Hz
//.phi_inc_i(6871948),//800Hz
	.fsin_o(f_8Hz_sin_o),
	.fcos_o(),
	.out_valid(f_8Hz_out_valid));	
	
signal_move signal_move_8Hz(
	 .clk(clk_500K),
	 
    .sigin(f_8Hz_sin_o),
	 .sigout(signal_out_8Hz)
	 
    );

signal_band_external signal_15Hz(
	.clk(clk_500K),
	.reset_n(~rst),
	.clken(1),
	.phi_inc_i(128849),//15Hz
//.phi_inc_i(12884902),//1500Hz
	.fsin_o(f_15Hz_sin_o),
	.fcos_o(),
	.out_valid(f_15Hz_out_valid));	
	
signal_move signal_move_15Hz(
	 .clk(clk_500K),
	 
    .sigin(f_15Hz_sin_o),
	 .sigout(signal_out_15Hz)
	 
    );	
	
dat_decimate U1(
    .clk(clk),
	 .rst(rst),
	 
	 .Data0_in(dat_ch0_ads1_sim),
	 .Data1_in(dat_ch1_ads1_sim),
	 .Data2_in(dat_ch0_ads2_sim),
	 .Data3_in(dat_ch1_ads2_sim),
	 
	 .Data0_in_en(enable_ch0_ads1_sim),
	 .Data1_in_en(enable_ch1_ads1_sim),
	 .Data2_in_en(enable_ch0_ads2_sim),
	 .Data3_in_en(enable_ch1_ads2_sim),
	  
	 .Data0_out(dat_ch0_ads1_sim_decim),
	 .Data1_out(dat_ch1_ads1_sim_decim),
	 .Data2_out(dat_ch0_ads2_sim_decim),
	 .Data3_out(dat_ch1_ads2_sim_decim),
	 
	 .Data0_out_en(enable_ch0_ads1_sim_decim),
	 .Data1_out_en(enable_ch1_ads1_sim_decim),
	 .Data2_out_en(enable_ch0_ads2_sim_decim),
	 .Data3_out_en(enable_ch1_ads2_sim_decim)
	 );
	 
dat_decimate U2(
    .clk(clk),
	 .rst(rst),
	 
	 .Data0_in(signal_out_8Hz),
	 .Data1_in(signal_out_15Hz),
	 .Data2_in(signal_out_1Hz),
	 .Data3_in(signal_out_mix),
	 
	 .Data0_in_en(signal_enable),
	 .Data1_in_en(signal_enable),
	 .Data2_in_en(signal_enable),
	 .Data3_in_en(signal_enable),
	  
	 .Data0_out(signal_out_8Hz_decimate),
	 .Data1_out(signal_out_15Hz_decimate),
	 .Data2_out(signal_out_1Hz_decimate),
	 .Data3_out(signal_out_mix_decimate),
	 
	 .Data0_out_en(signal_8Hz_enable_decimate),
	 .Data1_out_en(signal_15Hz_enable_decimate),
	 .Data2_out_en(signal_1Hz_enable_decimate),
	 .Data3_out_en(signal_mix_enable_decimate)
	 );
	
endmodule