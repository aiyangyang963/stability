`timescale 1 ns / 1 ns

module ddr_control_alarm(
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
//want to get data from ddr3---L inform before alarm data,H inform after alarm data
		input ddrL_RdStar,
		input ddrH_RdStar,
		//data to flexbus
		output reg [63:00]ddr_dat_timing=0,
		output reg ddr_timing_en=0,
		output reg [63:00]ddr_dat=0,
		output reg ddr_dat_en=0,
		output reg ddrL_read_switch=0,
      output reg ddrH_read_switch=0,
				
//		output wire[07:00]ddrL_MsecondsL,		
//		output wire[07:00]ddrL_MsecondsH,
//		output wire[07:00]ddrL_Seconds,
//		output wire[07:00]ddrL_Minutes,
//		output wire[07:00]ddrL_Hour,
//		output wire[07:00]ddrL_Date,
//		output wire[07:00]ddrL_Month,
//		output wire[07:00]ddrL_Year,
//		
//		output reg [07:00]ddrL_pkg_mun_Dataf,
//		output wire[15:00]ddrL_Ch0_Dataf_ads1,
//		output wire[15:00]ddrL_Ch1_Dataf_ads1,
//		output wire[15:00]ddrL_Ch0_Dataf_ads2,
//		output wire[15:00]ddrL_Ch1_Dataf_ads2,
//		
//		
//		output wire[07:00]ddrH_MsecondsL,		
//		output wire[07:00]ddrH_MsecondsH,
//		output wire[07:00]ddrH_Seconds,
//		output wire[07:00]ddrH_Minutes,
//		output wire[07:00]ddrH_Hour,
//		output wire[07:00]ddrH_Date,
//		output wire[07:00]ddrH_Month,
//		output wire[07:00]ddrH_Year,
//		
//		output reg [07:00]ddrH_pkg_mun_Dataf,
//		output wire[15:00]ddrH_Ch0_Dataf_ads1,
//		output wire[15:00]ddrH_Ch1_Dataf_ads1,
//		output wire[15:00]ddrH_Ch0_Dataf_ads2,
//		output wire[15:00]ddrH_Ch1_Dataf_ads2,
//incident signal		
		input incident_inform,
		input[07:00]incident_b0,
		input[07:00]incident_b1,
		input[07:00]incident_b2,
		input[07:00]incident_b3,
		
		input[03:00]ddr_alarm_enable,
		
(*syn_preserve = 1*)output wire pos_ddrL_RdStar,
(*syn_preserve = 1*)output wire pos_ddrH_RdStar
	);
	
// parameter ddrL_startadd = 0;
// parameter ddrL_endadd   = 160_000;//5 minute data=5*60*250*(64+64)=150_000--64 data--64 timing--
// parameter ddrH_startadd = 320_000;//ddrL save before alarm data,ddrH save after alarm data
// parameter ddrH_endadd   = 480_000;//

 parameter ddrL_startadd = 0;
 parameter ddrL_endadd   = 160_0;//5 minute data=5*60*250*(64+64)=150_000--64 data--64 timing--
 parameter ddrH_startadd = 320_0;//ddrL save before alarm data,ddrH save after alarm data
 parameter ddrH_endadd   = 480_0;//
 assign user0_avl_burstcount =(ddr_alarm_state==250)?0:2;
 assign user0_avl_byteenable =(ddr_alarm_state==250)?0:8'b1111_1111;//.byteenable

//-----------------------------------------------------------
//------------------alarm status detect----------------------
//-----------------------------------------------------------
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
		
(*syn_preserve = 1*) wire pos_Ch1_Dataf_en_ads1;
	edge_detect d05(
	.clk(clk),
	.signal(Ch1_Dataf_en_ads1),
	.pos_signal(pos_Ch1_Dataf_en_ads1));
	
	edge_detect d06(
	.clk(clk),
	.signal(ddrL_RdStar),
	.pos_signal(pos_ddrL_RdStar));
	edge_detect d07(
	.clk(clk),
	.signal(ddrH_RdStar),
	.pos_signal(pos_ddrH_RdStar));

  reg[07:00]pos_ddrH_RdStar_cnt,pos_ddrL_RdStar_cnt;		
  always@(posedge clk)
		begin
			if(pos_ddrH_RdStar_cnt==160)pos_ddrH_RdStar_cnt<=0;
			else if(pos_ddrH_RdStar)pos_ddrH_RdStar_cnt<=pos_ddrH_RdStar_cnt+1;
			else pos_ddrH_RdStar_cnt<=pos_ddrH_RdStar_cnt;
			
			if(pos_ddrL_RdStar_cnt==160)pos_ddrL_RdStar_cnt<=0;
			else if(pos_ddrL_RdStar)pos_ddrL_RdStar_cnt<=pos_ddrL_RdStar_cnt+1;
			else pos_ddrL_RdStar_cnt<=pos_ddrL_RdStar_cnt;
		end

(*syn_preserve = 1*)	reg alarm_incident_arrive=0;	
(*syn_preserve = 1*)	reg ddrL_strobe=1;
(*syn_preserve = 1*)	reg ddrH_strobe=0;
	always@(posedge clk)
		begin
//			if(pos_incident_b3[7]||neg_incident_b3[7]||
//				pos_incident_b3[6]||neg_incident_b3[6]||
//				pos_incident_b3[5]||neg_incident_b3[5]||
//				pos_incident_b3[4]||neg_incident_b3[4])alarm_incident_arrive<=1;
			if(pos_incident_b3[7]||
				pos_incident_b3[6]||
				pos_incident_b3[5]||
				pos_incident_b3[4])alarm_incident_arrive<=1;
			else alarm_incident_arrive<=0;
			
			if(alarm_incident_arrive)
				begin
					ddrL_strobe=0;
				   ddrH_strobe=1;
				end
			else if((ddrH_write_address==ddrH_endadd)&&(ddr_alarm_state==2))
				begin
					ddrL_strobe=1;
				   ddrH_strobe=0;
				end
			else
				begin
					ddrL_strobe=ddrL_strobe;
				   ddrH_strobe=ddrH_strobe;
				end
		end
//--------------------------------------------------------------------
//----------------ddr read and write operate--------------------------
//----------------assign ddr_MsecondsL	= ddr_dat_timing[63:56];-------		
//----------------assign ddr_MsecondsH	= ddr_dat_timing[55:48];-------
//----------------assign ddr_Seconds 	= ddr_dat_timing[47:40];-------
//----------------assign ddr_Minutes 	= ddr_dat_timing[39:32];-------
//----------------assign ddr_Hour    	= ddr_dat_timing[31:24];-------
//----------------assign ddr_Date		= ddr_dat_timing[23:16];-------
//----------------assign ddr_Month		= ddr_dat_timing[15:08];-------
//----------------assign ddr_Year		= ddr_dat_timing[07:00];-------
//
//----------------assign ddr_Ch0_Dataf_ads1 = ddr_dat[63:48];---------
//----------------assign ddr_Ch1_Dataf_ads1 = ddr_dat[47:32];---------
//----------------assign ddr_Ch0_Dataf_ads2 = ddr_dat[31:16];---------
//----------------assign ddr_Ch1_Dataf_ads2 = ddr_dat[15:00];---------
//--------------------------------------------------------------------
//--------------------------------------------------------------------
(*syn_preserve = 1*) reg [24:00]ddr_read_address,ddrL_read_address,ddrH_read_address,ddrL_read_base_address,ddrH_read_base_address;
(*syn_preserve = 1*) reg [24:00]ddr_write_address,ddrL_write_address,ddrH_write_address,ddrL_write_base_address,ddrH_write_base_address;
(*syn_preserve = 1*) wire[63:00]ads_dat_timing={ds_MsecondsL,ds_MsecondsH,ds_Seconds,ds_Minutes,ds_Hour,ds_Date,ds_Month,ds_Year};
(*syn_preserve = 1*) wire[63:00]ads_dat={Ch0_Dataf_ads1,Ch1_Dataf_ads1,Ch0_Dataf_ads2,Ch1_Dataf_ads2};
//(*syn_preserve = 1*) reg [63:00]ddr_dat_timing;
//(*syn_preserve = 1*) reg ddr_timing_en;
//(*syn_preserve = 1*) reg [63:00]ddr_dat;
//(*syn_preserve = 1*) reg ddr_dat_en;
(*syn_preserve = 1*) reg [07:00]ddr_alarm_state=250;

(*syn_preserve = 1*) reg ddr_read_switch=0;	
//(*syn_preserve = 1*) reg ddrL_read_switch=0;
//(*syn_preserve = 1*) reg ddrH_read_switch=0;
always@(posedge clk)//read buffer deep is 1k
	begin
		if(pos_ddrL_RdStar & (~pos_ddrH_RdStar))ddrL_read_switch<=1;
//		else if(ddrL_read_address>=(ddrL_read_base_address+(pos_ddrL_RdStar_cnt*1000)))ddrL_read_switch<=0;
		else if((ddr_alarm_state==0)&&(ddrL_read_address>=(pos_ddrL_RdStar_cnt*100)))ddrL_read_switch<=0;
		else ddrL_read_switch<=ddrL_read_switch;
		
		if((~pos_ddrL_RdStar) & pos_ddrH_RdStar)ddrH_read_switch<=1;
//		else if(ddrH_read_address>=(ddrH_read_base_address+(pos_ddrL_RdStar_cnt*1000)))ddrH_read_switch<=0;
		else if((ddr_alarm_state==0)&&(ddrH_read_address>=(pos_ddrH_RdStar_cnt*100)))ddrH_read_switch<=0;
		else ddrH_read_switch<=ddrH_read_switch;
		
		if((ddrL_read_switch)||(ddrH_read_switch))ddr_read_switch=1;	
		else ddr_read_switch=0;	
	end
	
(*syn_preserve = 1*) reg ddr_write_switch=0;	
(*syn_preserve = 1*) reg ddrL_write_switch=0;	
(*syn_preserve = 1*) reg ddrH_write_switch=0;	
always@(posedge clk)
	begin
		if(pos_Ch1_Dataf_en_ads1)
			begin
				if(ddrL_strobe &(~ddrH_strobe))
					begin
						ddrL_write_switch=1;
					   ddrH_write_switch=0;
						ddr_write_switch=1;
					end
				else if((~ddrL_strobe) & ddrH_strobe)
					begin
						ddrL_write_switch=0;
					   ddrH_write_switch=1;
						ddr_write_switch=1;
					end
				else
					begin
						ddrL_write_switch=ddrL_write_switch;
					   ddrH_write_switch=ddrH_write_switch;
						ddr_write_switch=ddr_write_switch;
					end
			end
		else if(ddr_alarm_state==2)
			begin
				ddrL_write_switch=0;
				ddrH_write_switch=0;
				ddr_write_switch=0;
			end
		else 
			begin
				ddrL_write_switch=ddrL_write_switch;
				ddrH_write_switch=ddrH_write_switch;
				ddr_write_switch=ddr_write_switch;
			end
	end

always@(posedge clk)
	begin
		if(ddr_alarm_enable[3])
			begin
				case(ddr_alarm_state)
					0:begin//burst 2 write
						ddr_dat_en<=0;
						if(user0_avl_waitrequest & ddr_write_switch)
							begin
								user0_avl_write<=1;
								user0_avl_beginbursttransfer<=1;
								if(ddrL_write_switch)user0_avl_address<=ddrL_write_address;
								else if(ddrH_write_switch)user0_avl_address<=ddrH_write_address;
								else user0_avl_address<=user0_avl_address;
								user0_avl_writedata<=ads_dat_timing;
								ddr_alarm_state<=1;
							end
						else
							begin
								user0_avl_write<=0;
								user0_avl_beginbursttransfer<=0;
								user0_avl_address<=user0_avl_address;
								user0_avl_writedata<=0;
								ddr_alarm_state<=0;
							end
							
						end
					1:begin
							user0_avl_writedata<=ads_dat;
							user0_avl_beginbursttransfer<=0;
							ddr_alarm_state<=2;
						end
					2:begin//judgement if systerm have alarm or release alarm
						if(ddr_read_switch)
							begin
								ddr_alarm_state<=3;
							end
						else
							begin
								ddr_alarm_state<=0;
							end
						if(ddrL_write_switch)
							begin
								if(ddrL_write_address>=ddrL_endadd)ddrL_write_address<=ddrL_startadd;
								else ddrL_write_address<=ddrL_write_address+2;
							end
						else if(ddrH_write_switch)
							begin
								if(ddrH_write_address>=ddrH_endadd)ddrH_write_address<=ddrH_startadd;
								else ddrH_write_address<=ddrH_write_address+2;
							end
						else
							begin
								ddrL_write_address<=ddrL_write_address;
								ddrH_write_address<=ddrH_write_address;
							end
						user0_avl_write<=0;
						user0_avl_writedata<=0;
						user0_avl_beginbursttransfer<=0;
						end
					3://wait in order to clear ddr_read_switch
						begin
							if(ddr_read_switch)ddr_alarm_state<=10;
							else ddr_alarm_state<=0;
						end
					10:begin//burst 2 read about 30 second
							if(user0_avl_waitrequest)
								begin
									user0_avl_read<=1;
									user0_avl_beginbursttransfer<=1;
									if(ddrL_read_switch)user0_avl_address<=ddrL_read_address;
									else if(ddrH_read_switch)user0_avl_address<=ddrH_read_address;
									else user0_avl_address<=ddr_read_address;
									ddr_alarm_state<=11;
								end
							else
								begin
									user0_avl_read<=0;
									user0_avl_beginbursttransfer<=0;
									user0_avl_address<=user0_avl_address;
									ddr_alarm_state<=10;
								end
						end
					11:begin
							user0_avl_read<=0;
							user0_avl_beginbursttransfer<=0;
							if(user0_avl_readdatavalid)
								begin
									ddr_dat_timing<=user0_avl_readdata;
									ddr_timing_en <=1;
									ddr_alarm_state<=12;
								end
							else
								begin
									ddr_dat_timing<=ddr_dat_timing;
									ddr_timing_en <=0;
									ddr_alarm_state<=11;
								end
						end
					12:begin
							ddr_dat<=user0_avl_readdata;
							ddr_dat_en<=1;
							if(ddrL_read_switch)
								begin
									if(ddrL_read_address>=ddrL_endadd)
										begin
											ddrL_read_address<=ddrL_startadd;
											ddrL_read_base_address<=ddrL_startadd;
										end
										
									else if(ddrL_read_address>=(ddrL_read_base_address+(pos_ddrL_RdStar_cnt*100)))
										begin
											ddrL_read_address<=(ddrL_read_base_address+(pos_ddrL_RdStar_cnt*100));
											ddrL_read_base_address<=(ddrL_read_base_address+(pos_ddrL_RdStar_cnt*100));
										end
									else
										begin
											ddrL_read_address<=ddrL_read_address+2;
											ddrL_read_base_address<=ddrL_read_base_address;
										end
								end
							else if(ddrH_read_switch)
								begin
									if(ddrH_read_address>=ddrH_endadd)
										begin
											ddrH_read_address<=ddrH_startadd;
											ddrH_read_base_address<=ddrH_startadd;
										end
										
									else if(ddrH_read_address>=(ddrH_read_base_address+(pos_ddrH_RdStar_cnt*100)))
										begin
											ddrH_read_address<=(ddrH_read_base_address+(pos_ddrH_RdStar_cnt*100));
											ddrH_read_base_address<=(ddrH_read_base_address+(pos_ddrH_RdStar_cnt*100));
										end
									else
										begin
											ddrH_read_address<=ddrH_read_address+2;
											ddrH_read_base_address<=ddrH_read_base_address;
										end
								end
							else
								begin
									ddrH_read_address<=ddrH_read_address;
									ddrH_read_base_address<=ddrH_read_base_address;
								end
								
							if(ddrL_read_switch)
								begin
									if(ddrL_read_address>=(ddrL_read_base_address+(pos_ddrL_RdStar_cnt*100)))ddr_alarm_state<=0;
									else ddr_alarm_state<=13;
								end
							else if(ddrH_read_switch)
								begin
									if(ddrH_read_address>=(ddrH_read_base_address+(pos_ddrH_RdStar_cnt*100)))ddr_alarm_state<=0;
									else ddr_alarm_state<=13;
								end
							else ddr_alarm_state<=ddr_alarm_state;
							
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
							if(ddr_write_switch)ddr_alarm_state<=0;
							else ddr_alarm_state<=10;	
							ddr_dat_en<=0;
						end
					250:begin
							if(test_complete)ddr_alarm_state<=0;
							else ddr_alarm_state<=250;
						end
					default:begin
						ddr_read_address<=0;
						ddr_write_address<=0;
						user0_avl_write<=0;
						user0_avl_address<=0;
						user0_avl_writedata<=0;
						user0_avl_beginbursttransfer<=0;
						ddr_alarm_state<=250;
						end
				endcase
			end
		else
			begin
				ddr_read_address<=0;
				ddr_write_address<=0;
				user0_avl_address<=0;
				user0_avl_writedata<=0;
				user0_avl_beginbursttransfer<=0;
				ddr_alarm_state<=250;
			end
		
	end	
endmodule