`timescale 1ns / 1ns

module fft_ads(
	 input rst,
	 input clk,
	 output rst_out,
	 
	 input [11:0]Ch0_Data_ads1,
	 input [11:0]Ch1_Data_ads1,
	 input [11:0]Ch0_Data_ads2,
	 input [11:0]Ch1_Data_ads2,
	 
	 input Ch1_Data_en_ads2,
	 input Ch0_Data_en_ads2,
	 input Ch1_Data_en_ads1,
	 input Ch0_Data_en_ads1
	 
    );
	 
	 
	wire		ch0_ads2_clk;
	wire		ch0_ads2_reset_n;
	wire		ch0_ads2_sink_valid;
	wire		ch0_ads2_sink_ready;
	wire	[1:0]	sink_error=0;
	wire		ch0_ads2_sink_sop;
	wire		ch0_ads2_sink_eop;
	wire	[11:0]ch0_ads2_sink_real;
   wire	[11:0]ch0_ads2_sink_imag;
	wire	[10:0]ch0_ads2_fftpts_in=10000000000;//1024
	wire	[0:0]ch0_ads2_inverse=0;
	wire		ch0_ads2_source_valid;
	wire		ch0_ads2_source_ready;
	wire	[1:0]ch0_ads2_source_error;
	wire		ch0_ads2_source_sop;
	wire		ch0_ads2_source_eop;
	wire	[11:0]ch0_ads2_source_real;
	wire	[11:0]ch0_ads2_source_imag;
	wire	[10:0]ch0_ads2_fftpts_out;	 
	
fft_control fft_control(
	.clk(clk),
	.rst(rst),
	
	.Ch0_Data_ads2(Ch0_Data_ads2),
	.Ch0_Data_en_ads2(Ch0_Data_en_ads2),
	
	.ch0_ads2_clk(ch0_ads2_clk),
	.ch0_ads2_reset_n(ch0_ads2_reset_n),
	.ch0_ads2_sink_valid(ch0_ads2_sink_valid),
	.ch0_ads2_sink_ready(ch0_ads2_sink_ready),
	.ch0_ads2_sink_sop(ch0_ads2_sink_sop),
	.ch0_ads2_sink_eop(ch0_ads2_sink_eop),
	.ch0_ads2_sink_real(ch0_ads2_sink_real),
	.ch0_ads2_sink_imag(ch0_ads2_sink_imag));
	
fft fft_ch0_ads2 (
	.clk(clk),
	.reset_n(ch0_ads2_reset_n),
	.sink_valid(ch0_ads2_sink_valid),
	.sink_ready(ch0_ads2_sink_ready),
	.sink_error(sink_error),
	.sink_sop(ch0_ads2_sink_sop),
	.sink_eop(ch0_ads2_sink_eop),
	.sink_real(ch0_ads2_sink_real),
	.sink_imag(0),
//	.fftpts_in(ch0_ads2_fftpts_in),
	.inverse(ch0_ads2_inverse),
	.source_valid(ch0_ads2_source_valid),
	.source_ready(1),
	.source_error(),
	.source_sop(),
	.source_eop(),
	.source_real(),
	.source_imag());	

endmodule
