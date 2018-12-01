`timescale 1ns / 1ns
module ads_top(
	 input rst,clk,clk_ads,
	 
    output wire  cs_ads1,sclk_ads1,sdo_ads1,
	 output wire  cs_ads2,sclk_ads2,sdo_ads2,
	 input sdi_ads1,sdi_ads2,
	 
	 output wire [15:0]pkg_num_ads1,pkg_num_ads2,
	 output wire[15:0]receive_data_ads1,receive_data_ads2,
	 
	 output wire [7:0]ALARM_Overview_Tflag_ads1,ALARM_Overview_Tflag_ads2,
	 output wire [7:0]ALARM_Ch03_Tfag_ads1,ALARM_Ch03_Tfag_ads2,
	 output wire [7:0]ALARM_Ch03_Aflag_ads1,ALARM_Ch03_Aflag_ads2,
	 output wire [15:0]Ch0_Data_ads1,Ch0_Data_ads2,
	 output wire [15:0]Ch1_Data_ads1,Ch1_Data_ads2,
	 output wire [15:0]Ch2_Data_ads1,Ch2_Data_ads2,
	 output wire [15:0]Ch3_Data_ads1,Ch3_Data_ads2,
	 output wire Ch0_Data_en_ads1,Ch0_Data_en_ads2,
	 output wire Ch1_Data_en_ads1,Ch1_Data_en_ads2,
	 output wire Ch2_Data_en_ads1,Ch2_Data_en_ads2,
	 output wire Ch3_Data_en_ads1,Ch3_Data_en_ads2
    );
	 
V11_SPI ad1(
	  .RESETN(~rst),
	  .clk(clk_ads),
     .AD1_CS(cs_ads1),
	  .AD1_SCLK(sclk_ads1),
	  .AD1_SDI(sdi_ads1),
	  .AD1_SDO(sdo_ads1),
	  .pkg_num(pkg_num_ads1),
	  .receive_data(receive_data_ads1)
    );

AD2 ad2(
	  .RESETN(~rst),
	  .clk(clk_ads),
     .AD_CS(cs_ads2),
	  .AD_SCLK(sclk_ads2),
	  .AD_SDI(sdi_ads2),
	  .AD_SDO(sdo_ads2),
	  .pkg_num(pkg_num_ads2),
	  .receive_data(receive_data_ads2)
    );	

wire [15:0]Ch0_Data_in_ads1;
wire [15:0]Ch1_Data_in_ads1;
wire [15:0]Ch0_Data_in_ads2;
wire [15:0]Ch1_Data_in_ads2;
wire Ch0_Data_in_en_ads1;
wire Ch1_Data_in_en_ads1;
wire Ch0_Data_in_en_ads2;
wire Ch1_Data_in_en_ads2;

wire [15:0]Ch0_Data_out_ads1;
wire [15:0]Ch1_Data_out_ads1;
wire [15:0]Ch0_Data_out_ads2;
wire [15:0]Ch1_Data_out_ads2;
wire Ch0_Data_out_en_ads1;
wire Ch1_Data_out_en_ads1;
wire Ch0_Data_out_en_ads2;
wire Ch1_Data_out_en_ads2;
	 
assign Ch0_Data_ads1=Ch0_Data_out_ads1;
assign Ch1_Data_ads1=Ch1_Data_out_ads1;
//assign Ch0_Data_ads2=Ch0_Data_out_ads2;
assign Ch0_Data_ads2=Ch0_Data_in_ads2;
assign Ch1_Data_ads2=Ch1_Data_out_ads2;

assign Ch0_Data_en_ads1=Ch0_Data_out_en_ads1;
assign Ch1_Data_en_ads1=Ch1_Data_out_en_ads1;
assign Ch0_Data_en_ads2=Ch0_Data_out_en_ads2;
assign Ch1_Data_en_ads2=Ch1_Data_out_en_ads2;
	 
ads1_dat_acquire ads_dat_acquire1(
     .clk(clk),
	 
	  .ads_cs(cs_ads1),
	  .pkg_num(pkg_num_ads1),
	  .receive_data(receive_data_ads1),
	 
	  .ALARM_Overview_Tflag(ALARM_Overview_Tflag_ads1),
	  .ALARM_Ch03_Tfag(ALARM_Ch03_Tfag_ads1),
	  .ALARM_Ch03_Aflag(ALARM_Ch03_Aflag_ads1),
	  .Ch0_Data(Ch0_Data_in_ads1),
	  .Ch1_Data(Ch1_Data_in_ads1),
	  .Ch2_Data(Ch2_Data_ads1),
	  .Ch3_Data(Ch3_Data_ads1),
	  .Ch0_Data_en(Ch0_Data_in_en_ads1),
	  .Ch1_Data_en(Ch1_Data_in_en_ads1),
	  .Ch2_Data_en(Ch2_Data_en_ads1),
	  .Ch3_Data_en(Ch3_Data_en_ads1)
    );

ads2_dat_acquire ads_dat_acquire2(
     .clk(clk),
	 
	  .ads_cs(cs_ads2),
	  .pkg_num(pkg_num_ads2),
	  .receive_data(receive_data_ads2),
	 
	  .ALARM_Overview_Tflag(ALARM_Overview_Tflag_ads2),
	  .ALARM_Ch03_Tfag(ALARM_Ch03_Tfag_ads2),
	  .ALARM_Ch03_Aflag(ALARM_Ch03_Aflag_ads2),
	  .Ch0_Data(Ch0_Data_in_ads2),
	  .Ch1_Data(Ch1_Data_in_ads2),
	  .Ch2_Data(Ch2_Data_ads2),
	  .Ch3_Data(Ch3_Data_ads2),
	  .Ch0_Data_en(Ch0_Data_in_en_ads2),
	  .Ch1_Data_en(Ch1_Data_in_en_ads2),
	  .Ch2_Data_en(Ch2_Data_en_ads2),
	  .Ch3_Data_en(Ch3_Data_en_ads2)
    );
	 
	dat_decimate ads_dat_decimate(
	  .clk(clk),
	  .rst(rst),
	  
	  .Data0_in(Ch0_Data_in_ads1),
	  .Data1_in(Ch1_Data_in_ads1),
	  .Data0_in_en(Ch0_Data_in_en_ads1),
	  .Data1_in_en(Ch1_Data_in_en_ads1),
	  
	  .Data2_in(Ch0_Data_in_ads2),
	  .Data3_in(Ch1_Data_in_ads2),
	  .Data2_in_en(Ch0_Data_in_en_ads2),
	  .Data3_in_en(Ch1_Data_in_en_ads2),
	  
	  .Data0_out(Ch0_Data_out_ads1),
	  .Data1_out(Ch1_Data_out_ads1),
	  .Data0_out_en(Ch0_Data_out_en_ads1),
	  .Data1_out_en(Ch1_Data_out_en_ads1),
	  
	  .Data2_out(Ch0_Data_out_ads2),
	  .Data3_out(Ch1_Data_out_ads2),
	  .Data2_out_en(Ch0_Data_out_en_ads2),
	  .Data3_out_en(Ch1_Data_out_en_ads2)
	  );
	 
endmodule