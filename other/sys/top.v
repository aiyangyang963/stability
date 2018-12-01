`timescale 1 ns / 1 ps

//`define NIOS_ON
//`define FFT_ON
`define DDR_ON
module top(
/**************clock in***************/
		input  wire	clk_in1,
		input  wire	clk_in2,
	   input  wire	clk_in3, 
/************ads interface************/
//////////////ads1
		output wire	AD1_CS,
		output wire	AD1_SCLK,
		input  wire	AD1_MISO,
		output wire	AD1_MOSI,
//////////////ads2
		output wire	AD2_CS,
		output wire	AD2_SCLK,
		input  wire	AD2_MISO,
		output wire	AD2_MOSI,
/**********microchip interface*********/
//////////K64 SPI
		output wire k64_spi_cs,k64_spi_clk,
		input	 wire	k64_spi_din,
		output wire	k64_spi_dout,
//////////K64 Flexbus
		inout	[7:0]	K64_AD,
		input	wire	K64_ALE,
		input	wire	K64_RW,	
		input	wire	K64_CS0,
		input	wire	K64_CLK,
/************uart interface***********/		
		input  uart_rx,
		output uart_tx,		
/************ddr3 interface***********/
`ifdef DDR_ON
	   output wire [13:0] mem_a,    //memory.mem_a
		output wire [2:0]  mem_ba,   //.mem_ba
		output wire [0:0]	 mem_ck,   //.mem_ck
		output wire [0:0]	 mem_ck_n, //.mem_ck_n
		output wire mem_cke,           //.mem_cke
		output wire mem_cs_n,          //.mem_cs_n
		output wire [1:0]  mem_dm,   //.mem_dm
		output wire mem_ras_n,         //.mem_ras_n
		output wire mem_cas_n,         //.mem_cas_n
		output wire mem_we_n,          //.mem_we_n
		output wire mem_reset_n,       //.mem_reset_n
		inout  wire [15:0] mem_dq,   //.mem_dq
		inout  wire [1:0]  mem_dqs,  //.mem_dqs
		inout  wire [1:0]  mem_dqs_n,//.mem_dqs_n
		output wire mem_odt,           //.mem_odt
		input  wire oct_rzqin,         //oct.rzqin
`else
	
`endif
/************ds3231 interface***********/
//		input  ds3231_rstn,
//		input  ds3231_32khz,
//		input  ds3231_intn_sqw,
		output wire ds3231_scl,
		inout  ds3231_sda,
/************max7410 clkin***********/
/////////////7K//////////////
		output wire	A7K,
/*****************test led***********/
//////////LED//////////		
		output wire	LED_FPGA0,
		output wire	LED_FPGA1,

		input key,
		
		output wire clk_out1,clk_out2,clk_out3,clk_out4,clk_out5
);
//very slow speed clock
(* syn_preserve = 1 *) wire clk_250,clk_500,clk_250K,clk_500K;
//low speed clock 		
(* syn_preserve = 1 *) wire clk_2_5m,clk_5m,clk_7m,clk_10m,clk_17m,clk_25m,clk_34m,clk_50m;
//high speed clock
(* syn_preserve = 1 *) wire clk_100m,clk_200m,clk_400m;
(* syn_preserve = 1 *) wire rst,rst_ddr;
(* syn_preserve = 1 *) wire local_init_done;

assign clk_out1 = clk_in2;
assign clk_out2 = clk_in2;
assign clk_out3 = clk_in2;
assign clk_out4 = clk_in2;
assign clk_out5 = clk_in2;

sys_control U0(
//////////////////////clock
	.clk1(clk_in1),
	.clk2(clk_in3),
	
	.clk_250(clk_250),
	.clk_500(clk_500),
	.clk_7K(A7K),
	.clk_250K(clk_250K),
	.clk_500K(clk_500K),
	
	.clk_2_5m(clk_2_5m),
	.clk_5m(clk_5m),  
	.clk_7m(clk_7m),  
	.clk_10m(clk_10m), 
	.clk_17m(clk_17m), 
	.clk_25m(clk_25m), 
	.clk_34m(clk_34m), 
	.clk_50m(clk_50m), 
	
	.clk_100m(clk_100m),
	.clk_200m(clk_200m),
	.clk_400m(clk_400m),
//////////////////////led
	.LED_FPGA0(LED_FPGA0),
	.LED_FPGA1(LED_FPGA1),
//////////////////////reset
	.local_init_done(local_init_done),
	.rst_out0(rst),
	.rst_out1(rst_ddr),
//////////////////////time
	.sda(ds3231_sda),
	.scl(ds3231_scl),
	
	.write_start_uart(ds3231_write_start),
	.write_over_uart(ds3231_write_over),
	.write_dat_uart(ds3231_write_dat),
	
	.ds_MsecondsL(ds_MsecondsL),		
	.ds_MsecondsH(ds_MsecondsH),
	.ds_Seconds(ds_Seconds),
	.ds_Minutes(ds_Minutes),
	.ds_Hour(ds_Hour),
	.ds_Date(ds_Date),
	.ds_Month(ds_Month),
	.ds_Year(ds_Year));
				 
//wire [55:0]Ch1_Dataf_ads2_w={1'b0,Ch1_Dataf_ads2};
//wire [54:0]Ch1_Dataf_ads2;
//wire Ch1_Dataf_en_ads2;

wire [15:0]Ch0_Data;
wire [15:0]Ch1_Data;
wire [15:0]Ch2_Data;
wire [15:0]Ch3_Data;
wire Ch0_Data_en;
wire Ch1_Data_en;
wire Ch2_Data_en;
wire Ch3_Data_en;

wire[15:0]Ori_Ch0_Dataf_ads1;
wire[15:0]Ori_Ch1_Dataf_ads1;
wire[15:0]Ori_Ch0_Dataf_ads2;
wire[15:0]Ori_Ch1_Dataf_ads2;
wire Ori_Ch1_Dataf_en_ads2;
wire Ori_Ch0_Dataf_en_ads2;
wire Ori_Ch1_Dataf_en_ads1;
wire Ori_Ch0_Dataf_en_ads1;

wire [15:0]Ch0_Dataf_ads1;
wire [15:0]Ch1_Dataf_ads1;
wire [15:0]Ch0_Dataf_ads2;
wire [15:0]Ch1_Dataf_ads2;
wire Ch1_Dataf_en_ads2;
wire Ch0_Dataf_en_ads2;
wire Ch1_Dataf_en_ads1;
wire Ch0_Dataf_en_ads1;

wire [15:0]Data_template;
wire Data_template_en;
	 
signal_source U1(
	.rst(rst),
	.clk_50m(clk_50m),
	.clk_500K(clk_500K),
	.clk_ads(clk_17m),
	
	.cs_ads1(AD1_CS),
	.sclk_ads1(AD1_SCLK),
	.sdo_ads1(AD1_MOSI),
	.sdi_ads1(AD1_MISO),
		
	.cs_ads2(AD2_CS),
	.sclk_ads2(AD2_SCLK),
	.sdo_ads2(AD2_MOSI),
	.sdi_ads2(AD2_MISO),
	 
	.Ch0_Data(Ch0_Data),
	.Ch1_Data(Ch1_Data),
	.Ch2_Data(Ch2_Data),
	.Ch3_Data(Ch3_Data),
	
	.Ch0_Data_en(Ch0_Data_en),
	.Ch1_Data_en(Ch1_Data_en),
	.Ch2_Data_en(Ch2_Data_en),
	.Ch3_Data_en(Ch3_Data_en),
	
	.Data_template(Data_template),
	.Data_template_en(Data_template_en));

signal_process U2(
	.rst(rst),
	.clk(clk_50m), //50M
	.clk1(clk_400m),//400M
	
	.Data_template(Data_template),
	.Data_template_en(Data_template_en),
	
	.Ch0_Data_ads1(Ch0_Data),
	.Ch1_Data_ads1(Ch1_Data),
	.Ch0_Data_ads2(Ch2_Data),
	.Ch1_Data_ads2(Ch3_Data),
	
	.Ch1_Data_en_ads2(Ch3_Data_en),
	.Ch0_Data_en_ads2(Ch2_Data_en),
	.Ch1_Data_en_ads1(Ch1_Data_en),
	.Ch0_Data_en_ads1(Ch0_Data_en),
	
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
	
wire Ch0_alarm_ads1;
wire Ch1_alarm_ads1;
wire Ch2_alarm_ads1;
wire Ch3_alarm_ads1;
wire Ch0_alarm_ads2;
wire Ch1_alarm_ads2;
wire Ch2_alarm_ads2;
wire Ch3_alarm_ads2;

wire incident_inform;
wire[7:0]incident_b0;
wire[7:0]incident_b1;
wire[7:0]incident_b2;
wire[7:0]incident_b3;

signal_detect U3(
	.clk(clk_50m),
	.clk1(clk_50m),
	.rst(rst),
	 
	.control_infor(control_infor),
	 
	.Ch0_Data(Ch0_Data),
	.Ch1_Data(Ch1_Data),
	.Ch2_Data(Ch2_Data),
	.Ch3_Data(Ch3_Data),
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
	
	.Ch1_Dataf_sign_ads2(Ch1_Dataf_sign_ads2),
	.Ch0_Dataf_sign_ads2(Ch0_Dataf_sign_ads2),
	.Ch1_Dataf_sign_ads1(Ch1_Dataf_sign_ads1),
	.Ch0_Dataf_sign_ads1(Ch0_Dataf_sign_ads1),
	
	.Ch0_alarm(),
	.Ch1_alarm(),
	.Ch2_alarm(),
	.Ch3_alarm(),
	
	.Ch0_disconnect(),
	.Ch1_disconnect(),
	.Ch2_disconnect(),
	.Ch3_disconnect(),
	
	.Ch0_trouble(),
	.Ch1_trouble(),
	.Ch2_trouble(),
	.Ch3_trouble(),
	
	.incident_inform(incident_inform),
	.incident_b0(incident_b0),
	.incident_b1(incident_b1),
	.incident_b2(incident_b2),
	.incident_b3(incident_b3));
	 
`ifdef NIOS_ON
	Qsys_system Qsys_system (
			.clk_clk(clk_100m),        // clk.clk
			.reset_reset_n(~rst),   	// reset.reset_n
			.pio_key_export(), 		// pio_key.export
			.pio_led0_export()// pio_led.export
			
		);
`else
	
`endif

wire[24:0]ddr_add;
wire[7:0] ddr_op;
wire[63:0]ads_dat={Ch3_Data,Ch2_Data,Ch1_Data,Ch0_Data};
wire[3:0]ads_dat_en={Ch3_Data_en,Ch2_Data_en,Ch1_Data_en,Ch0_Data_en};
//read from ddr data
wire [7:0]ddr_MsecondsL;		
wire [7:0]ddr_MsecondsH;
wire [7:0]ddr_Seconds;
wire [7:0]ddr_Minutes;
wire [7:0]ddr_Hour;
wire [7:0]ddr_Date;
wire [7:0]ddr_Month;
wire [7:0]ddr_Year;

wire [7:0]ddr_pkg_mun_Dataf;
wire [15:0]ddr_Ch0_Dataf_ads1;
wire [15:0]ddr_Ch1_Dataf_ads1;
wire [15:0]ddr_Ch0_Dataf_ads2;
wire [15:0]ddr_Ch1_Dataf_ads2;

//data to flexbus	
wire afi_clk;	
wire ddrL_RdStar;
wire ddrH_RdStar;
wire [63:00]ddr_dat_timing;
wire ddr_timing_en;
wire [63:00]ddr_dat;
wire ddr_dat_en;
wire ddrL_read_switch;
wire ddrH_read_switch;

`ifdef DDR_ON
	signal_store U4(
		.clk(clk_in2),
		.rst(rst_ddr),
	//ddr memorey interface	 
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
	//data in 
		.ds_MsecondsL(ds_MsecondsL),		
		.ds_MsecondsH(ds_MsecondsH),
		.ds_Seconds(ds_Seconds),
		.ds_Minutes(ds_Minutes),
		.ds_Hour(ds_Hour),
		.ds_Date(ds_Date),
		.ds_Month(ds_Month),
		.ds_Year(ds_Year),
		
		.Ch0_Dataf_ads1(Ori_Ch0_Dataf_ads1),
		.Ch1_Dataf_ads1(Ori_Ch1_Dataf_ads1),
		.Ch0_Dataf_ads2(Ori_Ch0_Dataf_ads2),
		.Ch1_Dataf_ads2(Ori_Ch1_Dataf_ads2),
		 
		.Ch1_Dataf_en_ads2(Ori_Ch1_Dataf_en_ads2),
		.Ch0_Dataf_en_ads2(Ori_Ch0_Dataf_en_ads2),
		.Ch1_Dataf_en_ads1(Ori_Ch1_Dataf_en_ads1),
		.Ch0_Dataf_en_ads1(Ori_Ch0_Dataf_en_ads1),
		
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
	//data out 
	
//		.ddr_MsecondsL(ddr_MsecondsL),		
//		.ddr_MsecondsH(ddr_MsecondsH),
//		.ddr_Seconds(ddr_Seconds),
//		.ddr_Minutes(ddr_Minutes),
//		.ddr_Hour(ddr_Hour),
//		.ddr_Date(ddr_Date),
//		.ddr_Month(ddr_Month),
//		.ddr_Year(ddr_Year),
//		
//		.ddr_pkg_mun_Dataf(ddr_pkg_mun_Dataf),
//		.ddr_Ch0_Dataf_ads1(ddr_Ch0_Dataf_ads1),
//		.ddr_Ch1_Dataf_ads1(ddr_Ch1_Dataf_ads1),
//		.ddr_Ch0_Dataf_ads2(ddr_Ch0_Dataf_ads2),
//		.ddr_Ch1_Dataf_ads2(ddr_Ch1_Dataf_ads2),
	//control signal from signal detect module
		.incident_inform(incident_inform),
		.incident_b0(incident_b0),
		.incident_b1(incident_b1),
		.incident_b2(incident_b2),
		.incident_b3(incident_b3)	
		 );
`else
	
`endif

wire [7:0]time_message_cnt;
wire [7:0]year;
wire [7:0]month;
wire [7:0]day;
wire [7:0]hour;
wire [7:0]minute;
wire [7:0]second;

wire [7:0]ds_MsecondsL;
wire [7:0]ds_MsecondsH;
wire [7:0]ds_Seconds;
wire [7:0]ds_Minutes;
wire [7:0]ds_Hour;
wire [7:0]ds_Date;
wire [7:0]ds_Month;
wire [7:0]ds_Year;

microchip_interact U5(
	.rst(rst),
	.clk_25m(clk_25m),
	.clk_50m(clk_50m),
	 
//////////K64 SPI//////////////////
	.k64_spi_cs(k64_spi_cs),
	.k64_spi_clk(k64_spi_clk),
	.k64_spi_din(k64_spi_din),
	.k64_spi_dout(k64_spi_dout),
//////////K64 Flexbus//////////
	.K64_AD(K64_AD),
	.K64_ALE(K64_ALE),
	.K64_RW(K64_RW),	
	.K64_CS0(K64_CS0),
	.K64_CLK(K64_CLK),
	 
//	 .cs_ads2(AD2_CS),
//	 .pkg_num_ads2(pkg_num_ads2),
//	 .receive_data_ads2(receive_data_ads2),
//	 .ALARM_Overview_Tflag_ads2(ALARM_Overview_Tflag_ads2),
//	 .ALARM_Ch03_Tfag_ads2(ALARM_Ch03_Tfag_ads2),
//	 .ALARM_Ch03_Aflag_ads2(ALARM_Ch03_Aflag_ads2),
	.Ch0_Data_ads2(Ch0_Data),
	.Ch1_Data_ads2(Ch1_Data),
	.Ch2_Data_ads2(),
	.Ch3_Data_ads2(),
	
//	 .cs_ads1(AD1_CS),
//	 .pkg_num_ads1(pkg_num_ads1),
//	 .receive_data_ads1(receive_data_ads1),
//	 .ALARM_Overview_Tflag_ads1(ALARM_Overview_Tflag_ads1),
//	 .ALARM_Ch03_Tfag_ads1(ALARM_Ch03_Tfag_ads1),
//	 .ALARM_Ch03_Aflag_ads1(ALARM_Ch03_Aflag_ads1),
	.Ch0_Data_ads1(Ch2_Data),
	.Ch1_Data_ads1(Ch3_Data),
	.Ch2_Data_ads1(),
	.Ch3_Data_ads1(),
	
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
	
	//data to flexbus	
	.afi_clk(afi_clk),
	.ddrL_RdStar(ddrL_RdStar),
	.ddrH_RdStar(ddrH_RdStar),
	.ddr_dat_timing(ddr_dat_timing),
	.ddr_timing_en(ddr_timing_en),
	.ddr_dat(ddr_dat),
	.ddr_dat_en(ddr_dat_en),
	.ddrL_read_switch(ddrL_read_switch),
	.ddrH_read_switch(ddrH_read_switch)
	 
	 //ddr data out 
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
	
wire ds3231_write_start;
wire ds3231_write_over;
wire [47:0]ds3231_write_dat;
wire [07:0]control_infor;//from k64 control information		

wire ds3231_read_start;
wire ds3231_read_over;
wire [47:0]ds3231_read_dat;	

wire to_uart_ready,to_uart_valid,from_uart_valid;
wire [7:0]to_uart_data,from_uart_data;
uart_top U6(
	.reset(rst),
	.clk(clk_50m),
	.uart_rx(uart_rx),
	.uart_tx(uart_tx),
	
	.ALARM_Overview_Tflag_ads1(),
	.ALARM_Ch03_Tfag_ads1(),
	.ALARM_Ch03_Aflag_ads1(),
	.Ch0_Data_ads1(Ch0_Data),
	.Ch1_Data_ads1(Ch1_Data),
	.Ch2_Data_ads1(),
	.Ch3_Data_ads1(),
	.ALARM_Overview_Tflag_ads2(),
	.ALARM_Ch03_Tfag_ads2(),
	.ALARM_Ch03_Aflag_ads2(),
	.Ch0_Data_ads2(Ch3_Data),
	.Ch1_Data_ads2(Ch4_Data),
	.Ch2_Data_ads2(),
	.Ch3_Data_ads2(),
	
//	.Ch0_Dataf_ads2(Ch0_Dataf_ads2_w),
// .Ch0_Dataf_en_ads2(Ch0_Dataf_en_ads2),
	
	.ddr_add(ddr_add),
	.ddr_op(ddr_op),
	
	.time_message_cnt(time_message_cnt),
	.year(year),
	.month(month),
	.day(day),
	.hour(hour),
	.minute(minute),
	.second(second),
//because uart can not use,so use other module initialize ds3231 	
	.ds3231_write_start(ds3231_write_start),
	.ds3231_write_over(ds3231_write_over),
	.ds3231_write_dat(ds3231_write_dat),
	.control_infor(control_infor),
	
	.Ch0_Data_en_ads2(Ch2_Data_en),
	.Ch1_Data_en_ads2(Ch3_Data_en),
	.Ch2_Data_en_ads2(),
	.Ch3_Data_en_ads2(),
	
	.incident_inform(incident_inform),
	.incident_b0(incident_b0),
	.incident_b1(incident_b1),
	.incident_b2(incident_b2),
	.incident_b3(incident_b3));	 
	
//ds3231_initialize U8(
//	.rst(rst),
//	.clk_250k(clk_250K),
//	
//	.write_start(ds3231_write_start),
//	.write_over(ds3231_write_over),
//	.write_dat(ds3231_write_dat));
				
//`ifdef FFT_ON
//	fft_ads fft_ads(
//	 .rst(rst),
//	 .clk(clk_250K),
//	 
//	 .Ch0_Data_ads1(Ch0_Data),
//	 .Ch1_Data_ads1(Ch1_Data),
//	 .Ch0_Data_ads2(Ch2_Data),
//	 .Ch1_Data_ads2(Ch3_Data),
//	 
//	 .Ch0_Data_en_ads1(Ch0_Data_en),
//	 .Ch1_Data_en_ads1(Ch1_Data_en),
//	 .Ch0_Data_en_ads2(Ch2_Data_en),	 
//	 .Ch1_Data_en_ads2(Ch3_Data_en)
//
//    );
//`else
//	
//`endif
		
endmodule
