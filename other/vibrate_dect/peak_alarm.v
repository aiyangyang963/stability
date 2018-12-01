`timescale 1ns / 1ns
module peak_alarm(
    input clk,
	 input rst,
	 
	 input [15:0] Ch0_PData_ads2,
	 input  Ch0_PData_en_ads2,
	 input [15:0] Ch0_VData_ads2,
	 input Ch0_VData_en_ads2,
	
	 output reg Ch0_alarm_ads2);

parameter alarm_line = 16'h8000;
parameter over_count = 16'h000A;
	 
reg [7:0]alarm_cnt;
always@(posedge clk)
	begin
		if(Ch0_PData_en_ads2)
			begin
				if((Ch0_PData_ads2-Ch0_VData_ads2)<alarm_line)		 alarm_cnt<=0;
				else if((Ch0_PData_ads2-Ch0_VData_ads2)>=alarm_line)alarm_cnt<=alarm_cnt+1;
				else alarm_cnt<=alarm_cnt;
			end
		else 
			begin
				alarm_cnt<=alarm_cnt;
			end
	end

always@(posedge clk)
	begin
		if(Ch0_PData_en_ads2)
			begin
				if((Ch0_PData_ads2-Ch0_VData_ads2)<alarm_line)Ch0_alarm_ads2<=0;
				else if(alarm_cnt>=over_count)					 Ch0_alarm_ads2<=1;
				else Ch0_alarm_ads2<=Ch0_alarm_ads2;
			end
		else
			begin
				Ch0_alarm_ads2<=Ch0_alarm_ads2;
			end
	end	
endmodule