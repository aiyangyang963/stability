`timescale 1 ns / 1 ns
module timer(
		input clk,//50M
		input rst,
		input clear,
		
		output reg[15:0]timecnt,       
		output reg [7:0]minute,
		output reg [7:0]second,
		output reg [15:0]msecond
		
	);

 wire pos_clear,neg_clear;
 reg clear_r0,clear_r1,clear_r2;
 always@(posedge clk)
	begin
		clear_r0<=clear;
		clear_r1<=clear_r0;
		clear_r2<=clear_r1;
	end
assign pos_clear=(~clear_r2)&clear_r1;
assign neg_clear=clear_r2&(~clear_r1);   
 
 always @(posedge clk)
	begin
		if((clear)||(rst))
			begin
				minute	<=0;
				second	<=0;
				msecond  <=0;
				timecnt	<=0;
			end
		else
			begin
				if(minute==59)
					begin
						minute	<=minute;
					end
				else
					begin
						if(second==59)
							begin
								minute<=minute+1;
								second<=0;
							end
						else
							begin
								minute<=minute;
								if(msecond==999)
									begin
										second<=second+1;
										msecond<=0;
									end
								else
									begin
										second<=second;//50_000*20ns=1ms--50Mhz clock
										if(timecnt==50_000)
											begin
												msecond<=msecond+1;
												timecnt<=0;
											end
										else
											begin
												msecond<=msecond;
												timecnt<=timecnt+1;
											end
									end
							end
					end
			end
	end
	
endmodule