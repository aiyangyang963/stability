`timescale 1ns / 1ns

module uart_control(
		 input clk,
		 input rst,
		 
		 input to_uart_ready,
		 output reg to_uart_valid,
		 output reg[7:0]to_uart_data,
		 
		 input from_uart_valid,
		 input [7:0]from_uart_data,
		 
		 output reg [7:0]tx_state,
		 
		 input [7:0]ALARM_Overview_Tflag_ads1,
		 input [7:0]ALARM_Ch03_Tfag_ads1,
		 input [7:0]ALARM_Ch03_Aflag_ads1,
		 input [15:0]Ch0_Data_ads1,
		 input [15:0]Ch1_Data_ads1,
		 input [15:0]Ch2_Data_ads1,
		 input [15:0]Ch3_Data_ads1,
		 
		 input [7:0]ALARM_Overview_Tflag_ads2,
		 input [7:0]ALARM_Ch03_Tfag_ads2,
		 input [7:0]ALARM_Ch03_Aflag_ads2,
		 input [15:0]Ch0_Data_ads2,
		 input [15:0]Ch1_Data_ads2,
		 input [15:0]Ch2_Data_ads2,
		 input [15:0]Ch3_Data_ads2,
		 
		 input Ch0_Data_en_ads2,
		 input Ch1_Data_en_ads2,
		 input Ch2_Data_en_ads2,
		 input Ch3_Data_en_ads2,
		 
		 input [55:0]Ch0_Dataf_ads2,
		 input Ch0_Dataf_en_ads2,
		 
		 output reg[24:0]ddr_add,
		 output reg [7:0]ddr_op,
		 
		 output reg [7:0]time_message_cnt,
		 output reg [7:0]year,
		 output reg [7:0]month,
		 output reg [7:0]day,
		 output reg [7:0]hour,
		 output reg [7:0]minute,
		 output reg [7:0]second,
		 
		 output reg ds3231_write_start,
		 input 		ds3231_write_over,
		 output reg [47:0]ds3231_write_dat,
		 output reg [07:0]control_infor,//from k64 control information
		 
		 input incident_inform,
		 input[7:0]incident_b0,
		 input[7:0]incident_b1,
		 input[7:0]incident_b2,
		 input[7:0]incident_b3
		 );
					 
					 
//send ads2 data to uart
 wire [7:0]dat_temp_00 = ALARM_Overview_Tflag_ads2;
 wire [7:0]dat_temp_01 = ALARM_Ch03_Tfag_ads2;
 wire [7:0]dat_temp_02 = ALARM_Ch03_Aflag_ads2;
 wire [7:0]dat_temp_03 = Ch0_Data_ads2[7:0];
 wire [7:0]dat_temp_04 = Ch0_Data_ads2[15:8];
 wire [7:0]dat_temp_05 = Ch1_Data_ads2[7:0];
 wire [7:0]dat_temp_06 = Ch1_Data_ads2[15:8];
 wire [7:0]dat_temp_07 = Ch2_Data_ads2[7:0];
 wire [7:0]dat_temp_08 = Ch2_Data_ads2[15:8];
 wire [7:0]dat_temp_09 = Ch3_Data_ads2[7:0];
 wire [7:0]dat_temp_0a = Ch3_Data_ads2[15:8];
 
 wire [7:0]dat_temp_0b = ALARM_Overview_Tflag_ads1;
 wire [7:0]dat_temp_0c = ALARM_Ch03_Tfag_ads1;
 wire [7:0]dat_temp_0d = ALARM_Ch03_Aflag_ads1;
 wire [7:0]dat_temp_0e = Ch0_Data_ads1[7:0];
 wire [7:0]dat_temp_0f = Ch0_Data_ads1[15:8];
 wire [7:0]dat_temp_10 = Ch1_Data_ads1[7:0];
 wire [7:0]dat_temp_11 = Ch1_Data_ads1[15:8];
 wire [7:0]dat_temp_12 = Ch2_Data_ads1[7:0];
 wire [7:0]dat_temp_13 = Ch2_Data_ads1[15:8];
 wire [7:0]dat_temp_14 = Ch3_Data_ads1[7:0];
 wire [7:0]dat_temp_15 = Ch3_Data_ads1[15:8];
 
 wire [7:0]dat_temp_16 = 8'haa;
//send data control signal edge detect					 
wire 	pos_to_uart_ready,neg_to_uart_ready;
reg to_uart_ready_r0,to_uart_ready_r1,to_uart_ready_r2;
always@(posedge clk)
	begin
		to_uart_ready_r0<=to_uart_ready;
		to_uart_ready_r1<=to_uart_ready_r0;
		to_uart_ready_r2<=to_uart_ready_r1;
	end

assign pos_to_uart_ready=(~to_uart_ready_r2)&to_uart_ready_r1;
assign neg_to_uart_ready=to_uart_ready_r2&(~to_uart_ready_r1);   

wire pos_to_uart_valid,neg_to_uart_valid;
reg to_uart_valid_r0,to_uart_valid_r1,to_uart_valid_r2;
always@(posedge clk)
	begin
		to_uart_valid_r0<=to_uart_valid;
		to_uart_valid_r1<=to_uart_valid_r0;
		to_uart_valid_r2<=to_uart_valid_r1;
	end

assign pos_to_uart_valid=(~to_uart_valid_r2)&to_uart_valid_r1;
assign neg_to_uart_valid=to_uart_valid_r2&(~to_uart_valid_r1);    
//receive data control signal edge detect
wire pos_from_uart_valid,neg_from_uart_valid;
reg from_uart_valid_r0,from_uart_valid_r1,from_uart_valid_r2;
always@(posedge clk)
	begin
		from_uart_valid_r0<=from_uart_valid;
		from_uart_valid_r1<=from_uart_valid_r0;
		from_uart_valid_r2<=from_uart_valid_r1;
	end

assign pos_from_uart_valid=(~from_uart_valid_r2)&from_uart_valid_r1;
assign neg_from_uart_valid=from_uart_valid_r2&(~from_uart_valid_r1); 

//ds3231 control signal edge detect
wire 	pos_ds3231_write_over,neg_ds3231_write_over;
reg ds3231_write_over_r0,ds3231_write_over_r1,ds3231_write_over_r2;
always@(posedge clk)
	begin
		ds3231_write_over_r0<=ds3231_write_over;
		ds3231_write_over_r1<=ds3231_write_over_r0;
		ds3231_write_over_r2<=ds3231_write_over_r1;
	end

assign pos_ds3231_write_over=(~ds3231_write_over_r2)&ds3231_write_over_r1;
assign neg_ds3231_write_over=ds3231_write_over_r2&(~ds3231_write_over_r1);  


wire 	pos_Ch0_Data_en_ads2,neg_Ch0_Data_en_ads2;
reg pos_Ch0_Data_en_ads2_r0,Ch0_Data_en_ads2_r0,Ch0_Data_en_ads2_r1,Ch0_Data_en_ads2_r2;
always@(posedge clk)
	begin
		Ch0_Data_en_ads2_r0<=Ch0_Data_en_ads2;
		Ch0_Data_en_ads2_r1<=Ch0_Data_en_ads2_r0;
		Ch0_Data_en_ads2_r2<=Ch0_Data_en_ads2_r1;
		pos_Ch0_Data_en_ads2_r0<=pos_Ch0_Data_en_ads2;
	end

assign pos_Ch0_Data_en_ads2=(~Ch0_Data_en_ads2_r2)&Ch0_Data_en_ads2_r1;
assign neg_Ch0_Data_en_ads2=Ch0_Data_en_ads2_r2&(~Ch0_Data_en_ads2_r1);  

wire 	pos_Ch0_Dataf_en_ads2,neg_Ch0_Dataf_en_ads2;
reg Ch0_Dataf_en_ads2_r0,Ch0_Dataf_en_ads2_r1,Ch0_Dataf_en_ads2_r2;
always@(posedge clk)
	begin
		Ch0_Dataf_en_ads2_r0<=Ch0_Dataf_en_ads2;
		Ch0_Dataf_en_ads2_r1<=Ch0_Dataf_en_ads2_r0;
		Ch0_Dataf_en_ads2_r2<=Ch0_Dataf_en_ads2_r1;
	end

assign pos_Ch0_Dataf_en_ads2=(~Ch0_Dataf_en_ads2_r2)&Ch0_Dataf_en_ads2_r1;
assign neg_Ch0_Dataf_en_ads2=Ch0_Dataf_en_ads2_r2&(~Ch0_Dataf_en_ads2_r1); 
//reg [7:0]tx_state;	
reg [7:0]to_uart_data_cnt=0;	
reg [7:0]ddr_add_cnt=5;
reg [7:0]ds3231_wr_cnt=9;
reg [7:0]ds3231_rd_cnt=2;

reg ds3231_read_start=0;
reg [7:0]ds3231_read_add=0;
wire ds3231_read_over;

reg Ch0_Data_ads2_flag=0;
reg [15:0]Ch0_Data_ads2_read_delay=0;

reg[7:0]fdata_cnt;
reg[7:0]data_cnt;
reg[7:0]incident_cnt;

always@(posedge clk)
	begin
		if(~rst)
			begin
				case(tx_state)
						0:begin
							if(from_uart_data==8'h01)tx_state<=1;//read dat_temp
							else if(from_uart_data==8'h11)
								begin
									if(from_uart_valid)tx_state<=10;//ddr operation
									else tx_state<=0;
								end
							else if(from_uart_data==8'hE0)
								begin
									if(from_uart_valid)tx_state<=20;//K64 to FPGA package
									else tx_state<=0;
								end
							else if(from_uart_data==8'h33)
								begin
									if(from_uart_valid)tx_state<=25;
									else tx_state<=0;
								end
							else if(from_uart_data==8'h44)//read Ch0_Data_ads2 to uart							
								begin
									if(from_uart_valid)tx_state<=30;
									else tx_state<=0;
								end
							else if(from_uart_data==8'h55)//read filter out
								begin
									if(from_uart_valid)tx_state<=40;
									else tx_state<=0;
								end
							else if(incident_inform)
								begin
									tx_state<=50;
								end
							else tx_state <=0;
							ddr_add		  <=ddr_add;
							ds3231_write_start<=0;
							ds3231_write_dat  <=ds3231_write_dat;
							
							ds3231_read_start<=0;
							ds3231_read_add  <=0;
							
							to_uart_valid = 0;
							  end
						1:begin
							//send data to uart
							if((to_uart_ready)&&((to_uart_data_cnt<8'h16)))to_uart_valid = 1;
							else to_uart_valid = 0;
							//receive time message from uart
							if(time_message_cnt==0)
								begin
									time_message_cnt<=7;
									tx_state<=0;
								end
							else
								begin
									if(pos_from_uart_valid)time_message_cnt<=time_message_cnt-1;
									else	time_message_cnt	<=time_message_cnt;
									if(from_uart_valid)
										begin
											case(time_message_cnt)
												6:year	<=from_uart_data;
												5:month	<=from_uart_data;
												4:day		<=from_uart_data;
												3:hour	<=from_uart_data;
												2:minute	<=from_uart_data;
												1:second	<=from_uart_data;
												default:
													begin
														year	<=year;
														month	<=month;
														day	<=day;
														hour	<=hour;
														minute<=minute;
														second<=second;
													end 
											endcase
										end
									else 
										begin
											year	<=year;
											month	<=month;
											day	<=day;
											hour	<=hour;
											minute<=minute;
											second<=second;
										end
									tx_state<=1;
								end
							  end

							  
						10:begin
								if(ddr_add_cnt==0)
									begin
										ddr_add_cnt<=5;
										tx_state<=0;
									end
								else
									begin
										if(pos_from_uart_valid)ddr_add_cnt<=ddr_add_cnt-1;
										else	ddr_add_cnt	<=ddr_add_cnt;
										if(from_uart_valid)
											begin
												case(ddr_add_cnt)
													5:ddr_add			<=ddr_add;
													4:ddr_op				<=from_uart_data;
													3:ddr_add[7:0]		<=from_uart_data;
													2:ddr_add[15:8]	<=from_uart_data;
													1:ddr_add[23:16]	<=from_uart_data;
													0:ddr_add			<=ddr_add;
													default:ddr_add	<=ddr_add;
												endcase
											end
										else ddr_add	<=ddr_add;
										tx_state<=10;
									end
							end
						20:begin
								if(ds3231_wr_cnt==0)
									begin
//										if(ds3231_write_over)
//											begin
//												ds3231_write_start<=0;
//												tx_state<=0;
//												ds3231_wr_cnt<=7;
//											end 
//										else 
//											begin
//												ds3231_write_start<=1;
//												tx_state<=20;
//												ds3231_wr_cnt<=0;
//											end
										ds3231_wr_cnt<=9;
										if(control_infor[0])
											begin
												ds3231_write_start<=1;
												tx_state<=21;
											end
										else
											begin
												ds3231_write_start<=0;
												tx_state<=0;
											end
									end
								else
									begin
										if(pos_from_uart_valid)ds3231_wr_cnt<=ds3231_wr_cnt-1;
										else	ds3231_wr_cnt	<=ds3231_wr_cnt;
										if(from_uart_valid)
											begin
												case(ds3231_wr_cnt)
													9:ds3231_write_dat<=ds3231_write_dat;
													2:ds3231_write_dat[47:40]<=from_uart_data;
													3:ds3231_write_dat[39:32]<=from_uart_data;
													4:ds3231_write_dat[31:24]<=from_uart_data;
													5:ds3231_write_dat[23:16]<=from_uart_data;
													6:ds3231_write_dat[15:08]<=from_uart_data;
													7:ds3231_write_dat[07:00]<=from_uart_data;
													8:control_infor			 <=from_uart_data;
													1:ds3231_write_dat<=ds3231_write_dat;
													default:ds3231_write_dat<=ds3231_write_dat;
												endcase
											end
										else ds3231_write_dat<=ds3231_write_dat;
										tx_state<=20;
									end
							end
						21:
							begin
								if(ds3231_write_over)
									begin
										ds3231_write_start<=0;
										tx_state<=0;
									end
								else
									begin
										ds3231_write_start<=1;
										tx_state<=21;
									end
							end
						
						25:begin
								if(ds3231_rd_cnt==0)
									begin
										if(ds3231_read_over)
											begin
												ds3231_read_start<=0;
												tx_state<=0;
												ds3231_rd_cnt<=2;
											end 
										else 
											begin
												ds3231_read_start<=1;
												tx_state<=25;
												ds3231_rd_cnt<=0;
											end
											
									end
								else
									begin
										if(pos_from_uart_valid)ds3231_rd_cnt<=ds3231_rd_cnt-1;
										else	ds3231_rd_cnt	<=ds3231_rd_cnt;
										if(from_uart_valid)
											begin
												case(ds3231_rd_cnt)
													2:ds3231_read_add<=ds3231_read_add;
													1:ds3231_read_add<=from_uart_data;
													0:ds3231_read_add<=ds3231_read_add;
													default:ds3231_read_add<=ds3231_read_add;
												endcase
											end
										else ds3231_read_add<=ds3231_read_add;
										tx_state<=25;
									end
							end
						30:
							begin
								if((to_uart_ready)&&(pos_Ch0_Data_en_ads2))tx_state<=31;				
								else tx_state<=30;
							end
						31:begin
								if(data_cnt==2)
									begin
										to_uart_valid = 0;
										data_cnt<=0;
										tx_state<=30;
									end
								else
									begin
										to_uart_valid = 1;
										data_cnt<=data_cnt+1;
										tx_state<=31;
									end
							end
						40:
							begin
								if((to_uart_ready)&&(pos_Ch0_Dataf_en_ads2))tx_state<=41;				
								else tx_state<=40;
							end
						41:begin
								if(fdata_cnt==7)
									begin
										to_uart_valid = 0;
										fdata_cnt<=0;
										tx_state<=40;
									end
								else
									begin
										to_uart_valid = 1;
										fdata_cnt<=fdata_cnt+1;
										tx_state<=41;
									end
							end
						50:
							begin
								if(to_uart_ready)tx_state<=51;
								else tx_state<=50;
							end
						51:
							begin
								if(incident_cnt==4)
									begin
										to_uart_valid = 0;
										incident_cnt<=0;
										tx_state<=0;
									end
								else
									begin
										to_uart_valid = 1;
										incident_cnt<=incident_cnt+1;
										tx_state<=51;
									end
							end
						default:begin
									tx_state				<=0;
									to_uart_valid		<=0;
									ddr_add_cnt			<=5;
									ddr_add				<=0;
									
									ds3231_write_start<=0;
									ds3231_wr_cnt		<=9;
									ds3231_write_dat  <=ds3231_write_dat;
									
									ds3231_read_start<=0;
									ds3231_rd_cnt	  <=2;
									ds3231_read_add  <=0;
									
									time_message_cnt	<=7;
									year		<=0;
									month		<=0;
									day		<=0;
									hour		<=0;
									minute	<=0;
									second	<=0;
									
									incident_cnt<=0;
									fdata_cnt<=0;
									data_cnt<=0;
							  end
				endcase
			end
		else
			begin
				tx_state				<=0;
				to_uart_valid		<=0;
				ddr_add_cnt			<=5;
				ddr_add				<=0;
				
				ds3231_write_start<=0;
				ds3231_wr_cnt		<=9;
				
				ds3231_read_start<=0;
				ds3231_rd_cnt	  <=2;
				ds3231_read_add  <=0;
									
				time_message_cnt	<=7;
				year		<=0;
				month		<=0;
				day		<=0;
				hour		<=0;
				minute	<=0;
				second	<=0;
				
				incident_cnt<=0;
				fdata_cnt<=0;
				data_cnt<=0;
			end
	end					 

always@(posedge clk)
	begin
		if (to_uart_data_cnt==8'h16)
			begin
				if(tx_state==1)to_uart_data_cnt<=to_uart_data_cnt;
				else to_uart_data_cnt<=0;
				to_uart_data<=dat_temp_00;
			end
		else if ((to_uart_valid)&&(tx_state==1))
			begin
				to_uart_data_cnt<=to_uart_data_cnt+1;
				case(to_uart_data_cnt)
					8'h00:to_uart_data<=dat_temp_01;
					8'h01:to_uart_data<=dat_temp_02;
					8'h02:to_uart_data<=dat_temp_03;
					8'h03:to_uart_data<=dat_temp_04;
					8'h04:to_uart_data<=dat_temp_05;
					8'h05:to_uart_data<=dat_temp_06;
					8'h06:to_uart_data<=dat_temp_07;
					8'h07:to_uart_data<=dat_temp_08;
					8'h08:to_uart_data<=dat_temp_09;
					8'h09:to_uart_data<=dat_temp_0a;
					8'h0a:to_uart_data<=dat_temp_0b;
					
					8'h0b:to_uart_data<=dat_temp_0c;
					8'h0c:to_uart_data<=dat_temp_0d;
					8'h0d:to_uart_data<=dat_temp_0e;
					8'h0e:to_uart_data<=dat_temp_0f;
					8'h0f:to_uart_data<=dat_temp_10;
					8'h10:to_uart_data<=dat_temp_11;
					8'h11:to_uart_data<=dat_temp_12;
					8'h12:to_uart_data<=dat_temp_13;
					8'h13:to_uart_data<=dat_temp_14;
					8'h14:to_uart_data<=dat_temp_15;
					8'h15:to_uart_data<=dat_temp_16;
					default:to_uart_data<=to_uart_data;
				endcase
			end
		else if(tx_state==31)
			begin
				case(data_cnt)
					0:to_uart_data<=Ch0_Data_ads2[ 7:0];
					1:to_uart_data<=Ch0_Data_ads2[15:8];
					default:to_uart_data<=to_uart_data;
				endcase
			end
		else if(tx_state==41)
			begin
				case(fdata_cnt)
					0:to_uart_data<=Ch0_Dataf_ads2[ 7:0];
					1:to_uart_data<=Ch0_Dataf_ads2[15:8];
					2:to_uart_data<=Ch0_Dataf_ads2[23:16];
					3:to_uart_data<=Ch0_Dataf_ads2[31:24];
					4:to_uart_data<=Ch0_Dataf_ads2[39:32];
					5:to_uart_data<=Ch0_Dataf_ads2[47:40];
					6:to_uart_data<=Ch0_Dataf_ads2[55:48];
					default:to_uart_data<=to_uart_data;
				endcase
			end
		else if(tx_state==51)
			begin
				case(incident_cnt)
					0:to_uart_data<=incident_b0;
					1:to_uart_data<=incident_b1;
					2:to_uart_data<=incident_b2;
					3:to_uart_data<=incident_b3;
					default:to_uart_data<=to_uart_data;
				endcase
			end
		else 
			begin
				to_uart_data<=to_uart_data;
				to_uart_data_cnt<=to_uart_data_cnt;
			end
	end	
	
endmodule
