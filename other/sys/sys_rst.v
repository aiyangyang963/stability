`timescale 1 ns / 1 ns

module sys_rst(
///////////CLKIN//////////////////
		input  clk,
		input  local_init_done,
		
		output  reg			rst_out0,
	   output  reg		   rst_out1,
		output  reg[15:0]    test_cnt);

 reg	[7:0] rst_cnt,rst_cnt_ddr = 0;
//(* syn_preserve = 1 *) reg  [15:0]test_cnt;
 
	always @(posedge clk)begin
		if (rst_cnt < 100)  begin
			rst_cnt <=rst_cnt + 1;
			rst_out0 <= 1'b1;
		end
		else begin
			rst_out0 <= 1'b0;
		end
	end

//reg rst_timer=1;
//	always @(posedge clk)begin
//		if (rst_cnt_ddr < 100)  begin
//			rst_out1 <=1;
//			rst_timer<=1;
//		end
//		else if((msecond_r==1)&(!local_init_done))
//		else begin
//			rst_out1 <= 1'b0;
//			rst_cnt_ddr <= 1'b0;
//		end
//		if(rst_cnt_ddr < 100)rst_cnt_ddr<=rst_cnt_ddr+1;
//		else rst_cnt_ddr<=rst_cnt_ddr;
//	end
//	
//	always @(posedge clk)begin
//		test_cnt<=test_cnt+1;
//		end

(*syn_preserve = 1*)reg [7:0]ddr_rst_state;

always@(posedge clk)
	begin
		case(ddr_rst_state)
				0:begin
					if(!local_init_done)ddr_rst_state<=1;
					else ddr_rst_state<=0;
					rst_out1 <=0;end
				1:begin
					if(rst_cnt_ddr < 200)
						begin
							rst_cnt_ddr<=rst_cnt_ddr+1;
							ddr_rst_state<=1;
						end
					else
						begin
							rst_cnt_ddr<=0;
							ddr_rst_state<=2;
						end
					rst_out1 <=1;
					end
				2:begin
					if(second_r>=15)ddr_rst_state<=0;
					else ddr_rst_state<=2;
					rst_out1 <=0;
					end	
				default:begin
							ddr_rst_state<=0;
							rst_out1 <=0;
							rst_cnt_ddr<=0;
						end
		endcase	
	end		
	
	 //produce time message
 reg [15:0]timecnt;
 reg [7:0]year_r,month_r,day_r,hour_r,minute_r,second_r;
 reg [15:0]msecond_r;
 always @(posedge clk)
	begin
		if(rst_out1)
			begin
				year_r	<=0;
				month_r	<=0;
				day_r		<=0;
				hour_r	<=0;
				minute_r	<=0;
				second_r	<=0;
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