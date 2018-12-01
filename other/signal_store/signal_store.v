`timescale 1ns / 1ps
module signal_store(
	input clk,rst,
//ddr memorey interface	 
	output wire [13:0]mem_a,         //memory.mem_a
	output wire [2:0] mem_ba,        //.mem_ba
	output wire [0:0] mem_ck,        //.mem_ck
	output wire [0:0]	mem_ck_n,      //.mem_ck_n
	output wire mem_cke,             //.mem_cke
	output wire mem_cs_n,            //.mem_cs_n
	output wire [1:0] mem_dm,        //.mem_dm
	output wire mem_ras_n,           //.mem_ras_n
	output wire mem_cas_n,           //.mem_cas_n
	output wire mem_we_n,            //.mem_we_n
	output wire mem_reset_n,         //.mem_reset_n
	inout  wire [15:0]mem_dq,        //.mem_dq
	inout  wire [1:0] mem_dqs,       //.mem_dqs
	inout  wire [1:0] mem_dqs_n,     //.mem_dqs_n
	output wire mem_odt,             //.mem_odt
	input  wire oct_rzqin,           //oct.rzqin
	output wire local_init_done,
//data in 
	input [7:0]ds_MsecondsL,		
	input [7:0]ds_MsecondsH,
	input [7:0]ds_Seconds,
	input [7:0]ds_Minutes,
	input [7:0]ds_Hour,
	input [7:0]ds_Date,
	input [7:0]ds_Month,
	input [7:0]ds_Year,
	
	input [15:0]Ch0_Dataf_ads1,
	input [15:0]Ch1_Dataf_ads1,
	input [15:0]Ch0_Dataf_ads2,
	input [15:0]Ch1_Dataf_ads2,
	 
	input Ch1_Dataf_en_ads2,
	input Ch0_Dataf_en_ads2,
	input Ch1_Dataf_en_ads1,
	input Ch0_Dataf_en_ads1,
//data to flexbus	
	output wire afi_clk,
	input ddrL_RdStar,
	input ddrH_RdStar,
	output wire [63:00]ddr_dat_timing,
	output wire ddr_timing_en,
	output wire [63:00]ddr_dat,
	output wire ddr_dat_en,
	output wire ddrL_read_switch,
	output wire ddrH_read_switch,
//data out 
//	output wire[7:0]ddr_MsecondsL,		
//	output wire[7:0]ddr_MsecondsH,
//	output wire[7:0]ddr_Seconds,
//	output wire[7:0]ddr_Minutes,
//	output wire[7:0]ddr_Hour,
//	output wire[7:0]ddr_Date,
//	output wire[7:0]ddr_Month,
//	output wire[7:0]ddr_Year,
//	
//	output wire[7:0]ddr_pkg_mun_Dataf,
//	output wire[15:0]ddr_Ch0_Dataf_ads1,
//	output wire[15:0]ddr_Ch1_Dataf_ads1,
//	output wire[15:0]ddr_Ch0_Dataf_ads2,
//	output wire[15:0]ddr_Ch1_Dataf_ads2,
//control signal from signal detect module
	input incident_inform,
	input[7:0]incident_b0,
	input[7:0]incident_b1,
	input[7:0]incident_b2,
	input[7:0]incident_b3	
	 );
	 
mt41j128m16_control U1(	
	.ppl_clk(clk),
	.rst(rst),
	
	.mem_a(mem_a),             //memory.mem_a
	.mem_ba(mem_ba),           //.mem_ba
	.mem_ck(mem_ck),           //.mem_ck
	.mem_ck_n(mem_ck_n),       //.mem_ck_n
	.mem_cke(mem_cke),         //.mem_cke
	.mem_cs_n(mem_cs_n),       //.mem_cs_n
	.mem_dm(mem_dm),           //.mem_dm
	.mem_ras_n(mem_ras_n),     //.mem_ras_n
	.mem_cas_n(mem_cas_n),     //.mem_cas_n
	.mem_we_n(mem_we_n),       //.mem_we_n
	.mem_reset_n(mem_reset_n), //.mem_reset_n
	.mem_dq(mem_dq),           //.mem_dq
	.mem_dqs(mem_dqs),         //.mem_dqs
	.mem_dqs_n(mem_dqs_n),     //.mem_dqs_n
	.mem_odt(mem_odt),         //.mem_odt
	.oct_rzqin(oct_rzqin),     //oct.rzqin
	.local_init_done(local_init_done), 
	
	.ds_MsecondsL(ds_MsecondsL),		
	.ds_MsecondsH(ds_MsecondsH),
	.ds_Seconds(ds_Seconds),
	.ds_Minutes(ds_Minutes),
	.ds_Hour(ds_Hour),
	.ds_Date(ds_Date),
	.ds_Month(ds_Month),
	.ds_Year(ds_Year),
	
	.Ch0_Dataf_ads1(Ch0_Dataf_ads1),
	.Ch1_Dataf_ads1(Ch1_Dataf_ads1),
	.Ch0_Dataf_ads2(Ch0_Dataf_ads2),
	.Ch1_Dataf_ads2(Ch1_Dataf_ads2),
	 
	.Ch1_Dataf_en_ads2(Ch1_Dataf_en_ads2),
	.Ch0_Dataf_en_ads2(Ch0_Dataf_en_ads2),
	.Ch1_Dataf_en_ads1(Ch1_Dataf_en_ads1),
	.Ch0_Dataf_en_ads1(Ch0_Dataf_en_ads1),
	
//data to flexbus	
   .afi_clk(afi_clk),
	.ddrL_RdStar(ddrL_RdStar),
	.ddrH_RdStar(ddrH_RdStar),
	.ddr_dat_timing(ddr_dat_timing),
	.ddr_timing_en(ddr_timing_en),
	.ddr_dat(ddr_dat),
	.ddr_dat_en(ddr_dat_en),
	.ddrL_read_switch(ddrL_read_switch),
	.ddrH_read_switch(ddrH_read_switch),
	
//	.ddr_MsecondsL(ddr_MsecondsL),		
//	.ddr_MsecondsH(ddr_MsecondsH),
//	.ddr_Seconds(ddr_Seconds),
//	.ddr_Minutes(ddr_Minutes),
//	.ddr_Hour(ddr_Hour),
//	.ddr_Date(ddr_Date),
//	.ddr_Month(ddr_Month),
//	.ddr_Year(ddr_Year),
//	
//	.ddr_pkg_mun_Dataf(ddr_pkg_mun_Dataf),
//	.ddr_Ch0_Dataf_ads1(ddr_Ch0_Dataf_ads1),
//	.ddr_Ch1_Dataf_ads1(ddr_Ch1_Dataf_ads1),
//	.ddr_Ch0_Dataf_ads2(ddr_Ch0_Dataf_ads2),
//	.ddr_Ch1_Dataf_ads2(ddr_Ch1_Dataf_ads2),
	
	.incident_inform(),
	.incident_b0(),
	.incident_b1(),
	.incident_b2(),
	.incident_b3(incident_b3),
	
	.ddr_add(),
	.ddr_op(0),
	.ads_dat(),
	.ads_dat_en());	
	 
endmodule