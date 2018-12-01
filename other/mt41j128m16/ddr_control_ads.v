`timescale 1 ns / 1 ns
//`define DDR_READ_DELAY
module ddr_control_ads(
		input clk,
		input test_complete,
		
		output reg [24:00]user0_avl_address,             //user0_avl.address
		output reg        user0_avl_write,               //.write
		output reg        user0_avl_read,                //.read
		input  wire[63:00]user0_avl_readdata,            //.readdata
		output reg [63:00]user0_avl_writedata,           //.writedata
		output reg        user0_avl_beginbursttransfer,  //.beginbursttransfer
		output wire[03:00]user0_avl_burstcount,          //.burstcount
		output wire[07:00]user0_avl_byteenable,          //.byteenable
		input  wire       user0_avl_readdatavalid,       //.readdatavalid
		input  wire       user0_avl_waitrequest,         //.waitrequest_n
		
		
//want to save data to ddr3		
		input [07:00]ds_MsecondsL,		
		input [07:00]ds_MsecondsH,
		input [07:00]ds_Seconds,
		input [07:00]ds_Minutes,
		input [07:00]ds_Hour,
		input [07:00]ds_Date,
		input [07:00]ds_Month,
		input [07:00]ds_Year,
		
		input [15:00]Ch0_Dataf_ads1,
		input [15:00]Ch1_Dataf_ads1,
		input [15:00]Ch0_Dataf_ads2,
		input [15:00]Ch1_Dataf_ads2,
		 
		input Ch1_Dataf_en_ads2,
		input Ch0_Dataf_en_ads2,
		input Ch1_Dataf_en_ads1,
		input Ch0_Dataf_en_ads1,
//want to get data from ddr3
		output wire[07:00]ddr_MsecondsL,		
		output wire[07:00]ddr_MsecondsH,
		output wire[07:00]ddr_Seconds,
		output wire[07:00]ddr_Minutes,
		output wire[07:00]ddr_Hour,
		output wire[07:00]ddr_Date,
		output wire[07:00]ddr_Month,
		output wire[07:00]ddr_Year,
		
		output reg [07:00]ddr_pkg_mun_Dataf,
		output wire[15:00]ddr_Ch0_Dataf_ads1,
		output wire[15:00]ddr_Ch1_Dataf_ads1,
		output wire[15:00]ddr_Ch0_Dataf_ads2,
		output wire[15:00]ddr_Ch1_Dataf_ads2,
//incident signal		
		input incident_inform,
		input[07:00]incident_b0,
		input[07:00]incident_b1,
		input[07:00]incident_b2,
		input[07:00]incident_b3,
		
		input[03:00]ddr_ads_enable
	);
	
wire pos_user0_avl_readdatavalid;
edge_detect d00(
	.clk(clk),
	.signal(user0_avl_readdatavalid),
	.pos_signal(pos_user0_avl_readdatavalid));
always@(posedge clk)
	begin
		if(pos_user0_avl_readdatavalid)ddr_pkg_mun_Dataf<=ddr_pkg_mun_Dataf+1;
		else ddr_pkg_mun_Dataf<=ddr_pkg_mun_Dataf;
	end
		
wire[07:00]pos_incident_b3,neg_incident_b3;		
edge_detect d01(
	.clk(clk),
	.signal(incident_b3[4]),
	.pos_signal(pos_incident_b3[4]),
	.neg_signal(neg_incident_b3[4]));
edge_detect d02(
	.clk(clk),
	.signal(incident_b3[5]),
	.pos_signal(pos_incident_b3[5]),
	.neg_signal(neg_incident_b3[5]));
edge_detect d03(
	.clk(clk),
	.signal(incident_b3[6]),
	.pos_signal(pos_incident_b3[6]),
	.neg_signal(neg_incident_b3[6]));
edge_detect d04(
	.clk(clk),
	.signal(incident_b3[7]),
	.pos_signal(pos_incident_b3[7]),
	.neg_signal(neg_incident_b3[7]));
	
reg ddr_read_switch=0;	
always@(posedge clk)
	begin
		if(pos_incident_b3[7]||neg_incident_b3[7]||
			pos_incident_b3[6]||neg_incident_b3[6]||
			pos_incident_b3[5]||neg_incident_b3[5]||
			pos_incident_b3[4]||neg_incident_b3[4])ddr_read_switch<=1;
		else if(ddr_read_address>=ddr_endadd)ddr_read_switch<=0;
		else ddr_read_switch<=ddr_read_switch;
	end
	
reg ddr_write_switch=0;	
always@(posedge clk)
	begin
		if(pos_Ch1_Dataf_en_ads1)ddr_write_switch<=1;
		else if(ddr_ads_state==2)ddr_write_switch<=0;
		else ddr_write_switch<=ddr_write_switch;
	end

wire[3:0]pos_ddr_ads_enable;
reg [3:0]ddr_ads_enable_r0,ddr_ads_enable_r1,ddr_ads_enable_r2;
always@(posedge clk)
	begin
		ddr_ads_enable_r0<=ddr_ads_enable;
		ddr_ads_enable_r1<=ddr_ads_enable_r0;
		ddr_ads_enable_r2<=ddr_ads_enable_r1;
	end
assign pos_ddr_ads_enable[0]=(~ddr_ads_enable_r2[0])&ddr_ads_enable_r1[0];
assign pos_ddr_ads_enable[1]=(~ddr_ads_enable_r2[1])&ddr_ads_enable_r1[1];
assign pos_ddr_ads_enable[2]=(~ddr_ads_enable_r2[2])&ddr_ads_enable_r1[2];
assign pos_ddr_ads_enable[3]=(~ddr_ads_enable_r2[3])&ddr_ads_enable_r1[3];

wire pos_Ch1_Dataf_en_ads1;
edge_detect d05(
	.clk(clk),
	.signal(Ch1_Dataf_en_ads1),
	.pos_signal(pos_Ch1_Dataf_en_ads1));
	
parameter ddr_stradd = 25'h000_0000;
parameter ddr_endadd = 25'h001_0000;	
assign user0_avl_burstcount =(ddr_ads_state==250)?0:2;
assign user0_avl_byteenable =(ddr_ads_state==250)?0:8'b1111_1111;//.byteenable
(*syn_preserve = 1*) wire [63:00]ads_dat_timing={ds_MsecondsL,ds_MsecondsH,ds_Seconds,ds_Minutes,ds_Hour,ds_Date,ds_Month,ds_Year};
(*syn_preserve = 1*) wire [63:00]ads_dat={Ch0_Dataf_ads1,Ch1_Dataf_ads1,Ch0_Dataf_ads2,Ch1_Dataf_ads2};
(*syn_preserve = 1*) reg  [63:00]ddr_dat_timing;
(*syn_preserve = 1*) reg  [63:00]ddr_dat;
(*syn_preserve = 1*) reg  [07:00]ddr_Seconds_lasttime;
(*syn_preserve = 1*) reg  [07:00]ddr_Seconds_now;
always@(posedge clk)
	begin
		ddr_Seconds_now		<=user0_avl_readdata[47:40];
		ddr_Seconds_lasttime <=ddr_dat_timing[47:40];
	end

(*syn_preserve = 1*) reg  [07:00]ddr_Seconds_cnt;
assign ddr_MsecondsL	= ddr_dat_timing[63:56];		
assign ddr_MsecondsH	= ddr_dat_timing[55:48];
assign ddr_Seconds 	= ddr_dat_timing[47:40];
assign ddr_Minutes 	= ddr_dat_timing[39:32];
assign ddr_Hour    	= ddr_dat_timing[31:24];
assign ddr_Date		= ddr_dat_timing[23:16];
assign ddr_Month		= ddr_dat_timing[15:08];
assign ddr_Year		= ddr_dat_timing[07:00];

assign ddr_Ch0_Dataf_ads1 = ddr_dat[63:48];
assign ddr_Ch1_Dataf_ads1 = ddr_dat[47:32];
assign ddr_Ch0_Dataf_ads2 = ddr_dat[31:16];
assign ddr_Ch1_Dataf_ads2 = ddr_dat[15:00];

(* syn_preserve = 1 *)reg [24:00] ddr_read_address;
(* syn_preserve = 1 *)reg [24:00] ddr_write_address;
(* syn_preserve = 1 *)reg [15:00] ddr_read_wait=0;	
(* syn_preserve = 1 *)reg [07:00] ddr_ads_state=250;
always@(posedge clk)
	begin
		if(ddr_ads_enable[3])
			begin
				case(ddr_ads_state)
					0:begin//burst 2 write
						if(user0_avl_waitrequest & ddr_write_switch)
							begin
								user0_avl_write<=1;
								user0_avl_beginbursttransfer<=1;
								user0_avl_address<=ddr_write_address;
								user0_avl_writedata<=ads_dat_timing;
								ddr_ads_state<=1;
							end
						else
							begin
								user0_avl_write<=0;
								user0_avl_beginbursttransfer<=0;
								user0_avl_address<=user0_avl_address;
								user0_avl_writedata<=0;
								ddr_ads_state<=0;
							end
							
						end
					1:begin
							user0_avl_writedata<=ads_dat;
							user0_avl_beginbursttransfer<=0;
							ddr_ads_state<=2;
						end
					2:begin//judgement if systerm have alarm or release alarm
						if(ddr_read_switch)
							begin
								ddr_ads_state<=3;
							end
						else
							begin
								ddr_ads_state<=0;
							end
						if(ddr_write_address>=ddr_endadd)ddr_write_address<=ddr_stradd;
						else ddr_write_address<=ddr_write_address+2;
						user0_avl_write<=0;
						user0_avl_writedata<=0;
						user0_avl_beginbursttransfer<=0;
						end
					3://wait in order to clear ddr_read_switch
						begin
							if(ddr_read_switch)ddr_ads_state<=10;
							else ddr_ads_state<=0;
						end
					10:begin//burst 2 read about 30 second
							if(user0_avl_waitrequest)
								begin
									user0_avl_read<=1;
									user0_avl_beginbursttransfer<=1;
									user0_avl_address<=ddr_read_address;
									ddr_ads_state<=11;
								end
							else
								begin
									user0_avl_read<=0;
									user0_avl_beginbursttransfer<=0;
									user0_avl_address<=user0_avl_address;
									ddr_ads_state<=10;
								end
						end
					11:begin
							user0_avl_read<=0;
							user0_avl_beginbursttransfer<=0;
							if(user0_avl_readdatavalid)
								begin
									ddr_dat_timing<=user0_avl_readdata;
									ddr_ads_state<=12;
								end
							else
								begin
									ddr_dat_timing<=ddr_dat_timing;
									ddr_ads_state<=11;
								end
						end
					12:begin
							ddr_dat<=user0_avl_readdata;
							if(ddr_read_address>=ddr_endadd)ddr_read_address<=ddr_stradd;
							else ddr_read_address<=ddr_read_address+2;
							if(ddr_read_address>=ddr_endadd)ddr_ads_state<=0;
							else ddr_ads_state<=13;
						end
						
//					13:begin
//							if(ddr_read_wait>=250)
//								begin
//									ddr_ads_state<=14;
//									ddr_read_wait<=0;
//									
//								end
//							else 
//								begin
//									ddr_ads_state<=13;
//									ddr_read_wait<=ddr_read_wait+1;
//								end
//						end
					13:
						begin
							if(ddr_write_switch)ddr_ads_state<=0;
							else ddr_ads_state<=10;	
						end
					250:begin
							if(test_complete)ddr_ads_state<=0;
							else ddr_ads_state<=250;
						end
					default:begin
						ddr_read_address<=0;
						ddr_write_address<=0;
						ddr_read_wait<=0;
						user0_avl_write<=0;
						user0_avl_address<=0;
						user0_avl_writedata<=0;
						user0_avl_beginbursttransfer<=0;
						ddr_ads_state<=250;
						end
				endcase
			end
		else
			begin
				ddr_read_address<=0;
				ddr_write_address<=0;
				ddr_read_wait<=0;
				user0_avl_write<=0;
				user0_avl_address<=0;
				user0_avl_writedata<=0;
				user0_avl_beginbursttransfer<=0;
				ddr_ads_state<=250;
			end
		
	end
	
endmodule