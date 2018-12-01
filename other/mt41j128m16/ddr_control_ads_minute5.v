`timescale 1 ns / 1 ns
module ddr_control_ads_minute5(
		input clk,
		input clk_50m,
		input test_complete,
		
		output reg [24:0]  user0_avl_address,              //user0_avl.address
		output reg         user0_avl_write,                //.write
		output reg         user0_avl_read,                 //.read
		input  wire[63:0]  user0_avl_readdata,             //.readdata
		output reg [63:0]  user0_avl_writedata,            //.writedata
		output reg         user0_avl_beginbursttransfer,   //.beginbursttransfer
		output wire[3:0]   user0_avl_burstcount,           //.burstcount
		output wire[7:0]   user0_avl_byteenable,           //.byteenable
		input  wire        user0_avl_readdatavalid,        //.readdatavalid
		input  wire        user0_avl_waitrequest,          //.waitrequest_n
		
		input 	  [24:0]	 user0_ddr_add,
		input 				 ads_minute5_enable,
		input 				 user0_ddr_disable,
		input 				 user0_takeout_datvalid,
		
		input 	  [63:0]  user0_ads_dat,
		input 	  [3:0]   user0_ads_dat_en,
		
		output reg [63:0]	 takeout_dat
	);
 parameter ddr_baseadd_ads1ch2 = 25'h000_0000;//block1
 parameter ddr_endadd_ads1ch2  = 25'h03f_ffff;//block1
 parameter ddr_baseadd_ads1ch3 = 25'h040_0000;//block2
 parameter ddr_endadd_ads1ch3  = 25'h07f_ffff;//block2
 parameter ddr_baseadd_ads2ch2 = 25'h080_0000;//block3
 parameter ddr_endadd_ads2ch2  = 25'h0bf_ffff;//block3
 parameter ddr_baseadd_ads2ch3 = 25'h0c0_0000;//block4	
 parameter ddr_endadd_ads2ch3  = 25'h0ff_ffff;//block4
 
 parameter read_ddr_stradd	    = 25'h000_0000;//block4
 parameter read_ddr_endadd	    = 25'h100_0000;//block4	
assign user0_avl_burstcount=1;         		//.burstcount
assign user0_avl_byteenable=8'b1111_1111;  //.byteenable
//----------save 4 channel ads data into ddr 4 equality block---------------//	
////////////search posedge of control signal
 wire pos_ads_minute5_enable,neg_ads_minute5_enable;
 reg ads_minute5_enable_r0,ads_minute5_enable_r1,ads_minute5_enable_r2;
 always@(posedge clk)
	begin
		ads_minute5_enable_r0<=ads_minute5_enable;
		ads_minute5_enable_r1<=ads_minute5_enable_r0;
		ads_minute5_enable_r2<=ads_minute5_enable_r1;
	end
	assign pos_ads_minute5_enable=(~ads_minute5_enable_r2)&ads_minute5_enable_r1;
	assign neg_ads_minute5_enable=ads_minute5_enable_r2&(~ads_minute5_enable_r1);   
	
 wire pos_user0_takeout_datvalid,neg_user0_takeout_datvalid;
 reg user0_takeout_datvalid_r0,user0_takeout_datvalid_r1,user0_takeout_datvalid_r2;
 always@(posedge clk)
	begin
		user0_takeout_datvalid_r0<=user0_takeout_datvalid;
		user0_takeout_datvalid_r1<=user0_takeout_datvalid_r0;
		user0_takeout_datvalid_r2<=user0_takeout_datvalid_r1;
	end
	assign pos_user0_takeout_datvalid=(~user0_takeout_datvalid_r2)&user0_takeout_datvalid_r1;
	assign neg_user0_takeout_datvalid=user0_takeout_datvalid_r2&(~user0_takeout_datvalid_r1);   
	

 reg minute5_arrive;
 wire pos_minute5_arrive,neg_minute5_arrive;
 reg minute5_arrive_r0,minute5_arrive_r1,minute5_arrive_r2;
 always@(posedge clk)
	begin
		minute5_arrive_r0<=minute5_arrive;
		minute5_arrive_r1<=minute5_arrive_r0;
		minute5_arrive_r2<=minute5_arrive_r1;
	end
	assign pos_minute5_arrive=(~minute5_arrive_r2)&minute5_arrive_r1;
	assign neg_minute5_arrive=minute5_arrive_r2&(~minute5_arrive_r1);

 wire [3:0]pos_user0_ads_dat_en,neg_user0_ads_dat_en;
 reg [3:0]user0_ads_dat_en_r0,user0_ads_dat_en_r1,user0_ads_dat_en_r2;
 always@(posedge clk)
	begin
		user0_ads_dat_en_r0<=user0_ads_dat_en;
		user0_ads_dat_en_r1<=user0_ads_dat_en_r0;
		user0_ads_dat_en_r2<=user0_ads_dat_en_r1;
	end
	assign pos_user0_ads_dat_en[0]=(~user0_ads_dat_en_r2[0])&user0_ads_dat_en_r1[0];
	assign neg_user0_ads_dat_en[0]=user0_ads_dat_en_r2[0]&(~user0_ads_dat_en_r1[0]);
	assign pos_user0_ads_dat_en[1]=(~user0_ads_dat_en_r2[1])&user0_ads_dat_en_r1[1];
	assign neg_user0_ads_dat_en[1]=user0_ads_dat_en_r2[1]&(~user0_ads_dat_en_r1[1]);
	assign pos_user0_ads_dat_en[2]=(~user0_ads_dat_en_r2[2])&user0_ads_dat_en_r1[2];
	assign neg_user0_ads_dat_en[2]=user0_ads_dat_en_r2[2]&(~user0_ads_dat_en_r1[2]);
	assign pos_user0_ads_dat_en[3]=(~user0_ads_dat_en_r2[3])&user0_ads_dat_en_r1[3];
	assign neg_user0_ads_dat_en[3]=user0_ads_dat_en_r2[3]&(~user0_ads_dat_en_r1[3]);

///////////put 4 channel ads data into ddr
 reg[24:0] ddr_add_ads1ch2,ddr_add_ads1ch3,ddr_add_ads2ch2,ddr_add_ads2ch3;
 reg[63:0] ddr_dat_ads1ch2,ddr_dat_ads1ch3,ddr_dat_ads2ch2,ddr_dat_ads2ch3;
 
 reg [1:0] ddrdat_wait_cnt0,ddrdat_wait_cnt1,ddrdat_wait_cnt2,ddrdat_wait_cnt3;
 always@(posedge clk)
	begin
		if(pos_ads_minute5_enable)
			begin
				ddrdat_wait_cnt0<=0;
				ddrdat_wait_cnt1<=0;
				ddrdat_wait_cnt2<=0;
				ddrdat_wait_cnt3<=0;
			end
		else
			begin
				if(pos_user0_ads_dat_en[0])ddrdat_wait_cnt0<=ddrdat_wait_cnt0+1;
				else ddrdat_wait_cnt0<=ddrdat_wait_cnt0;
				if(pos_user0_ads_dat_en[1])ddrdat_wait_cnt1<=ddrdat_wait_cnt1+1;
				else ddrdat_wait_cnt1<=ddrdat_wait_cnt1;
				if(pos_user0_ads_dat_en[2])ddrdat_wait_cnt2<=ddrdat_wait_cnt2+1;
				else ddrdat_wait_cnt2<=ddrdat_wait_cnt2;
				if(pos_user0_ads_dat_en[3])ddrdat_wait_cnt3<=ddrdat_wait_cnt3+1;
				else ddrdat_wait_cnt3<=ddrdat_wait_cnt3;
			end
	end
	
  always@(posedge clk)
	begin
		if(pos_ads_minute5_enable)
			begin
				ddr_dat_ads1ch2<=0;
				ddr_dat_ads1ch3<=0;
				ddr_dat_ads2ch2<=0;
				ddr_dat_ads2ch3<=0;
			end
		else
			begin
				case(ddrdat_wait_cnt0)
					0:ddr_dat_ads1ch2[15: 0]<=user0_ads_dat[15: 0];
					1:ddr_dat_ads1ch2[31:16]<=user0_ads_dat[15: 0];
					2:ddr_dat_ads1ch2[47:32]<=user0_ads_dat[15: 0];
					3:ddr_dat_ads1ch2[63:48]<=user0_ads_dat[15: 0];
					default:ddr_dat_ads1ch2<=ddr_dat_ads1ch2;
				endcase
				case(ddrdat_wait_cnt1)
					0:ddr_dat_ads1ch3[15: 0]<=user0_ads_dat[31:16];
					1:ddr_dat_ads1ch3[31:16]<=user0_ads_dat[31:16];
					2:ddr_dat_ads1ch3[47:32]<=user0_ads_dat[31:16];
					3:ddr_dat_ads1ch3[63:48]<=user0_ads_dat[31:16];
					default:ddr_dat_ads1ch3<=ddr_dat_ads1ch3;
				endcase
				case(ddrdat_wait_cnt2)
					0:ddr_dat_ads2ch2[15: 0]<=user0_ads_dat[47:32];
					1:ddr_dat_ads2ch2[31:16]<=user0_ads_dat[47:32];
					2:ddr_dat_ads2ch2[47:32]<=user0_ads_dat[47:32];
					3:ddr_dat_ads2ch2[63:48]<=user0_ads_dat[47:32];
					default:ddr_dat_ads2ch2<=ddr_dat_ads2ch2;
				endcase
				case(ddrdat_wait_cnt3)
					0:ddr_dat_ads2ch3[15: 0]<=user0_ads_dat[63:48];
					1:ddr_dat_ads2ch3[31:16]<=user0_ads_dat[63:48];
					2:ddr_dat_ads2ch3[47:32]<=user0_ads_dat[63:48];
					3:ddr_dat_ads2ch3[63:48]<=user0_ads_dat[63:48];
					default:ddr_dat_ads2ch3<=ddr_dat_ads2ch3;
				endcase
			end
	end	
						
(*syn_preserve = 1*)reg [7:0] ddr_minute5_state;
always@(posedge clk)
	begin
		case(ddr_minute5_state)
				0:begin
					ddr_add_ads1ch2<=ddr_baseadd_ads1ch2;
					ddr_add_ads1ch3<=ddr_baseadd_ads1ch3;
					ddr_add_ads2ch2<=ddr_baseadd_ads2ch2;
					ddr_add_ads2ch3<=ddr_baseadd_ads2ch3;
					user0_avl_address		<=0;
					user0_avl_writedata	<=0;
					user0_avl_beginbursttransfer<=0;
					user0_avl_write<=0;
					
					if(pos_ads_minute5_enable)ddr_minute5_state<=1;
					else if(pos_user0_takeout_datvalid)ddr_minute5_state<=50;
					else ddr_minute5_state<=0;
					  end			
				1:begin
//					user0_avl_burstcount<=1;         		//.burstcount
					if		 (pos_user0_ads_dat_en!=0)ddr_minute5_state<=10;
					else ddr_minute5_state<=1;
					  end
				10:begin
					if		 (ddrdat_wait_cnt0==3)begin
						user0_avl_address		<=ddr_add_ads1ch2;
						user0_avl_writedata	<=ddr_dat_ads1ch2;
						user0_avl_write<=1;
						user0_avl_beginbursttransfer<=1;
						ddr_minute5_state<=11;end
					else if(ddrdat_wait_cnt1==3)begin
						user0_avl_address		<=ddr_add_ads1ch3;
						user0_avl_writedata	<=ddr_dat_ads1ch3;
						user0_avl_write<=1;
						user0_avl_beginbursttransfer<=1;
						ddr_minute5_state<=21;end
					else if(ddrdat_wait_cnt2==3)begin
						user0_avl_address		<=ddr_add_ads2ch2;
						user0_avl_writedata	<=ddr_dat_ads2ch2;
						user0_avl_write<=1;
						user0_avl_beginbursttransfer<=1;
						ddr_minute5_state<=31;end
					else if(ddrdat_wait_cnt3==3)begin
						user0_avl_address		<=ddr_add_ads2ch3;
						user0_avl_writedata	<=ddr_dat_ads2ch3;
						user0_avl_write<=1;
						user0_avl_beginbursttransfer<=1;
						ddr_minute5_state<=41;end
					else  							 begin
						user0_avl_address		<=user0_avl_address;
						user0_avl_writedata	<=user0_avl_writedata;
						user0_avl_write<=0;
						user0_avl_beginbursttransfer<=0;
						ddr_minute5_state<=10;end
					
					  end
				11:begin
					user0_avl_beginbursttransfer<=0;
					if(user0_avl_waitrequest)begin
						user0_avl_write<=0;
						ddr_minute5_state<=12;end
					else begin
						user0_avl_write<=user0_avl_write;
						ddr_minute5_state<=11;end end
				12:begin
						if		 (ddrdat_wait_cnt0==0)
							begin
								if(ddr_add_ads1ch2==ddr_endadd_ads1ch2)ddr_add_ads1ch2<=ddr_baseadd_ads1ch2;
								else ddr_add_ads1ch2<=ddr_add_ads1ch2+1;
							end
							
						else begin
							ddr_add_ads1ch2<=ddr_add_ads1ch2;
						  end
						if(user0_ddr_disable)ddr_minute5_state<=0;
						else if(user0_takeout_datvalid)ddr_minute5_state<=50;
						else if(ddrdat_wait_cnt0==0)ddr_minute5_state<=10;
						else ddr_minute5_state<=12;
						end
				21:begin
					user0_avl_beginbursttransfer<=0;
					if(user0_avl_waitrequest)begin
						user0_avl_write<=0;
						ddr_minute5_state<=22;end
					else begin
						user0_avl_write<=user0_avl_write;
						ddr_minute5_state<=21;end end
				22:begin
						if		 (ddrdat_wait_cnt1==0)
							begin
								if(ddr_add_ads1ch3==ddr_endadd_ads1ch3)ddr_add_ads1ch3<=ddr_baseadd_ads1ch3;
									else ddr_add_ads1ch3<=ddr_add_ads1ch3+1;
							end
						else begin
							ddr_add_ads1ch3<=ddr_add_ads1ch3;
						  end
						if(user0_ddr_disable)ddr_minute5_state<=0;
						else if(user0_takeout_datvalid)ddr_minute5_state<=50;
						else if(ddrdat_wait_cnt1==0)ddr_minute5_state<=10;
						else ddr_minute5_state<=22;
						end
				31:begin
					user0_avl_beginbursttransfer<=0;
					if(user0_avl_waitrequest)begin
						user0_avl_write<=0;
						ddr_minute5_state<=32;end
					else begin
						user0_avl_write<=user0_avl_write;
						ddr_minute5_state<=31;end end
				32:begin
						if		 (ddrdat_wait_cnt2==0)
							begin
								if(ddr_add_ads2ch2==ddr_endadd_ads2ch2)ddr_add_ads2ch2<=ddr_baseadd_ads2ch2;
								else ddr_add_ads2ch2<=ddr_add_ads2ch2+1;
							end
						else begin
							ddr_add_ads2ch2<=ddr_add_ads2ch2;
						  end
						if(user0_ddr_disable)ddr_minute5_state<=0;
						else if(user0_takeout_datvalid)ddr_minute5_state<=50;
						else if(ddrdat_wait_cnt2==0)ddr_minute5_state<=10;
						else ddr_minute5_state<=32;
						end
				41:begin
					user0_avl_beginbursttransfer<=0;
					if(user0_avl_waitrequest)begin
						user0_avl_write<=0;
						ddr_minute5_state<=42;end
					else begin
						user0_avl_write<=user0_avl_write;
						ddr_minute5_state<=41;end end
				42:begin
						if		 (ddrdat_wait_cnt3==0)
							begin
								if(ddr_add_ads2ch3==ddr_endadd_ads2ch3)ddr_add_ads2ch3<=ddr_baseadd_ads2ch3;
								else ddr_add_ads2ch3<=ddr_add_ads2ch3+1;
							end
						else begin
							ddr_add_ads2ch3<=ddr_add_ads2ch3;
						  end
						if(user0_ddr_disable)ddr_minute5_state<=0;
						else if(user0_takeout_datvalid)ddr_minute5_state<=50;
						else if(ddrdat_wait_cnt3==0)ddr_minute5_state<=10;
						else ddr_minute5_state<=42;
					end
//				50:
//					begin
//						user0_avl_burstcount<=8;
//						user0_avl_address<=read_ddr_stradd;
//						ddr_minute5_state<=51;
//					end
//				51:begin
//						user0_avl_beginbursttransfer<=1;
//						user0_avl_read<=1;
//						ddr_minute5_state<=52;
//					end
//				52:begin
//					user0_avl_beginbursttransfer<=0;
//					if(user0_avl_waitrequest)begin
//						user0_avl_read<=0;
//						ddr_minute5_state<=53;end
//					else begin
//						user0_avl_read<=user0_avl_read;
//						ddr_minute5_state<=52;end end
//				53:begin
//						if(user0_avl_readdatavalid)
//							begin
//								takeout_dat<=user0_avl_readdata;
//								if(user0_avl_address==read_ddr_endadd)
//									begin
//										user0_avl_address<=read_ddr_stradd;
//										ddr_minute5_state<=0;
//									end
//								else
//									begin
//										user0_avl_address<=user0_avl_address+1;
//										ddr_minute5_state<=51;
//									end
//							end
//						else
//							begin
//								takeout_dat<=takeout_dat;
//								user0_avl_address<=user0_avl_address;
//								ddr_minute5_state<=53;
//								
//							end
//					end
				default:
				  begin
						ddr_add_ads1ch2<=ddr_baseadd_ads1ch2;
						ddr_add_ads1ch3<=ddr_baseadd_ads1ch3;
						ddr_add_ads2ch2<=ddr_baseadd_ads2ch2;
						ddr_add_ads2ch3<=ddr_baseadd_ads2ch3;
						user0_avl_address		<=0;
						user0_avl_writedata	<=0;
						user0_avl_beginbursttransfer<=0;
						user0_avl_write<=0;
						ddr_minute5_state<=0;
					  end
		endcase
	end				
//-------------------5 minute pruduce module----------------------------------// 
 wire pos50m_ads_minute5_enable,neg50m_ads_minute5_enable;
 reg ads_minute5_enable_50mr0,ads_minute5_enable_50mr1,ads_minute5_enable_50mr2;
 always@(posedge clk_50m)
	begin
		ads_minute5_enable_50mr0<=ads_minute5_enable;
		ads_minute5_enable_50mr1<=ads_minute5_enable_50mr0;
		ads_minute5_enable_50mr2<=ads_minute5_enable_50mr1;
	end
assign pos50m_ads_minute5_enable=(~ads_minute5_enable_50mr2)&ads_minute5_enable_50mr1;
assign neg50m_ads_minute5_enable=ads_minute5_enable_50mr2&(~ads_minute5_enable_50mr1);   
	
 reg [15:0]timecnt_ads;
 reg [7:0]minute_ads,second_ads;
 reg [15:0]msecond_ads;
 always @(posedge clk_50m)
	begin
		if(minute_ads==5)minute5_arrive<=1;
		else	minute5_arrive<=0;
	end
 
 always @(posedge clk_50m)
	begin
		if(pos50m_ads_minute5_enable)
			begin
				minute_ads	<=0;
				second_ads	<=0;
				msecond_ads <=0;
				timecnt_ads	<=0;
			end
		else
			begin
				if(minute_ads==5)
					begin
						minute_ads	<=minute_ads;
					end
				else
					begin
						if(second_ads==59)
							begin
								minute_ads<=minute_ads+1;
								second_ads<=0;
							end
						else
							begin
								minute_ads<=minute_ads;
								if(msecond_ads==999)
									begin
										second_ads<=second_ads+1;
										msecond_ads<=0;
									end
								else
									begin
										second_ads<=second_ads;//50_000*20ns=1ms--50Mhz clock
										if(timecnt_ads==50_000)
											begin
												msecond_ads<=msecond_ads+1;
												timecnt_ads<=0;
											end
										else
											begin
												msecond_ads<=msecond_ads;
												timecnt_ads<=timecnt_ads+1;
											end
									end
							end
					end
			end
	end
	
endmodule