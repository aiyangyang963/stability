`timescale 1ns / 1ns
module search_alarm(
    input clk,rst,
	 	 
	 input [15:0]dat0_max,dat0_min,
	 input [15:0]dat1_max,dat1_min,
	 input [15:0]dat2_max,dat2_min,
	 input [15:0]dat3_max,dat3_min,
	 input dat0_max_en,dat1_max_en,dat2_max_en,dat3_max_en,
	 
	 output reg dat0_alarm,dat1_alarm,dat2_alarm,dat3_alarm);
	 

parameter dat0_high_threshold =16'h8000;
parameter dat0_high_cnt =10;
parameter dat0_low_cnt  =5;

parameter dat1_high_threshold =16'h8000;
parameter dat1_high_cnt =10;
parameter dat1_low_cnt  =5;

parameter dat2_high_threshold =16'h8000;
parameter dat2_high_cnt =10;
parameter dat2_low_cnt  =5;

parameter dat3_high_threshold =16'h8000;
parameter dat3_high_cnt =10;
parameter dat3_low_cnt  =5;

wire pos_dat0_max_en,neg_dat0_max_en;
wire pos_dat1_max_en,neg_dat1_max_en;
wire pos_dat2_max_en,neg_dat2_max_en;
wire pos_dat3_max_en,neg_dat3_max_en;
reg dat0_max_en_r0,dat0_max_en_r1,dat0_max_en_r2;
reg dat1_max_en_r0,dat1_max_en_r1,dat1_max_en_r2;
reg dat2_max_en_r0,dat2_max_en_r1,dat2_max_en_r2;
reg dat3_max_en_r0,dat3_max_en_r1,dat3_max_en_r2;

always@(posedge clk)
	begin
		dat0_max_en_r0<=dat0_max_en;
		dat0_max_en_r1<=dat0_max_en_r0;
		dat0_max_en_r2<=dat0_max_en_r1;
		
		dat1_max_en_r0<=dat1_max_en;
		dat1_max_en_r1<=dat1_max_en_r0;
		dat1_max_en_r2<=dat1_max_en_r1;
		
		dat2_max_en_r0<=dat2_max_en;
		dat2_max_en_r1<=dat2_max_en_r0;
		dat2_max_en_r2<=dat2_max_en_r1;
		
		dat3_max_en_r0<=dat3_max_en;
		dat3_max_en_r1<=dat3_max_en_r0;
		dat3_max_en_r2<=dat3_max_en_r1;
	end

assign pos_dat0_max_en=(~dat0_max_en_r2)&dat0_max_en_r1;
assign pos_dat1_max_en=(~dat1_max_en_r2)&dat1_max_en_r1;
assign pos_dat2_max_en=(~dat2_max_en_r2)&dat2_max_en_r1;
assign pos_dat3_max_en=(~dat3_max_en_r2)&dat3_max_en_r1;

assign neg_dat0_max_en=dat0_max_en_r2&(~dat0_max_en_r1); 
assign neg_dat1_max_en=dat1_max_en_r2&(~dat1_max_en_r1);
assign neg_dat2_max_en=dat2_max_en_r2&(~dat2_max_en_r1); 
assign neg_dat3_max_en=dat3_max_en_r2&(~dat3_max_en_r1);  

(*syn_preserve = 1*)reg [7:0]dat0_detect_stability,dat1_detect_stability,
									  dat2_detect_stability,dat3_detect_stability;

reg [7:0]dat0_high_cnter,dat1_high_cnter,dat2_high_cnter,dat3_high_cnter;
reg [7:0]dat0_low_cnter,dat1_low_cnter,dat2_low_cnter,dat3_low_cnter;		
always@(posedge clk)
	begin
		case(dat0_detect_stability)
				0://stability
				begin
					if(pos_dat0_max_en)
						begin
							if((dat0_max-dat0_min)>=dat0_high_threshold)dat0_detect_stability<=1;
							else dat0_detect_stability<=0;
						end
					else
						begin
							dat0_detect_stability<=0;
						end
					dat0_high_cnter<=0;
					
					dat0_alarm<=0;
				  end
				1:
				begin
					if(pos_dat0_max_en)
						begin
							if(dat0_high_cnter>=dat0_high_cnt)dat0_detect_stability<=2;
							else if((dat0_max-dat0_min)<dat0_high_threshold)dat0_detect_stability<=0;
							else dat0_detect_stability<=1;
							
							if(dat0_max-dat0_min>=dat0_high_threshold) dat0_high_cnter<=dat0_high_cnter+1;
							else dat0_high_cnter<=dat0_high_cnter;
						end
					else
						begin
							dat0_detect_stability<=1;
						end
				  end
				
				2://unstability
				begin
					if(pos_dat0_max_en)
						begin
							if((dat0_max-dat0_min)<dat0_high_threshold)dat0_detect_stability<=3;
							else dat0_detect_stability<=2;
						end
					else
						begin
							dat0_detect_stability<=2;
						end
					
					dat0_high_cnter<=dat0_high_cnter;
					dat0_low_cnter<=0;
					
					dat0_alarm<=1;
					end
				3:
				begin
					if(pos_dat0_max_en)
						begin
							if(dat0_low_cnter>=dat0_low_cnt)dat0_detect_stability<=0;
							else if((dat0_max-dat0_min)>=dat0_high_threshold)dat0_detect_stability<=2;
							else dat0_detect_stability<=3;
							
							if((dat0_max-dat0_min)<dat0_high_threshold)dat0_low_cnter<=dat0_low_cnter+1;
							else dat0_low_cnter<=dat0_low_cnter;
						end
					else 
						begin
							dat0_detect_stability<=3;
						end
				end
				default:
				begin
					dat0_detect_stability<=0;
					dat0_high_cnter<=0;
					dat0_low_cnter<=0;
					end
		endcase
	end

always@(posedge clk)
	begin
		case(dat1_detect_stability)
				0://stability
				begin
					if(pos_dat1_max_en)
						begin
							if((dat1_max-dat1_min)>=dat1_high_threshold)dat1_detect_stability<=1;
							else dat1_detect_stability<=0;
						end
					else
						begin
							dat1_detect_stability<=0;
						end
					dat1_high_cnter<=0;
					
					dat1_alarm<=0;
				  end
				1:
				begin
					if(pos_dat1_max_en)
						begin
							if(dat1_high_cnter>=dat1_high_cnt)dat1_detect_stability<=2;
							else if((dat1_max-dat1_min)<dat1_high_threshold)dat1_detect_stability<=0;
							else dat1_detect_stability<=1;
							
							if(dat1_max-dat1_min>=dat1_high_threshold) dat1_high_cnter<=dat1_high_cnter+1;
							else dat1_high_cnter<=dat1_high_cnter;
						end
					else
						begin
							dat1_detect_stability<=1;
						end
				  end
				
				2://unstability
				begin
					if(pos_dat1_max_en)
						begin
							if((dat1_max-dat1_min)<dat1_high_threshold)dat1_detect_stability<=3;
							else dat1_detect_stability<=2;
						end
					else
						begin
							dat1_detect_stability<=2;
						end
					
					dat1_high_cnter<=dat1_high_cnter;
					dat1_low_cnter<=0;
					
					dat1_alarm<=1;
					end
				3:
				begin
					if(pos_dat1_max_en)
						begin
							if(dat1_low_cnter>=dat1_low_cnt)dat1_detect_stability<=0;
							else if((dat1_max-dat1_min)>=dat1_high_threshold)dat1_detect_stability<=2;
							else dat1_detect_stability<=3;
							
							if((dat1_max-dat1_min)<dat1_high_threshold)dat1_low_cnter<=dat1_low_cnter+1;
							else dat1_low_cnter<=dat1_low_cnter;
						end
					else dat1_detect_stability<=3;
				end
				default:
				begin
					dat1_detect_stability<=0;
					dat1_high_cnter<=0;
					dat1_low_cnter<=0;
					end
		endcase
	end	

	
endmodule