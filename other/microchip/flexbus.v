`timescale 1 ns / 1 ns
module flexbus(
	inout	wire[7:0]K64_AD,
	input	K64_ALE,
	input	K64_CS0,
	input K64_RW,
	input	K64_CLK,
	
	input clk,
	input cs_ads2,
	input [15:0]pkg_num_ads2,
	input [15:0]receive_data_ads2,
	
	input [7:0]ALARM_Overview_Tflag_ads2,
	input [7:0]ALARM_Ch03_Tfag_ads2,
	input [7:0]ALARM_Ch03_Aflag_ads2,
	input [15:0]Ch0_Data_ads2,
	input [15:0]Ch1_Data_ads2,
	input [15:0]Ch2_Data_ads2,
	input [15:0]Ch3_Data_ads2,
	
	input cs_ads1,
	input [15:0]pkg_num_ads1,
	input [15:0]receive_data_ads1,
	
	input [7:0]ALARM_Overview_Tflag_ads1,
	input [7:0]ALARM_Ch03_Tfag_ads1,
	input [7:0]ALARM_Ch03_Aflag_ads1,
	input [15:0]Ch0_Data_ads1,
	input [15:0]Ch1_Data_ads1,
	input [15:0]Ch2_Data_ads1,
	input [15:0]Ch3_Data_ads1,
	
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
	
	input [7:0]time_message_cnt,
	input [7:0]year,
	input [7:0]month,
	input [7:0]day,
	input [7:0]hour,
	input [7:0]minute,
	input [7:0]second,
		
	input [7:0]ds_MsecondsL,		
	input [7:0]ds_MsecondsH,
	input [7:0]ds_Seconds,
	input [7:0]ds_Minutes,
	input [7:0]ds_Hour,
	input [7:0]ds_Date,
	input [7:0]ds_Month,
	input [7:0]ds_Year,
	
//data from ddr
	input afi_clk,	
	output wire ddrL_RdStar,
	output wire ddrH_RdStar,
	input  [63:00]ddr_dat_timing,
	input  ddr_timing_en,
	input  [63:00]ddr_dat,
	input  ddr_dat_en,
	input  ddrL_read_switch,
	input  ddrH_read_switch,
	
//	input [7:0]ddr_MsecondsL,		
//	input [7:0]ddr_MsecondsH,
//	input [7:0]ddr_Seconds,
//	input [7:0]ddr_Minutes,
//	input [7:0]ddr_Hour,
//	input [7:0]ddr_Date,
//	input [7:0]ddr_Month,
//	input [7:0]ddr_Year,
//	
//	input [7:0]ddr_pkg_mun_Dataf,
//	input [15:0]ddr_Ch0_Dataf_ads1,
//	input [15:0]ddr_Ch1_Dataf_ads1,
//	input [15:0]ddr_Ch0_Dataf_ads2,
//	input [15:0]ddr_Ch1_Dataf_ads2,
	
	output reg[7:0]fdat_temp_00,
	output reg[7:0]fdat_temp_01,
	output reg[7:0]fdat_temp_02,
	output reg[7:0]fdat_temp_03,
	output reg[7:0]fdat_temp_04,
	output reg[7:0]fdat_temp_05,
	output reg[7:0]fdat_temp_06,
	output reg[7:0]fdat_temp_07,
	output reg[7:0]fdat_temp_08,
	output reg[7:0]fdat_temp_09
	
		);
(* syn_preserve = 1 *)  wire [7:0]pos_fdat_temp_09;
(* syn_preserve = 1 *)  reg [7:0]fdat_temp_09_r0,fdat_temp_09_r1,fdat_temp_09_r2;
(* syn_preserve = 1 *)  wire [15:0]Ch1_Data_ads2_fifo,Ch0_Data_ads2_fifo,Ch1_Data_ads1_fifo,Ch0_Data_ads1_fifo;
(* syn_preserve = 1 *)  reg [7:0]pkg_mun_ads1,pkg_mun_ads2 = 0;
(* syn_preserve = 1 *)  wire[7:0]pkg_mun_ads1_fifo,pkg_mun_ads2_fifo;
(* syn_preserve = 1 *)  reg [7:0]pkg_mun_ads1_ch0,pkg_mun_ads1_ch1,pkg_mun_ads2_ch0,pkg_mun_ads2_ch1 = 0;
//data from ddr that before 5 minute from alrm
(* syn_preserve = 1 *)	reg [07:0]ddr_befor5_MsecondsL;		
(* syn_preserve = 1 *)	reg [07:0]ddr_befor5_MsecondsH;
(* syn_preserve = 1 *)	reg [07:0]ddr_befor5_Seconds;
(* syn_preserve = 1 *)	reg [07:0]ddr_befor5_Minutes;
(* syn_preserve = 1 *)	reg [07:0]ddr_befor5_Hour;
(* syn_preserve = 1 *)	reg [07:0]ddr_befor5_Date;
(* syn_preserve = 1 *)	reg [07:0]ddr_befor5_Month;
(* syn_preserve = 1 *)	reg [07:0]ddr_befor5_Year;
	
(* syn_preserve = 1 *)	reg [07:0]ddr_befor5_pkg_mun_Dataf;
(* syn_preserve = 1 *)	reg [15:0]ddr_befor5_Ch0_Dataf_ads1;
(* syn_preserve = 1 *)	reg [15:0]ddr_befor5_Ch1_Dataf_ads1;
(* syn_preserve = 1 *)	reg [15:0]ddr_befor5_Ch0_Dataf_ads2;
(* syn_preserve = 1 *)	reg [15:0]ddr_befor5_Ch1_Dataf_ads2;
//data from ddr that after 5 minute from alrm
(* syn_preserve = 1 *)	reg [07:0]ddr_after5_MsecondsL;	
(* syn_preserve = 1 *)	reg [07:0]ddr_after5_MsecondsH;
(* syn_preserve = 1 *)	reg [07:0]ddr_after5_Seconds;
(* syn_preserve = 1 *)	reg [07:0]ddr_after5_Minutes;
(* syn_preserve = 1 *)	reg [07:0]ddr_after5_Hour;
(* syn_preserve = 1 *)	reg [07:0]ddr_after5_Date;
(* syn_preserve = 1 *)	reg [07:0]ddr_after5_Month;
(* syn_preserve = 1 *)	reg [07:0]ddr_after5_Year;
	
(* syn_preserve = 1 *)	reg [07:0]ddr_after5_pkg_mun_Dataf;
(* syn_preserve = 1 *)	reg [15:0]ddr_after5_Ch0_Dataf_ads1;
(* syn_preserve = 1 *)	reg [15:0]ddr_after5_Ch1_Dataf_ads1;
(* syn_preserve = 1 *)	reg [15:0]ddr_after5_Ch0_Dataf_ads2;
(* syn_preserve = 1 *)	reg [15:0]ddr_after5_Ch1_Dataf_ads2;

wire pos_Ch0_Data_en,neg_Ch0_Data_en;
wire pos_Ch1_Data_en,neg_Ch1_Data_en;
wire pos_Ch2_Data_en,neg_Ch2_Data_en;
wire pos_Ch3_Data_en,neg_Ch3_Data_en;

wire pos_Ch1_Dataf_en_ads2,neg_Ch1_Dataf_en_ads2;
wire pos_Ch0_Dataf_en_ads2,neg_Ch0_Dataf_en_ads2;
wire pos_Ch1_Dataf_en_ads1,neg_Ch1_Dataf_en_ads1;
wire pos_Ch0_Dataf_en_ads1,neg_Ch0_Dataf_en_ads1;

reg Ch0_Data_en_r0,Ch0_Data_en_r1,Ch0_Data_en_r2;
reg Ch1_Data_en_r0,Ch1_Data_en_r1,Ch1_Data_en_r2;
reg Ch2_Data_en_r0,Ch2_Data_en_r1,Ch2_Data_en_r2;
reg Ch3_Data_en_r0,Ch3_Data_en_r1,Ch3_Data_en_r2;

reg Ch1_Dataf_en_ads2_r0,Ch1_Dataf_en_ads2_r1,Ch1_Dataf_en_ads2_r2;
reg Ch0_Dataf_en_ads2_r0,Ch0_Dataf_en_ads2_r1,Ch0_Dataf_en_ads2_r2;
reg Ch1_Dataf_en_ads1_r0,Ch1_Dataf_en_ads1_r1,Ch1_Dataf_en_ads1_r2;
reg Ch0_Dataf_en_ads1_r0,Ch0_Dataf_en_ads1_r1,Ch0_Dataf_en_ads1_r2;



always@(posedge clk)
	begin
		Ch0_Data_en_r0<=Ch0_Data_en;
		Ch0_Data_en_r1<=Ch0_Data_en_r0;
		Ch0_Data_en_r2<=Ch0_Data_en_r1;
		
		Ch1_Data_en_r0<=Ch1_Data_en;
		Ch1_Data_en_r1<=Ch1_Data_en_r0;
		Ch1_Data_en_r2<=Ch1_Data_en_r1;
		
		Ch2_Data_en_r0<=Ch2_Data_en;
		Ch2_Data_en_r1<=Ch2_Data_en_r0;
		Ch2_Data_en_r2<=Ch2_Data_en_r1;
		
		Ch3_Data_en_r0<=Ch3_Data_en;
		Ch3_Data_en_r1<=Ch3_Data_en_r0;
		Ch3_Data_en_r2<=Ch3_Data_en_r1;
		
		Ch1_Dataf_en_ads2_r0<=Ch1_Dataf_en_ads2;
		Ch1_Dataf_en_ads2_r1<=Ch1_Dataf_en_ads2_r0;
		Ch1_Dataf_en_ads2_r2<=Ch1_Dataf_en_ads2_r1;
		
		Ch0_Dataf_en_ads2_r0<=Ch0_Dataf_en_ads2;
		Ch0_Dataf_en_ads2_r1<=Ch0_Dataf_en_ads2_r0;
		Ch0_Dataf_en_ads2_r2<=Ch0_Dataf_en_ads2_r1;
		
		Ch1_Dataf_en_ads1_r0<=Ch1_Dataf_en_ads1;
		Ch1_Dataf_en_ads1_r1<=Ch1_Dataf_en_ads1_r0;
		Ch1_Dataf_en_ads1_r2<=Ch1_Dataf_en_ads1_r1;
		
		Ch0_Dataf_en_ads1_r0<=Ch0_Dataf_en_ads1;
		Ch0_Dataf_en_ads1_r1<=Ch0_Dataf_en_ads1_r0;
		Ch0_Dataf_en_ads1_r2<=Ch0_Dataf_en_ads1_r1;
		
		fdat_temp_09_r0<=fdat_temp_09;
		fdat_temp_09_r1<=fdat_temp_09_r0;
		fdat_temp_09_r2<=fdat_temp_09_r1;
	end

assign pos_fdat_temp_09[7]=(~fdat_temp_09_r2[7])&fdat_temp_09_r1[7];
assign pos_fdat_temp_09[6]=(~fdat_temp_09_r2[6])&fdat_temp_09_r1[6];
assign pos_fdat_temp_09[5]=(~fdat_temp_09_r2[5])&fdat_temp_09_r1[5];
assign pos_fdat_temp_09[4]=(~fdat_temp_09_r2[4])&fdat_temp_09_r1[4];
assign pos_fdat_temp_09[3]=(~fdat_temp_09_r2[3])&fdat_temp_09_r1[3];

wire ads_to_flex_fifo_rd =pos_fdat_temp_09[7];
assign ddrL_RdStar=pos_fdat_temp_09[6];
assign ddrH_RdStar=pos_fdat_temp_09[5];
wire ddr_befor5_fifo_rd=pos_fdat_temp_09[4];
wire ddr_after5_fifo_rd=pos_fdat_temp_09[3];
	
assign pos_Ch0_Data_en=(~Ch0_Data_en_r2)&Ch0_Data_en_r1;
assign pos_Ch1_Data_en=(~Ch1_Data_en_r2)&Ch1_Data_en_r1;
assign pos_Ch2_Data_en=(~Ch2_Data_en_r2)&Ch2_Data_en_r1;
assign pos_Ch3_Data_en=(~Ch3_Data_en_r2)&Ch3_Data_en_r1;

assign pos_Ch1_Dataf_en_ads2=(~Ch1_Dataf_en_ads2_r2)&Ch1_Dataf_en_ads2_r1;
assign pos_Ch0_Dataf_en_ads2=(~Ch0_Dataf_en_ads2_r2)&Ch0_Dataf_en_ads2_r1;
assign pos_Ch1_Dataf_en_ads1=(~Ch1_Dataf_en_ads1_r2)&Ch1_Dataf_en_ads1_r1;
assign pos_Ch0_Dataf_en_ads1=(~Ch0_Dataf_en_ads1_r2)&Ch0_Dataf_en_ads1_r1;

assign neg_Ch0_Data_en=Ch0_Data_en_r2&(~Ch0_Data_en_r1); 
assign neg_Ch1_Data_en=Ch1_Data_en_r2&(~Ch1_Data_en_r1); 
assign neg_Ch2_Data_en=Ch2_Data_en_r2&(~Ch2_Data_en_r1); 
assign neg_Ch3_Data_en=Ch3_Data_en_r2&(~Ch3_Data_en_r1); 

assign neg_Ch1_Dataf_en_ads2=Ch1_Dataf_en_ads2_r2&(~Ch1_Dataf_en_ads2_r1); 
assign neg_Ch0_Dataf_en_ads2=Ch0_Dataf_en_ads2_r2&(~Ch0_Dataf_en_ads2_r1); 
assign neg_Ch1_Dataf_en_ads1=Ch1_Dataf_en_ads1_r2&(~Ch1_Dataf_en_ads1_r1); 
assign neg_Ch0_Dataf_en_ads1=Ch0_Dataf_en_ads1_r2&(~Ch0_Dataf_en_ads1_r1); 

wire ads_to_flex_fifo_full,ads_to_flex_fifo_empty;
ads_to_flex_fifo Buf1 (
	.clock(clk),
	.data({pkg_mun_ads2,pkg_mun_ads1,Ch1_Data_ads2,Ch0_Data_ads2,Ch1_Data_ads1,Ch0_Data_ads1}),
	.rdreq(ads_to_flex_fifo_rd),
	.wrreq(pos_Ch0_Data_en),
	.empty(ads_to_flex_fifo_empty),
	.full(ads_to_flex_fifo_full),
	.q({pkg_mun_ads2_fifo,pkg_mun_ads1_fifo,Ch1_Data_ads2_fifo,Ch0_Data_ads2_fifo,Ch1_Data_ads1_fifo,Ch0_Data_ads1_fifo}));

wire ddr_befor5_fifo_full,ddr_befor5_fifo_empty;
wire ddr_befor5_fifo_wrreq = (ddrL_read_switch)&(ddr_timing_en||ddr_dat_en);
wire [63:00]ddr_befor5_fifo_data = (ddrL_read_switch & ddr_timing_en)?ddr_dat_timing:
											  (ddrL_read_switch & ddr_dat_en)?   ddr_dat:0;											 
(*syn_preserve = 1*) wire[63:00]ddr_befor5_fifo_q;
										 
ddr_befor5_fifo Buf2(
	.data(ddr_befor5_fifo_data),
	.rdclk(clk),
	.rdreq(ddr_befor5_fifo_rd),
	.wrclk(afi_clk),
	.wrreq(ddr_befor5_fifo_wrreq),
	.q(ddr_befor5_fifo_q),
	.rdempty(ddr_befor5_fifo_empty),
	.wrfull(ddr_befor5_fifo_full));
	
wire ddr_after5_fifo_full,ddr_after5_fifo_empty;
wire ddr_after5_fifo_wrreq = (ddrH_read_switch)&(ddr_timing_en||ddr_dat_en);
wire [63:00]ddr_after5_fifo_data = (ddrH_read_switch & ddr_timing_en)?ddr_dat_timing:
											  (ddrH_read_switch & ddr_dat_en)?   ddr_dat:0;											 
(*syn_preserve = 1*) wire[63:00]ddr_after5_fifo_q;											 
ddr_after5_fifo Buf3(
	.data(ddr_after5_fifo_data),
	.rdclk(clk),
	.rdreq(ddr_after5_fifo_rd),
	.wrclk(afi_clk),
	.wrreq(ddr_after5_fifo_wrreq),
	.q(ddr_after5_fifo_q),
	.rdempty(ddr_after5_fifo_empty),
	.wrfull(ddr_after5_fifo_full));
	
//ddr_befor5_fifo ddr_befor5_fifo (
//	.clock(clk),
//	.data({Ch1_Data_ads2,Ch0_Data_ads2,Ch1_Data_ads1,Ch0_Data_ads1}),
//	.rdreq(ads_to_flex_fifo_rd),
//	.wrreq(pos_Ch0_Data_en),
//	.empty(),
//	.full(ads_to_flex_fifo_full),
//	.q({Ch1_Data_ads2_fifo,Ch0_Data_ads2_fifo,Ch1_Data_ads1_fifo,Ch0_Data_ads1_fifo}));
//
//wire ddr_after5_fifo_full;
//ddr_after5_fifo ddr_after5_fifo (
//	.clock(clk),
//	.data({Ch1_Data_ads2,Ch0_Data_ads2,Ch1_Data_ads1,Ch0_Data_ads1}),
//	.rdreq(ads_to_flex_fifo_rd),
//	.wrreq(pos_Ch0_Data_en),
//	.empty(),
//	.full(ads_to_flex_fifo_full),
//	.q({Ch1_Data_ads2_fifo,Ch0_Data_ads2_fifo,Ch1_Data_ads1_fifo,Ch0_Data_ads1_fifo}));	
//send ads2 data to flexbus
//wire pos_cs_ads2;
//reg cs_ads2_r0,cs_ads2_r1,cs_ads2_r2;
//always@(posedge clk)
//	begin
//		cs_ads2_r0<=cs_ads2;
//		cs_ads2_r1<=cs_ads2_r0;
//		cs_ads2_r2<=cs_ads2_r1;
//	end
//
//assign pos_cs_ads2=(~cs_ads2_r2)&cs_ads2_r1;
//assign neg_cs_ads2=cs_ads2_r2&(~cs_ads2_r1);   
//
//reg [1:0]ads2_rotater;
// always @(posedge clk)
//	begin
//		if(pkg_num_ads2!=0)
//			begin
//				if(pos_cs_ads2)ads2_rotater<=ads2_rotater+1;
//				else ads2_rotater<=ads2_rotater;
//				
//			end
//		else
//			begin
//				if(pos_cs_ads2)ads2_rotater<=0;
//				else ads2_rotater<=ads2_rotater;
//				
//			end
//	end
// always @(posedge clk)
//	begin
//		case(ads2_rotater)
//			0:
//				begin
//					if(pos_cs_ads2)
//						begin
//							dat_temp_05<=receive_data_ads2[7:0];
//							dat_temp_06<=receive_data_ads2[15:8];
//						end
//					else
//						begin
//							dat_temp_05<=dat_temp_05;
//							dat_temp_06<=dat_temp_06;
//						end
//				end
//			1:
//				begin
//					if(pos_cs_ads2)
//						begin
//							dat_temp_07<=receive_data_ads2[7:0];
//							dat_temp_08<=receive_data_ads2[15:8];
//						end
//					else
//						begin
//							dat_temp_07<=dat_temp_07;
//							dat_temp_08<=dat_temp_08;
//						end
//				end
//			2:
//				begin
//					if(pos_cs_ads2)
//						begin
//							dat_temp_09<=receive_data_ads2[7:0];
//							dat_temp_0a<=receive_data_ads2[15:8];
//						end
//					else
//						begin
//							dat_temp_09<=dat_temp_09;
//							dat_temp_0a<=dat_temp_0a;
//						end
//				end
//			3:
//				begin
//					if(pos_cs_ads2)
//						begin
//							dat_temp_0b<=receive_data_ads2[7:0];
//							dat_temp_0c<=receive_data_ads2[15:8];
//						end
//					else
//						begin
//							dat_temp_0b<=dat_temp_0b;
//							dat_temp_0c<=dat_temp_0c;
//						end
//				end
//			default:
//				begin
//					dat_temp_05<=dat_temp_05;
//					dat_temp_06<=dat_temp_06;
//					dat_temp_07<=dat_temp_07;
//					dat_temp_08<=dat_temp_08;
//					dat_temp_09<=dat_temp_09;
//					dat_temp_0a<=dat_temp_0a;
//					dat_temp_0b<=dat_temp_0b;
//					dat_temp_0c<=dat_temp_0c;
//				end
//		endcase
//	end
	
//send ads2 data to flexbus	
//process ads sample and filter data		
(* syn_preserve = 1 *) reg  [7:0]dat_temp_00 = 8'hFF;
(* syn_preserve = 1 *) wire [7:0]dat_temp_01 = ds_Year;
(* syn_preserve = 1 *) wire [7:0]dat_temp_02 = ds_Month;
(* syn_preserve = 1 *) wire [7:0]dat_temp_03 = ds_Date;
(* syn_preserve = 1 *) wire [7:0]dat_temp_04 = ds_Hour;
(* syn_preserve = 1 *) wire [7:0]dat_temp_05 = ds_Minutes;
(* syn_preserve = 1 *) wire [7:0]dat_temp_06 = ds_Seconds;
(* syn_preserve = 1 *) wire [7:0]dat_temp_07 = ds_MsecondsH;
(* syn_preserve = 1 *) wire [7:0]dat_temp_08 = ds_MsecondsL;
(* syn_preserve = 1 *) wire [7:0]dat_temp_09 = {ads_to_flex_fifo_full,ddr_befor5_fifo_full,ddr_after5_fifo_full,
																ads_to_flex_fifo_empty,ddr_befor5_fifo_empty,ddr_after5_fifo_empty,2'b0};

(* syn_preserve = 1 *) wire [7:0]dat_temp_0a = pkg_mun_ads1_fifo [07:0];
(* syn_preserve = 1 *) wire [7:0]dat_temp_0b = pkg_mun_ads2_fifo [07:0];
(* syn_preserve = 1 *) wire [7:0]dat_temp_0c = Ch0_Data_ads1_fifo[15:8];
(* syn_preserve = 1 *) wire [7:0]dat_temp_0d = Ch0_Data_ads1_fifo[07:0];
(* syn_preserve = 1 *) wire [7:0]dat_temp_0e = Ch1_Data_ads1_fifo[15:8];
(* syn_preserve = 1 *) wire [7:0]dat_temp_0f = Ch1_Data_ads1_fifo[07:0];
(* syn_preserve = 1 *) wire [7:0]dat_temp_10 = Ch0_Data_ads2_fifo[15:8];
(* syn_preserve = 1 *) wire [7:0]dat_temp_11 = Ch0_Data_ads2_fifo[07:0];
(* syn_preserve = 1 *) wire [7:0]dat_temp_12 = Ch1_Data_ads2_fifo[15:8];
(* syn_preserve = 1 *) wire [7:0]dat_temp_13 = Ch1_Data_ads2_fifo[07:0];
 
(* syn_preserve = 1 *) wire [7:0]dat_temp_14 = pkg_mun_ads1_ch0;
(* syn_preserve = 1 *) wire [7:0]dat_temp_15 = pkg_mun_ads1_ch1;
(* syn_preserve = 1 *) wire [7:0]dat_temp_16 = pkg_mun_ads2_ch0;
(* syn_preserve = 1 *) wire [7:0]dat_temp_17 = pkg_mun_ads2_ch1;
(* syn_preserve = 1 *) wire [7:0]dat_temp_18 = Ch0_Dataf_ads1[15:8];
(* syn_preserve = 1 *) wire [7:0]dat_temp_19 = Ch0_Dataf_ads1[07:0];
(* syn_preserve = 1 *) wire [7:0]dat_temp_1a = Ch1_Dataf_ads1[15:8];
(* syn_preserve = 1 *) wire [7:0]dat_temp_1b = Ch1_Dataf_ads1[07:0];
(* syn_preserve = 1 *) wire [7:0]dat_temp_1c = Ch0_Dataf_ads2[15:8];
(* syn_preserve = 1 *) wire [7:0]dat_temp_1d = Ch0_Dataf_ads2[07:0];
(* syn_preserve = 1 *) wire [7:0]dat_temp_1e = Ch1_Dataf_ads2[15:8];
(* syn_preserve = 1 *) wire [7:0]dat_temp_1f = Ch1_Dataf_ads2[07:0];
//when systerm alarm,go back filtered data before alarm from ddr sdram																
(* syn_preserve = 1 *) reg  [7:0]dat_temp_20 = 8'hFF;
(* syn_preserve = 1 *) wire [7:0]dat_temp_21 = ddr_befor5_fifo_q[07:00];//ddr_befor5_Year	    ||ddr_befor5_Ch1_Dataf_ads2[07:0]
(* syn_preserve = 1 *) wire [7:0]dat_temp_22 = ddr_befor5_fifo_q[15:08];//ddr_befor5_Month    ||ddr_befor5_Ch1_Dataf_ads2[15:8]
(* syn_preserve = 1 *) wire [7:0]dat_temp_23 = ddr_befor5_fifo_q[23:16];//ddr_befor5_Date     ||ddr_befor5_Ch0_Dataf_ads2[07:0]
(* syn_preserve = 1 *) wire [7:0]dat_temp_24 = ddr_befor5_fifo_q[31:24];//ddr_befor5_Hour     ||ddr_befor5_Ch0_Dataf_ads2[15:8]
(* syn_preserve = 1 *) wire [7:0]dat_temp_25 = ddr_befor5_fifo_q[39:32];//ddr_befor5_Minutes  ||ddr_befor5_Ch1_Dataf_ads1[07:0]
(* syn_preserve = 1 *) wire [7:0]dat_temp_26 = ddr_befor5_fifo_q[47:40];//ddr_befor5_Seconds  ||ddr_befor5_Ch1_Dataf_ads1[15:8]
(* syn_preserve = 1 *) wire [7:0]dat_temp_27 = ddr_befor5_fifo_q[55:48];//ddr_befor5_MsecondsH||ddr_befor5_Ch0_Dataf_ads1[07:0]
(* syn_preserve = 1 *) wire [7:0]dat_temp_28 = ddr_befor5_fifo_q[63:56];//ddr_befor5_MsecondsL||ddr_befor5_Ch0_Dataf_ads1[15:8]  
                    
(* syn_preserve = 1 *) wire [7:0]dat_temp_29 = ddr_after5_fifo_q[07:00];//ddr_after5_Year	    ||ddr_after5_Ch1_Dataf_ads2[07:0]
(* syn_preserve = 1 *) wire [7:0]dat_temp_2a = ddr_after5_fifo_q[15:08];//ddr_after5_Month    ||ddr_after5_Ch1_Dataf_ads2[15:8]
(* syn_preserve = 1 *) wire [7:0]dat_temp_2b = ddr_after5_fifo_q[23:16];//ddr_after5_Date     ||ddr_after5_Ch0_Dataf_ads2[07:0]
(* syn_preserve = 1 *) wire [7:0]dat_temp_2c = ddr_after5_fifo_q[31:24];//ddr_after5_Hour     ||ddr_after5_Ch0_Dataf_ads2[15:8]
(* syn_preserve = 1 *) wire [7:0]dat_temp_2d = ddr_after5_fifo_q[39:32];//ddr_after5_Minutes  ||ddr_after5_Ch1_Dataf_ads1[07:0]
(* syn_preserve = 1 *) wire [7:0]dat_temp_2e = ddr_after5_fifo_q[47:40];//ddr_after5_Seconds  ||ddr_after5_Ch1_Dataf_ads1[15:8]
(* syn_preserve = 1 *) wire [7:0]dat_temp_2f = ddr_after5_fifo_q[55:48];//ddr_after5_MsecondsH||ddr_after5_Ch0_Dataf_ads1[07:0]
(* syn_preserve = 1 *) wire [7:0]dat_temp_30 = ddr_after5_fifo_q[63:56];//ddr_after5_MsecondsL||ddr_after5_Ch0_Dataf_ads1[15:8]
 
//when systerm alarm,go back filtered data after alarm from ddr sdram
//(* syn_preserve = 1 *) reg  [7:0]dat_temp_40 = 8'hFF;
//(* syn_preserve = 1 *) wire [7:0]dat_temp_41 = ddr_after5_Year;
//(* syn_preserve = 1 *) wire [7:0]dat_temp_42 = ddr_after5_Month;
//(* syn_preserve = 1 *) wire [7:0]dat_temp_43 = ddr_after5_Date;
//(* syn_preserve = 1 *) wire [7:0]dat_temp_44 = ddr_after5_Hour;
//(* syn_preserve = 1 *) wire [7:0]dat_temp_45 = ddr_after5_Minutes;
//(* syn_preserve = 1 *) wire [7:0]dat_temp_46 = ddr_after5_Seconds;
//(* syn_preserve = 1 *) wire [7:0]dat_temp_47 = ddr_after5_MsecondsH;
//(* syn_preserve = 1 *) wire [7:0]dat_temp_48 = ddr_after5_MsecondsL;
//(* syn_preserve = 1 *) wire [7:0]dat_temp_49 = 0;
//
//(* syn_preserve = 1 *) wire [7:0]dat_temp_4a = ddr_after5_pkg_mun_Dataf [07:0];
//(* syn_preserve = 1 *) wire [7:0]dat_temp_4b = ddr_after5_Ch0_Dataf_ads1[15:8];
//(* syn_preserve = 1 *) wire [7:0]dat_temp_4c = ddr_after5_Ch0_Dataf_ads1[07:0];
//(* syn_preserve = 1 *) wire [7:0]dat_temp_4d = ddr_after5_Ch1_Dataf_ads1[15:8];
//(* syn_preserve = 1 *) wire [7:0]dat_temp_4e = ddr_after5_Ch1_Dataf_ads1[07:0];
//(* syn_preserve = 1 *) wire [7:0]dat_temp_4f = ddr_after5_Ch0_Dataf_ads2[15:8];
//(* syn_preserve = 1 *) wire [7:0]dat_temp_50 = ddr_after5_Ch0_Dataf_ads2[07:0];
//(* syn_preserve = 1 *) wire [7:0]dat_temp_51 = ddr_after5_Ch1_Dataf_ads2[15:8];
//(* syn_preserve = 1 *) wire [7:0]dat_temp_52 = ddr_after5_Ch1_Dataf_ads2[07:0]; 

//receive data from flexbus	
//(* syn_preserve = 1 *) reg [7:0]fdat_temp_00 = 8'hFF;
//(* syn_preserve = 1 *) reg [7:0]fdat_temp_01 = 8'hFF;
//(* syn_preserve = 1 *) reg [7:0]fdat_temp_02 = 8'hFF;
//(* syn_preserve = 1 *) reg [7:0]fdat_temp_03 = 8'hFF;
//(* syn_preserve = 1 *) reg [7:0]fdat_temp_04 = 8'hFF;
//(* syn_preserve = 1 *) reg [7:0]fdat_temp_05 = 8'hFF;
//(* syn_preserve = 1 *) reg [7:0]fdat_temp_06 = 8'hFF;
//(* syn_preserve = 1 *) reg [7:0]fdat_temp_07 = 8'hFF;
//(* syn_preserve = 1 *) reg [7:0]fdat_temp_08 = 8'hFF;
//(* syn_preserve = 1 *) reg [7:0]fdat_temp_09 = 8'hFF;

 
 always @(posedge clk)
	begin
		if(pos_Ch0_Data_en) pkg_mun_ads1<=pkg_mun_ads1+1;
		else pkg_mun_ads1<=pkg_mun_ads1;
		if(pos_Ch2_Data_en) pkg_mun_ads2<=pkg_mun_ads2+1;
		else pkg_mun_ads2<=pkg_mun_ads2;
		
		if(pos_Ch0_Dataf_en_ads1) pkg_mun_ads1_ch0<=pkg_mun_ads1_ch0+1;
		else pkg_mun_ads1_ch0<=pkg_mun_ads1_ch0;
		if(pos_Ch1_Dataf_en_ads1) pkg_mun_ads1_ch1<=pkg_mun_ads1_ch1+1;
		else pkg_mun_ads1_ch1<=pkg_mun_ads1_ch1;
		if(pos_Ch0_Dataf_en_ads2) pkg_mun_ads2_ch0<=pkg_mun_ads2_ch0+1;
		else pkg_mun_ads2_ch0<=pkg_mun_ads2_ch0;
		if(pos_Ch1_Dataf_en_ads2) pkg_mun_ads2_ch1<=pkg_mun_ads2_ch1+1;
		else pkg_mun_ads2_ch1<=pkg_mun_ads2_ch1;
	end
	
 wire  [7:0]k64_ad_in;
 reg   [7:0]k64_ad_out;
 
 assign  k64_ad_in = K64_AD;
 assign  K64_AD = ((~K64_ALE)&&(K64_RW))? k64_ad_out:8'bzzzz_zzzz;
 
 reg [7:0]k64_address;
 always @(posedge K64_CLK)
	begin
		if(K64_ALE)k64_address<=k64_ad_in;
		else k64_address<=k64_address;
	end
//send data to flexbus 
 always @(*)
	begin
		case(k64_address)
//ads sample and filter data
				8'h00:	k64_ad_out<=dat_temp_00;
				8'h01:	k64_ad_out<=dat_temp_01;
				8'h02:	k64_ad_out<=dat_temp_02;
				8'h03:	k64_ad_out<=dat_temp_03;
				8'h04:	k64_ad_out<=dat_temp_04;
				8'h05:	k64_ad_out<=dat_temp_05;
				8'h06:	k64_ad_out<=dat_temp_06;
				8'h07:	k64_ad_out<=dat_temp_07;
				8'h08:	k64_ad_out<=dat_temp_08;
				8'h09:	k64_ad_out<=dat_temp_09;
				8'h0a:	k64_ad_out<=dat_temp_0a;
				8'h0b:	k64_ad_out<=dat_temp_0b;
				8'h0c:	k64_ad_out<=dat_temp_0c;
				8'h0d:	k64_ad_out<=dat_temp_0d;
				8'h0e:	k64_ad_out<=dat_temp_0e;
				8'h0f:	k64_ad_out<=dat_temp_0f;
				8'h10:	k64_ad_out<=dat_temp_10;
				8'h11:	k64_ad_out<=dat_temp_11;
				8'h12:	k64_ad_out<=dat_temp_12;
				8'h13:	k64_ad_out<=dat_temp_13;
				8'h14:	k64_ad_out<=dat_temp_14;
				8'h15:	k64_ad_out<=dat_temp_15;
				8'h16:	k64_ad_out<=dat_temp_16;
				8'h17:	k64_ad_out<=dat_temp_17;
				8'h18:	k64_ad_out<=dat_temp_18;
				8'h19:	k64_ad_out<=dat_temp_19;
				8'h1a:   k64_ad_out<=dat_temp_1a;
				8'h1b:   k64_ad_out<=dat_temp_1b;
				8'h1c:   k64_ad_out<=dat_temp_1c;
				8'h1d:   k64_ad_out<=dat_temp_1d;
				8'h1e:   k64_ad_out<=dat_temp_1e;
				8'h1f:   k64_ad_out<=dat_temp_1f;
//filtered data from ddr sdram				
				8'h20:   k64_ad_out<=dat_temp_20;
				8'h21:   k64_ad_out<=dat_temp_21;
				8'h22:   k64_ad_out<=dat_temp_22;
				8'h23:   k64_ad_out<=dat_temp_23;
				8'h24:   k64_ad_out<=dat_temp_24;
				8'h25:   k64_ad_out<=dat_temp_25;
				8'h26:   k64_ad_out<=dat_temp_26;
				8'h27:   k64_ad_out<=dat_temp_27;
				8'h28:   k64_ad_out<=dat_temp_28;
				8'h29:   k64_ad_out<=dat_temp_29;
				8'h2a:   k64_ad_out<=dat_temp_2a;
				8'h2b:   k64_ad_out<=dat_temp_2b;
				8'h2c:   k64_ad_out<=dat_temp_2c;
				8'h2d:   k64_ad_out<=dat_temp_2d;
				8'h2e:   k64_ad_out<=dat_temp_2e;
				8'h2f:   k64_ad_out<=dat_temp_2f;
				8'h30:   k64_ad_out<=dat_temp_30;
//				8'h31:   k64_ad_out<=dat_temp_31;
//				8'h32:   k64_ad_out<=dat_temp_32;
////filtered data from ddr sdram after alarm
//				8'h40:   k64_ad_out<=dat_temp_40;
//				8'h41:   k64_ad_out<=dat_temp_41;
//				8'h42:   k64_ad_out<=dat_temp_42;
//				8'h43:   k64_ad_out<=dat_temp_43;
//				8'h44:   k64_ad_out<=dat_temp_44;
//				8'h45:   k64_ad_out<=dat_temp_45;
//				8'h46:   k64_ad_out<=dat_temp_46;
//				8'h47:   k64_ad_out<=dat_temp_47;
//				8'h48:   k64_ad_out<=dat_temp_48;
//				8'h49:   k64_ad_out<=dat_temp_49;
//				8'h4a:   k64_ad_out<=dat_temp_4a;
//				8'h4b:   k64_ad_out<=dat_temp_4b;
//				8'h4c:   k64_ad_out<=dat_temp_4c;
//				8'h4d:   k64_ad_out<=dat_temp_4d;
//				8'h4e:   k64_ad_out<=dat_temp_4e;
//				8'h4f:   k64_ad_out<=dat_temp_4f;
//				8'h50:   k64_ad_out<=dat_temp_50;
//				8'h51:   k64_ad_out<=dat_temp_51;
//				8'h52:   k64_ad_out<=dat_temp_52;
				
				default: k64_ad_out<=k64_ad_out;
		endcase
 end
//receive data from flexbus 
 always @(*)
	begin
		if((~K64_CS0)&&(~K64_RW))
			begin
				case(k64_address)
					8'h00:fdat_temp_00<=k64_ad_in;
					8'h01:fdat_temp_01<=k64_ad_in;
					8'h02:fdat_temp_02<=k64_ad_in;
					8'h03:fdat_temp_03<=k64_ad_in;
					8'h04:fdat_temp_04<=k64_ad_in;
					8'h05:fdat_temp_05<=k64_ad_in;
					8'h06:fdat_temp_06<=k64_ad_in;
					8'h07:fdat_temp_07<=k64_ad_in;
					8'h08:fdat_temp_08<=k64_ad_in;
					8'h09:fdat_temp_09<=k64_ad_in;
					default:
						begin
							fdat_temp_00<=fdat_temp_00;
							fdat_temp_01<=fdat_temp_01;
							fdat_temp_02<=fdat_temp_02;
							fdat_temp_03<=fdat_temp_03;
							fdat_temp_04<=fdat_temp_04;
							fdat_temp_05<=fdat_temp_05;
							fdat_temp_06<=fdat_temp_06;
							fdat_temp_07<=fdat_temp_07;
							fdat_temp_08<=fdat_temp_08;
							fdat_temp_09<=fdat_temp_09;
						end
				endcase
			end
		else
			begin
				fdat_temp_00<=fdat_temp_00;
				fdat_temp_01<=fdat_temp_01;
				fdat_temp_02<=fdat_temp_02;
				fdat_temp_03<=fdat_temp_03;
				fdat_temp_04<=fdat_temp_04;
				fdat_temp_05<=fdat_temp_05;
				fdat_temp_06<=fdat_temp_06;
				fdat_temp_07<=fdat_temp_07;
				fdat_temp_08<=fdat_temp_08;
				fdat_temp_09<=fdat_temp_09;
			end
	end	
		
		
 
// reg [7:0]timer_cnt = 0;
// always @(posedge K64_CLK)
//	begin
//		if(timer_cnt==100)timer_cnt<=0;
//		else timer_cnt<=timer_cnt+1;
//	end
// 
// always @(posedge K64_CLK)
//	begin
//		if(timer_cnt==100)begin
//			dat_temp_00 <= ~dat_temp_00;
//		   dat_temp_01 <= ~dat_temp_01;
//		   dat_temp_02 <= ~dat_temp_02;
//		   dat_temp_03 <= ~dat_temp_03;
//		   dat_temp_04 <= ~dat_temp_04;
//		   dat_temp_05 <= ~dat_temp_05;
//		   dat_temp_06 <= ~dat_temp_06;
//		   dat_temp_07 <= ~dat_temp_07;
//		   dat_temp_08 <= ~dat_temp_08;
//		   dat_temp_09 <= ~dat_temp_09;
//		   dat_temp_0a <= ~dat_temp_0a;
//		   dat_temp_0b <= ~dat_temp_0b;
//		   dat_temp_0c <= ~dat_temp_0c;
//		   dat_temp_0d <= ~dat_temp_0d;
//		   dat_temp_0e <= ~dat_temp_0e;
//		   dat_temp_0f <= ~dat_temp_0f;
//		   dat_temp_10 <= ~dat_temp_10;
//		   dat_temp_11 <= ~dat_temp_11;
//		   dat_temp_12 <= ~dat_temp_12;
//		   dat_temp_13 <= ~dat_temp_13;
//		   dat_temp_14 <= ~dat_temp_14;
//		   dat_temp_15 <= ~dat_temp_15;
//		   dat_temp_16 <= ~dat_temp_16;
//		   dat_temp_17 <= ~dat_temp_17;
//		end
//		else begin
//			dat_temp_00 <= dat_temp_00;
//		   dat_temp_01 <= dat_temp_01;
//		   dat_temp_02 <= dat_temp_02;
//		   dat_temp_03 <= dat_temp_03;
//		   dat_temp_04 <= dat_temp_04;
//		   dat_temp_05 <= dat_temp_05;
//		   dat_temp_06 <= dat_temp_06;
//		   dat_temp_07 <= dat_temp_07;
//		   dat_temp_08 <= dat_temp_08;
//		   dat_temp_09 <= dat_temp_09;
//		   dat_temp_0a <= dat_temp_0a;
//		   dat_temp_0b <= dat_temp_0b;
//		   dat_temp_0c <= dat_temp_0c;
//		   dat_temp_0d <= dat_temp_0d;
//		   dat_temp_0e <= dat_temp_0e;
//		   dat_temp_0f <= dat_temp_0f;
//		   dat_temp_10 <= dat_temp_10;
//		   dat_temp_11 <= dat_temp_11;
//		   dat_temp_12 <= dat_temp_12;
//		   dat_temp_13 <= dat_temp_13;
//		   dat_temp_14 <= dat_temp_14;
//		   dat_temp_15 <= dat_temp_15;
//		   dat_temp_16 <= dat_temp_16;
//		   dat_temp_17 <= dat_temp_17;
//		end
//	end
// 
//  always @(posedge K64_CLK)
//	begin
//		if(k64_address==8'h17)dat_temp_18<=0;
//		else if(timer_cnt==100)dat_temp_18<=1;
//		else dat_temp_18<=dat_temp_18;
//	end

 //produce time message
 reg [15:0]timecnt;
 reg [7:0]year_r,month_r,day_r,hour_r,minute_r,second_r;
 reg [15:0]msecond_r;
 always @(posedge clk)
	begin
		if(time_message_cnt==0)
			begin
				year_r	<=year;
				month_r	<=month;
				day_r		<=day;
				hour_r	<=hour;
				minute_r	<=minute;
				second_r	<=second;
				msecond_r<=0;
				timecnt	<=0;
			end
		else
			begin
				if(month_r==11)
					begin
						month_r<=0;
						year_r <=year_r+1;
					end
				else
					begin
						year_r <=year_r;
						if(day_r==30)
							begin
								day_r<=0;
								month_r<=month_r+1;
							end
						else
							begin
								month_r<=month_r;
								if(hour_r==23)
									begin
										day_r<=day_r+1;
										hour_r<=0;
									end
								else
									begin
										day_r<=day_r;
										if(minute_r==59)
											begin
												hour_r<=hour_r+1;
												minute_r<=0;
											end
										else
											begin
												hour_r<=hour_r;
												if(second_r==59)
													begin
														minute_r<=minute_r+1;
														second_r<=0;
													end
												else
													begin
														minute_r<=minute_r;
														if(msecond_r==999)
															begin
																second_r<=second_r+1;
																msecond_r<=0;
															end
														else
															begin
																second_r<=second_r;//50_000*20ns=1ms--50Mhz clock
																if(timecnt==50_000)
																	begin
																		timecnt<=0;
																		msecond_r<=msecond_r+1;
																	end
																else
																	begin
																		msecond_r<=msecond_r;
																		timecnt<=timecnt+1;
																	end
															end
													end
											end
									end
							end
					end
			end
	end
 
endmodule