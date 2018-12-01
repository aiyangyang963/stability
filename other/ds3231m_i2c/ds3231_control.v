`timescale 1 ns / 1 ns
module ds3231_control
	(
		input rst,
		input clk,
		input clk_50m,
		
		input write_start_uart,
		output reg write_over_uart,
		input [47:0]write_dat_uart,
		
		output reg[47:0]read_dat_uart,
		output wire read_over_uart,
		
		output reg write_start,
		input write_over,
		output reg[7:0]write_add,
		output reg [7:0]write_dat,
		
		output reg read_start,
		input read_over,
		output reg [7:0]read_add,
		input [7:0]read_dat,

		output wire [7:0]ds_MsecondsL,		
		output wire [7:0]ds_MsecondsH,
		output wire [7:0]ds_Seconds,
		output wire [7:0]ds_Minutes,
		output wire [7:0]ds_Hour,
		output wire [7:0]ds_Date,
		output wire [7:0]ds_Month,
		output wire [7:0]ds_Year);

wire 	pos_write_start_uart,neg_write_start_uart;
reg write_start_uart_r0,write_start_uart_r1,write_start_uart_r2;
always@(posedge clk)
	begin
		write_start_uart_r0<=write_start_uart;
		write_start_uart_r1<=write_start_uart_r0;
		write_start_uart_r2<=write_start_uart_r1;
	end

assign pos_write_start_uart=(~write_start_uart_r2)&write_start_uart_r1;
assign neg_write_start_uart=write_start_uart_r2&(~write_start_uart_r1);   

wire 	pos_read_over,neg_read_over;
wire 	pos_write_over,neg_write_over;
reg read_over_r0,read_over_r1,read_over_r2;
reg write_over_r0,write_over_r1,write_over_r2;
always@(posedge clk)
	begin
		read_over_r0<=read_over;
		read_over_r1<=read_over_r0;
		read_over_r2<=read_over_r1;
		write_over_r0<=write_over;
		write_over_r1<=write_over_r0;
		write_over_r2<=write_over_r1;
	end

assign pos_read_over=(~read_over_r2)&read_over_r1;
assign neg_read_over=read_over_r2&(~read_over_r1);   
assign pos_write_over=(~write_over_r2)&write_over_r1;
assign neg_write_over=write_over_r2&(~write_over_r1); 

assign ds_Seconds 	=read_temp_00;
assign ds_Minutes 	=read_temp_01;
assign ds_Hour    	=read_temp_02;
assign ds_Date    	=read_temp_04;
assign ds_Month   	=read_temp_05;
assign ds_Year    	=read_temp_06;	
assign ds_MsecondsH  =msecond_r[15:8];
assign ds_MsecondsL  =msecond_r[ 7:0];	

reg [15:0]timecnt,msecond_r;
always @ (posedge clk_50m)
begin
	if(write_over_uart)
		begin
			msecond_r<=0;
			timecnt<=0;
		end
	else
		begin
			if(msecond_r>=999)
				begin
					msecond_r<=0;
					timecnt<=0;
				end
			else
				begin
					if(timecnt>=50_000)//50_000*20ns=1ms--50Mhz clock
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
														
(* syn_preserve = 1 *) reg [7:0]read_temp_00=0;
(* syn_preserve = 1 *) reg [7:0]read_temp_01=0;
(* syn_preserve = 1 *) reg [7:0]read_temp_02=0;
(* syn_preserve = 1 *) reg [7:0]read_temp_03=0;
(* syn_preserve = 1 *) reg [7:0]read_temp_04=0;
(* syn_preserve = 1 *) reg [7:0]read_temp_05=0;
(* syn_preserve = 1 *) reg [7:0]read_temp_06=0;

 always @ (posedge clk)
	begin
		read_dat_uart <={read_temp_06,read_temp_05,read_temp_04,read_temp_02,read_temp_01,read_temp_00};
		if(read_over)
			begin
				case(read_add)
					0:read_temp_00<=read_dat;
					1:read_temp_01<=read_dat;
					2:read_temp_02<=read_dat;
					3:read_temp_03<=read_dat;
					4:read_temp_04<=read_dat;
					5:read_temp_05<=read_dat;
					6:read_temp_06<=read_dat;
					default:
						begin
							read_temp_00<=read_temp_00;
							read_temp_01<=read_temp_01;
							read_temp_02<=read_temp_02;
							read_temp_03<=read_temp_03;
							read_temp_04<=read_temp_04;
							read_temp_05<=read_temp_05;
							read_temp_06<=read_temp_06;
						end
				endcase		
			end
		else
			begin
				read_temp_00<=read_temp_00;
				read_temp_01<=read_temp_01;
				read_temp_02<=read_temp_02;
				read_temp_03<=read_temp_03;
				read_temp_04<=read_temp_04;
				read_temp_05<=read_temp_05;
				read_temp_06<=read_temp_06;
			end
	end
 
 
 wire [7:0]write_temp_00=write_dat_uart[47:40];
 wire [7:0]write_temp_01=write_dat_uart[39:32];
 wire [7:0]write_temp_02=write_dat_uart[31:24];
 wire [7:0]write_temp_03=0;
 wire [7:0]write_temp_04=write_dat_uart[23:16];
 wire [7:0]write_temp_05=write_dat_uart[15:08];
 wire [7:0]write_temp_06=write_dat_uart[07:00];


reg[7:0] read_intercnt,write_intercnt;
(* syn_preserve = 1 *)reg[7:0]control_state;
	always @ (posedge clk or posedge rst)	
		begin
			if(rst)
				begin
					control_state<=0;
					read_add		 <=0;
					read_start	 <=0;
					write_add	 <=0;
					write_dat	 <=0;
					write_start	 <=0;
					write_over_uart<=0;
					read_intercnt<=0;
				end
			else
				begin
					case (control_state)
						0://read
							begin
								read_start	<=1'b1;
								control_state<=1;
							end	
						1:
							begin
								if(pos_read_over)
									begin
										read_start	 <=1'b0;
										control_state<=2;
										
									end
								else
									begin
										read_start	 <=1'b1;
										control_state<=1;
									end
							end
						2:
							begin
								if(read_intercnt==50)
									begin
										read_intercnt<=0;
										if(read_add==6)
											begin
												read_add		 <=0;
												control_state<=10;
											end
										else 
											begin
												read_add<=read_add+1;
												control_state<=0;
											end
									end
								else 
									begin
										read_intercnt<=read_intercnt+1;
										control_state<=2;
									end
							end
						10://detect
							begin
								if(write_start_uart)control_state<=20;
								else control_state<=0;
							end
						20://write
							begin
								write_add	<=0;
									case(write_add)
										0:write_dat<=write_temp_00;
										1:write_dat<=write_temp_01;
										2:write_dat<=write_temp_02;
										3:write_dat<=write_temp_03;
										4:write_dat<=write_temp_04;
										5:write_dat<=write_temp_05;
										6:write_dat<=write_temp_06;
										default:write_dat<=write_dat;
									endcase
								write_start	<=1'b1;
								if(write_add==7)
									begin
										write_add	 <=0;
										write_start	 <=1'b0;
										control_state<=21;
										write_over_uart<=1;
									end
								else if(pos_write_over)write_add<=write_add+1;
								else write_add<=write_add;
							end
						21:
							begin
								control_state<=0;
								write_over_uart<=0;
							end
						
						default:
							begin
								control_state<=0;
								read_add		 <=0;
								read_start	 <=0;
								write_add	 <=0;
								write_dat	 <=0;
								write_start	 <=0;
								write_over_uart<=1;
							end
					endcase
				end
		end
							
endmodule	
	