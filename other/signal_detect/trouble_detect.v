`timescale 1ns / 1ns
module trouble_detect(
    input clk,rst,
	 
	 input Ch0_detect_en,
	 input Ch1_detect_en,
	 input Ch2_detect_en,
	 input Ch3_detect_en,
	 	 
	 input [15:0]Ch0_Data,
	 input [15:0]Ch1_Data,
	 input [15:0]Ch2_Data,
	 input [15:0]Ch3_Data,
	 input Ch0_Data_en,
	 input Ch1_Data_en,
	 input Ch2_Data_en,
	 input Ch3_Data_en,
	 
	 output reg Ch0_trouble,
	 output reg Ch1_trouble,
	 output reg Ch2_trouble,
	 output reg Ch3_trouble,
	 
	 output reg trouble_detect_over
	 );
	 
parameter Ch0_trouble_high = 12'h800;
parameter Ch0_trouble_low  = 12'h000;
parameter Ch1_trouble_high = 12'h800;
parameter Ch1_trouble_low  = 12'h000;
parameter Ch2_trouble_high = 12'h800;
parameter Ch2_trouble_low  = 12'h000;
parameter Ch3_trouble_high = 12'h800;
parameter Ch3_trouble_low  = 12'h000;

parameter Ch0_trouble_mun = 30;
parameter Ch1_trouble_mun = 30;
parameter Ch2_trouble_mun = 30;
parameter Ch3_trouble_mun = 30;

wire pos_Ch0_Data_en,neg_Ch0_Data_en;
wire pos_Ch1_Data_en,neg_Ch1_Data_en;
wire pos_Ch2_Data_en,neg_Ch2_Data_en;
wire pos_Ch3_Data_en,neg_Ch3_Data_en;

reg Ch0_Data_en_r0,Ch0_Data_en_r1,Ch0_Data_en_r2;
reg Ch1_Data_en_r0,Ch1_Data_en_r1,Ch1_Data_en_r2;
reg Ch2_Data_en_r0,Ch2_Data_en_r1,Ch2_Data_en_r2;
reg Ch3_Data_en_r0,Ch3_Data_en_r1,Ch3_Data_en_r2;

always@(posedge clk)
	begin
		Ch0_Data_en_r0<=Ch0_Data_en;
		Ch0_Data_en_r1<=Ch0_Data_en_r0;
		Ch0_Data_en_r2<=Ch0_Data_en_r1;
		
		Ch1_Data_en_r0<=Ch1_Data_en;
		Ch1_Data_en_r1<=Ch1_Data_en_r0;
		Ch1_Data_en_r2<=Ch1_Data_en_r1;
		
		Ch2_Data_en_r0<=Ch2_Data_en;
		Ch2_Data_en_r1<=Ch2_Data_en_r0;
		Ch2_Data_en_r2<=Ch2_Data_en_r1;
		
		Ch3_Data_en_r0<=Ch3_Data_en;
		Ch3_Data_en_r1<=Ch3_Data_en_r0;
		Ch3_Data_en_r2<=Ch3_Data_en_r1;
	end

assign pos_Ch0_Data_en=(~Ch0_Data_en_r2)&Ch0_Data_en_r1;
assign pos_Ch1_Data_en=(~Ch1_Data_en_r2)&Ch1_Data_en_r1;
assign pos_Ch2_Data_en=(~Ch2_Data_en_r2)&Ch2_Data_en_r1;
assign pos_Ch3_Data_en=(~Ch3_Data_en_r2)&Ch3_Data_en_r1;

assign neg_Ch0_Data_en=Ch0_Data_en_r2&(~Ch0_Data_en_r1); 
assign neg_Ch1_Data_en=Ch1_Data_en_r2&(~Ch1_Data_en_r1); 
assign neg_Ch2_Data_en=Ch2_Data_en_r2&(~Ch2_Data_en_r1); 
assign neg_Ch3_Data_en=Ch3_Data_en_r2&(~Ch3_Data_en_r1); 
	 
 reg[7:0]Ch0_trouble_cnt,Ch1_trouble_cnt,Ch2_trouble_cnt,Ch3_trouble_cnt;
 always @(posedge clk)
	begin
		if((!Ch0_detect_en)||(rst))
			begin
				Ch0_trouble<=0;
				Ch0_trouble_cnt<=0;
			end
		else
			begin
				if(pos_Ch0_Data_en)
					begin
						if(Ch0_trouble_cnt>=30)Ch0_trouble_cnt<=Ch0_trouble_cnt;
						else Ch0_trouble_cnt<=Ch0_trouble_cnt+1;
						
						if(Ch0_trouble_cnt<=30)
							begin
								if((Ch0_Data[15:4]<Ch0_trouble_low)||(Ch0_Data[15:4]>Ch0_trouble_high))Ch0_trouble<=1;
								else Ch0_trouble<=Ch0_trouble;
							end
						else Ch0_trouble<=Ch0_trouble;
					end
					
				else 
					begin
						Ch0_trouble_cnt<=Ch0_trouble_cnt;
						Ch0_trouble<=Ch0_trouble;
					end
			end
			
		if((!Ch1_detect_en)||(rst))
			begin
				Ch1_trouble<=0;
				Ch1_trouble_cnt<=0;
			end
		else
			begin
				if(pos_Ch1_Data_en)
					begin
						if(Ch1_trouble_cnt>=30)Ch1_trouble_cnt<=Ch1_trouble_cnt;
						else Ch1_trouble_cnt<=Ch1_trouble_cnt+1;
						
						if(Ch1_trouble_cnt<=30)
							begin
								if((Ch1_Data[15:4]<Ch1_trouble_low)||(Ch1_Data[15:4]>Ch1_trouble_high))Ch1_trouble<=1;
								else Ch1_trouble<=Ch1_trouble;
							end
						else Ch1_trouble<=Ch1_trouble;
					end
					
				else 
					begin
						Ch1_trouble_cnt<=Ch1_trouble_cnt;
						Ch1_trouble<=Ch1_trouble;
					end
			end
			
		if((!Ch2_detect_en)||(rst))
			begin
				Ch2_trouble<=0;
				Ch2_trouble_cnt<=0;
			end
		else
			begin
				if(pos_Ch2_Data_en)
					begin
						if(Ch2_trouble_cnt>=30)Ch2_trouble_cnt<=Ch2_trouble_cnt;
						else Ch2_trouble_cnt<=Ch2_trouble_cnt+1;
						
						if(Ch2_trouble_cnt<=30)
							begin
								if((Ch2_Data[15:4]<Ch2_trouble_low)||(Ch2_Data[15:4]>Ch2_trouble_high))Ch2_trouble<=1;
								else Ch2_trouble<=Ch2_trouble;
							end
						else Ch2_trouble<=Ch2_trouble;
					end
					
				else 
					begin
						Ch2_trouble_cnt<=Ch2_trouble_cnt;
						Ch2_trouble<=Ch2_trouble;
					end
			end
			
		if((!Ch3_detect_en)||(rst))
			begin
				Ch3_trouble<=0;
				Ch3_trouble_cnt<=0;
			end
		else
			begin
				if(pos_Ch3_Data_en)
					begin
						if(Ch3_trouble_cnt>=30)Ch3_trouble_cnt<=Ch3_trouble_cnt;
						else Ch3_trouble_cnt<=Ch3_trouble_cnt+1;
						
						if(Ch3_trouble_cnt<=30)
							begin
								if((Ch3_Data[15:4]<Ch3_trouble_low)||(Ch3_Data[15:4]>Ch3_trouble_high))Ch3_trouble<=1;
								else Ch3_trouble<=Ch3_trouble;
							end
						else Ch3_trouble<=Ch3_trouble;
					end
					
				else 
					begin
						Ch3_trouble_cnt<=Ch3_trouble_cnt;
						Ch3_trouble<=Ch3_trouble;
					end
			end
			
		if((Ch0_trouble_cnt>=30)&&(Ch1_trouble_cnt>=30)&&(Ch2_trouble_cnt>=30)&&(Ch3_trouble_cnt>=30))	
			trouble_detect_over<=1;
		else trouble_detect_over<=0;
	end
	
endmodule