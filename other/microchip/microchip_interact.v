`timescale 1ns / 1ns

module microchip_interact(
	input rst,clk_25m,clk_50m,
	
//////////K64 SPI//////////////////
	output wire k64_spi_cs,k64_spi_clk,
	input  wire	k64_spi_din,
	output wire	k64_spi_dout,
//////////K64 Flexbus//////////
	inout	[7:0]	K64_AD,
	input	wire	K64_ALE,
	input	wire	K64_RW,	
	input	wire	K64_CS0,
	input	wire	K64_CLK,
	
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
	input  ddrH_read_switch
	
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
//	input [15:0]ddr_Ch1_Dataf_ads2
    );
	 
flexbus U1(

	.K64_AD(K64_AD),
	.K64_ALE(K64_ALE),
	.K64_CS0(K64_CS0),
	.K64_RW(K64_RW),
	.K64_CLK(K64_CLK),
	.clk(clk_50m),
	
	.cs_ads2(cs_ads2),
	.pkg_num_ads2(pkg_num_ads2),
	.receive_data_ads2(receive_data_ads2),
	.ALARM_Overview_Tflag_ads2(ALARM_Overview_Tflag_ads2),
	.ALARM_Ch03_Tfag_ads2(ALARM_Ch03_Tfag_ads2),
	.ALARM_Ch03_Aflag_ads2(ALARM_Ch03_Aflag_ads2),
	.Ch0_Data_ads2(Ch0_Data_ads2),
	.Ch1_Data_ads2(Ch1_Data_ads2),
	.Ch2_Data_ads2(Ch2_Data_ads2),
	.Ch3_Data_ads2(Ch3_Data_ads2),
	
	.cs_ads1(cs_ads1),
	.pkg_num_ads1(pkg_num_ads1),
	.receive_data_ads1(receive_data_ads1),
	.ALARM_Overview_Tflag_ads1(ALARM_Overview_Tflag_ads1),
	.ALARM_Ch03_Tfag_ads1(ALARM_Ch03_Tfag_ads1),
	.ALARM_Ch03_Aflag_ads1(ALARM_Ch03_Aflag_ads1),
	.Ch0_Data_ads1(Ch0_Data_ads1),
	.Ch1_Data_ads1(Ch1_Data_ads1),
	.Ch2_Data_ads1(Ch2_Data_ads1),
	.Ch3_Data_ads1(Ch3_Data_ads1),
	
	.Ch0_Data_en(Ch0_Data_en),
	.Ch1_Data_en(Ch1_Data_en),
	.Ch2_Data_en(Ch2_Data_en),
	.Ch3_Data_en(Ch3_Data_en),
	
	.Ch0_Dataf_ads1(Ch0_Dataf_ads1),
	.Ch1_Dataf_ads1(Ch1_Dataf_ads1),
	.Ch0_Dataf_ads2(Ch0_Dataf_ads2),
	.Ch1_Dataf_ads2(Ch1_Dataf_ads2),
	.Ch0_Dataf_en_ads1(Ch0_Dataf_en_ads1),
	.Ch1_Dataf_en_ads1(Ch1_Dataf_en_ads1),
	.Ch0_Dataf_en_ads2(Ch0_Dataf_en_ads2),
	.Ch1_Dataf_en_ads2(Ch1_Dataf_en_ads2),
	
	.time_message_cnt(time_message_cnt),
	.year(year),
	.month(month),
	.day(day),
	.hour(hour),
	.minute(minute),
	.second(second),
	
	.ds_MsecondsL(ds_MsecondsL),		
	.ds_MsecondsH(ds_MsecondsH),
	.ds_Seconds(ds_Seconds),
	.ds_Minutes(ds_Minutes),
	.ds_Hour(ds_Hour),
	.ds_Date(ds_Date),
	.ds_Month(ds_Month),
	.ds_Year(ds_Year),
	
//data from ddr	
	.afi_clk(afi_clk),
	.ddrL_RdStar(ddrL_RdStar),
	.ddrH_RdStar(ddrH_RdStar),
	.ddr_dat_timing(ddr_dat_timing),
	.ddr_timing_en(ddr_timing_en),
	.ddr_dat(ddr_dat),
	.ddr_dat_en(ddr_dat_en),
	.ddrL_read_switch(ddrL_read_switch),
	.ddrH_read_switch(ddrH_read_switch)
	
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
//	.ddr_Ch1_Dataf_ads2(ddr_Ch1_Dataf_ads2)
	);	 
	
K64_SPI U2(
	.rst_n(~rst),
	.clk(clk_25m),
	.CS_N(k64_spi_cs),
	.SCK(k64_spi_clk),
	.MOSI(k64_spi_din),
	.MISO(k64_spi_dout)
);

endmodule
