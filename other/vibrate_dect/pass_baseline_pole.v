`timescale 1ns / 1ns
module pass_baseline_pole(
    input clk,rst,
	 
	 input dat0_enable,dat1_enable,dat2_enable,dat3_enable,
	 input [15:0]dat0,dat1,dat2,dat3,
	 
	 input [15:0]dat0_base_line,
	 input [15:0]dat1_base_line,
	 input [15:0]dat2_base_line,
	 input [15:0]dat3_base_line,
	 
	 output reg[15:0] dat0_max,dat1_max,dat2_max,dat3_max,
	 output reg dat0_max_en,dat1_max_en,dat2_max_en,dat3_max_en,
	 output reg[15:0] dat0_min,dat1_min,dat2_min,dat3_min,
	 output reg dat0_min_en,dat1_min_en,dat2_min_en,dat3_min_en
	 );
parameter DATAWIDTH=16;
	 
wire pos_dat0_enable,neg_dat0_enable;
wire pos_dat1_enable,neg_dat1_enable;
wire pos_dat2_enable,neg_dat2_enable;
wire pos_dat3_enable,neg_dat3_enable;

reg dat0_enable_r0,dat0_enable_r1,dat0_enable_r2;
reg dat1_enable_r0,dat1_enable_r1,dat1_enable_r2;
reg dat2_enable_r0,dat2_enable_r1,dat2_enable_r2;
reg dat3_enable_r0,dat3_enable_r1,dat3_enable_r2;

always@(posedge clk)
	begin
		dat0_enable_r0<=dat0_enable;
		dat0_enable_r1<=dat0_enable_r0;
		dat0_enable_r2<=dat0_enable_r1;
		
		dat1_enable_r0<=dat1_enable;
		dat1_enable_r1<=dat1_enable_r0;
		dat1_enable_r2<=dat1_enable_r1;
		
		dat2_enable_r0<=dat2_enable;
		dat2_enable_r1<=dat2_enable_r0;
		dat2_enable_r2<=dat2_enable_r1;
		
		dat3_enable_r0<=dat3_enable;
		dat3_enable_r1<=dat3_enable_r0;
		dat3_enable_r2<=dat3_enable_r1;
	end

assign pos_dat0_enable=(~dat0_enable_r2)&dat0_enable_r1;
assign pos_dat1_enable=(~dat1_enable_r2)&dat1_enable_r1;
assign pos_dat2_enable=(~dat2_enable_r2)&dat2_enable_r1;
assign pos_dat3_enable=(~dat3_enable_r2)&dat3_enable_r1;

assign neg_dat0_enable=dat0_enable_r2&(~dat0_enable_r1); 
assign neg_dat1_enable=dat1_enable_r2&(~dat1_enable_r1); 
assign neg_dat2_enable=dat2_enable_r2&(~dat2_enable_r1); 
assign neg_dat3_enable=dat3_enable_r2&(~dat3_enable_r1); 

reg [DATAWIDTH-1:0]dat0_r0,dat1_r0,dat2_r0,dat3_r0;	 
reg [DATAWIDTH-1:0]dat0_r1,dat1_r1,dat2_r1,dat3_r1;	
reg [DATAWIDTH-1:0]dat0_r2,dat1_r2,dat2_r2,dat3_r2;	
reg [DATAWIDTH-1:0]dat0_r3,dat1_r3,dat2_r3,dat3_r3;

reg [15:0]dat0_max_temp,dat0_min_temp;
reg [15:0]dat1_max_temp,dat1_min_temp;
reg [15:0]dat2_max_temp,dat2_min_temp;
reg [15:0]dat3_max_temp,dat3_min_temp;


(*syn_preserve = 1*)reg [7:0]dat0_max_state,dat0_min_state;
(*syn_preserve = 1*)reg [7:0]dat1_max_state,dat1_min_state;
(*syn_preserve = 1*)reg [7:0]dat2_max_state,dat2_min_state;
(*syn_preserve = 1*)reg [7:0]dat3_max_state,dat3_min_state;

always@(posedge clk)
	begin
		case(dat0_max_state)
				0:begin
					if(pos_dat0_enable)
						begin
							if(dat0<dat0_base_line)dat0_max_state<=1;
							else dat0_max_state<=0;
						end
					else dat0_max_state<=0;
					dat0_max_en<=0;
					dat0_max_temp	<=0;end
				1:begin
					if(pos_dat0_enable)
						begin
							if(dat0>dat0_base_line)dat0_max_state<=2;
							else dat0_max_state<=1;
						end
					else dat0_max_state<=1;end
				2:begin//Hmax
					if(pos_dat0_enable)
						begin
							if(dat0<dat0_base_line)dat0_max_state<=3;
							else dat0_max_state<=2;
							if(dat0>=dat0_max_temp)dat0_max_temp<=dat0;
							else	dat0_max_temp<=dat0_max_temp;
						end
					else dat0_max_state<=2;
					end
				3:begin
					dat0_max			<=dat0_max_temp;
					dat0_max_en		<=1;
					dat0_max_state	<=0;end	
				default:begin
						dat0_max_state<=0;
						dat0_max		  <=0;
						dat0_max_en	  <=0;
						dat0_max_temp <=0;end
		endcase
	end
	
always@(posedge clk)
	begin
		case(dat1_max_state)
				0:begin
					if(pos_dat1_enable)
						begin
							if(dat1<dat1_base_line)dat1_max_state<=1;
							else dat1_max_state<=0;
						end
					else dat1_max_state<=0;
					dat1_max_en<=0;
					dat1_max_temp	<=0;end
				1:begin
					if(pos_dat1_enable)
						begin
							if(dat1>dat1_base_line)dat1_max_state<=2;
							else dat1_max_state<=1;
						end
					else dat1_max_state<=1;end
				2:begin//Hmax
					if(pos_dat1_enable)
						begin
							if(dat1<dat1_base_line)dat1_max_state<=3;
							else dat1_max_state<=2;
							if(dat1>=dat1_max_temp)dat1_max_temp<=dat1;
							else	dat1_max_temp<=dat1_max_temp;
						end
					else dat1_max_state<=2;
					end
				3:begin
					dat1_max			<=dat1_max_temp;
					dat1_max_en		<=1;
					dat1_max_state	<=0;end	
				default:begin
						dat1_max_state<=0;
						dat1_max		  <=0;
						dat1_max_en	  <=0;
						dat1_max_temp <=0;end
		endcase
	end
	
always@(posedge clk)
	begin
		case(dat2_max_state)
				0:begin
					if(pos_dat2_enable)
						begin
							if(dat2<dat2_base_line)dat2_max_state<=1;
							else dat2_max_state<=0;
						end
					else dat2_max_state<=0;
					dat2_max_en<=0;
					dat2_max_temp	<=0;end
				1:begin
					if(pos_dat2_enable)
						begin
							if(dat2>dat2_base_line)dat2_max_state<=2;
							else dat2_max_state<=1;
						end
					else dat2_max_state<=1;end
				2:begin//Hmax
					if(pos_dat2_enable)
						begin
							if(dat2<dat2_base_line)dat2_max_state<=3;
							else dat2_max_state<=2;
							if(dat2>=dat2_max_temp)dat2_max_temp<=dat2;
							else	dat2_max_temp<=dat2_max_temp;
						end
					else dat2_max_state<=2;
					end
				3:begin
					dat2_max			<=dat2_max_temp;
					dat2_max_en		<=1;
					dat2_max_state	<=0;end	
				default:begin
						dat2_max_state<=0;
						dat2_max		  <=0;
						dat2_max_en	  <=0;
						dat2_max_temp <=0;end
		endcase
	end
	
always@(posedge clk)
	begin
		case(dat3_max_state)
				0:begin
					if(pos_dat3_enable)
						begin
							if(dat3<dat3_base_line)dat3_max_state<=1;
							else dat3_max_state<=0;
						end
					else dat3_max_state<=0;
					dat3_max_en<=0;
					dat3_max_temp	<=0;end
				1:begin
					if(pos_dat3_enable)
						begin
							if(dat3>dat3_base_line)dat3_max_state<=2;
							else dat3_max_state<=1;
						end
					else dat3_max_state<=1;end
				2:begin//Hmax
					if(pos_dat3_enable)
						begin
							if(dat3<dat3_base_line)dat3_max_state<=3;
							else dat3_max_state<=2;
							if(dat3>=dat3_max_temp)dat3_max_temp<=dat3;
							else	dat3_max_temp<=dat3_max_temp;
						end
					else dat3_max_state<=2;
					end
				3:begin
					dat3_max			<=dat3_max_temp;
					dat3_max_en		<=1;
					dat3_max_state	<=0;end	
				default:begin
						dat3_max_state<=0;
						dat3_max		  <=0;
						dat3_max_en	  <=0;
						dat3_max_temp <=0;end
		endcase
	end
	
always@(posedge clk)
	begin
		case(dat0_min_state)
				0:begin
					if(pos_dat0_enable)
						begin
							if(dat0>dat0_base_line)dat0_min_state<=1;
							else dat0_min_state<=0;
						end
					else dat0_min_state<=0;
					dat0_min_en		<=0;
					dat0_min_temp	<=0;end
				1:begin
					if(pos_dat0_enable)
						begin
							if(dat0<dat0_base_line)dat0_min_state<=2;
							else dat0_min_state<=1;
						end
					else dat0_min_state<=1;end
				2:begin//Lmin
					if(pos_dat0_enable)
						begin
							if(dat0>dat0_base_line)dat0_min_state<=3;
							else dat0_min_state<=2;
							if(dat0<=dat0_min_temp)dat0_min_temp<=dat0;
							else	dat0_min_temp<=dat0_min_temp;
						end
					else dat0_min_state<=2;
					end
				3:begin
					dat0_min			<=dat0_min_temp;
					dat0_min_en		<=1;
					dat0_min_state	<=0;end	
				default:begin
						dat0_min_state<=0;
						dat0_min		  <=0;
						dat0_min_en	  <=0;
						dat0_min_temp <=0;end
		endcase
	end
	
always@(posedge clk)
	begin
		case(dat1_min_state)
				0:begin
					if(pos_dat1_enable)
						begin
							if(dat1>dat1_base_line)dat1_min_state<=1;
							else dat1_min_state<=0;
						end
					else dat1_min_state<=0;
					dat1_min_en		<=0;
					dat1_min_temp	<=0;end
				1:begin
					if(pos_dat1_enable)
						begin
							if(dat1<dat1_base_line)dat1_min_state<=2;
							else dat1_min_state<=1;
						end
					else dat1_min_state<=1;end
				2:begin//Lmin
					if(pos_dat1_enable)
						begin
							if(dat1>dat1_base_line)dat1_min_state<=3;
							else dat1_min_state<=2;
							if(dat1<=dat1_min_temp)dat1_min_temp<=dat1;
							else	dat1_min_temp<=dat1_min_temp;
						end
					else dat1_min_state<=2;
					end
				3:begin
					dat1_min			<=dat1_min_temp;
					dat1_min_en		<=1;
					dat1_min_state	<=0;end	
				default:begin
						dat1_min_state<=0;
						dat1_min		  <=0;
						dat1_min_en	  <=0;
						dat1_min_temp <=0;end
		endcase
	end
	
always@(posedge clk)
	begin
		case(dat2_min_state)
				0:begin
					if(pos_dat2_enable)
						begin
							if(dat2>dat2_base_line)dat2_min_state<=1;
							else dat2_min_state<=0;
						end
					else dat2_min_state<=0;
					dat2_min_en		<=0;
					dat2_min_temp	<=0;end
				1:begin
					if(pos_dat2_enable)
						begin
							if(dat2<dat2_base_line)dat2_min_state<=2;
							else dat2_min_state<=1;
						end
					else dat2_min_state<=1;end
				2:begin//Lmin
					if(pos_dat2_enable)
						begin
							if(dat2>dat2_base_line)dat2_min_state<=3;
							else dat2_min_state<=2;
							if(dat2<=dat2_min_temp)dat2_min_temp<=dat2;
							else	dat2_min_temp<=dat2_min_temp;
						end
					else dat2_min_state<=2;
					end
				3:begin
					dat2_min			<=dat2_min_temp;
					dat2_min_en		<=1;
					dat2_min_state	<=0;end	
				default:begin
						dat2_min_state<=0;
						dat2_min		  <=0;
						dat2_min_en	  <=0;
						dat2_min_temp <=0;end
		endcase
	end
	
always@(posedge clk)
	begin
		case(dat3_min_state)
				0:begin
					if(pos_dat3_enable)
						begin
							if(dat3>dat3_base_line)dat3_min_state<=1;
							else dat3_min_state<=0;
						end
					else dat3_min_state<=0;
					dat3_min_en		<=0;
					dat3_min_temp	<=0;end
				1:begin
					if(pos_dat3_enable)
						begin
							if(dat3<dat3_base_line)dat3_min_state<=2;
							else dat3_min_state<=1;
						end
					else dat3_min_state<=1;end
				2:begin//Lmin
					if(pos_dat3_enable)
						begin
							if(dat3>dat3_base_line)dat3_min_state<=3;
							else dat3_min_state<=2;
							if(dat3<=dat3_min_temp)dat3_min_temp<=dat3;
							else	dat3_min_temp<=dat3_min_temp;
						end
					else dat3_min_state<=2;
					end
				3:begin
					dat3_min			<=dat3_min_temp;
					dat3_min_en		<=1;
					dat3_min_state	<=0;end	
				default:begin
						dat3_min_state<=0;
						dat3_min		  <=0;
						dat3_min_en	  <=0;
						dat3_min_temp <=0;end
		endcase
	end	 
endmodule