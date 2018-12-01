`timescale 1ns / 1ns
module average_base2(
    input clk,rst,
	 	 
	 input [15:0]Data0,
	 input [15:0]Data1,
	 input [15:0]Data2,
	 input [15:0]Data3,
	 input Data0_en,
	 input Data1_en,
	 input Data2_en,
	 input Data3_en,
	 
	 output reg[15:0]AData0,
	 output reg[15:0]AData1,
	 output reg[15:0]AData2,
	 output reg[15:0]AData3,
	 output reg AData0_en,
	 output reg AData1_en,
	 output reg AData2_en,
	 output reg AData3_en
	 );

wire pos_Data0_en,neg_Data0_en;
wire pos_Data1_en,neg_Data1_en;
wire pos_Data2_en,neg_Data2_en;
wire pos_Data3_en,neg_Data3_en;
reg Data0_en_r0,Data0_en_r1,Data0_en_r2;
reg Data1_en_r0,Data1_en_r1,Data1_en_r2;
reg Data2_en_r0,Data2_en_r1,Data2_en_r2;
reg Data3_en_r0,Data3_en_r1,Data3_en_r2;
always@(posedge clk)
	begin
		Data0_en_r0<=Data0_en;
		Data0_en_r1<=Data0_en_r0;
		Data0_en_r2<=Data0_en_r1;
		
		Data1_en_r0<=Data1_en;
		Data1_en_r1<=Data1_en_r0;
		Data1_en_r2<=Data1_en_r1;
		
		Data2_en_r0<=Data2_en;
		Data2_en_r1<=Data2_en_r0;
		Data2_en_r2<=Data2_en_r1;
		
		Data3_en_r0<=Data3_en;
		Data3_en_r1<=Data3_en_r0;
		Data3_en_r2<=Data3_en_r1;
	end

assign pos_Data0_en=(~Data0_en_r2)&Data0_en_r1;
assign pos_Data1_en=(~Data1_en_r2)&Data1_en_r1;
assign pos_Data2_en=(~Data2_en_r2)&Data2_en_r1;
assign pos_Data3_en=(~Data3_en_r2)&Data3_en_r1;

assign neg_Data0_en=Data0_en_r2&(~Data0_en_r1); 
assign neg_Data1_en=Data1_en_r2&(~Data1_en_r1); 
assign neg_Data2_en=Data2_en_r2&(~Data2_en_r1); 
assign neg_Data3_en=Data3_en_r2&(~Data3_en_r1); 

always@(posedge clk)
	begin
		AData0_en<=Data0_en;
		AData1_en<=Data1_en;
		AData2_en<=Data2_en;
		AData3_en<=Data3_en;
	end
	 
(*syn_preserve = 1*)reg [7:0]average_state0,average_state1,average_state2,average_state3;
always@(posedge clk)
	begin
		case(average_state0)
			0:begin
				if(pos_Data0_en)
					begin
						average_state0<=1;
						AData0<=Data0;
					end
				else average_state0<=0;
				end
			1:begin
				if(pos_Data0_en)AData0<=(AData0+Data0)/2;
				else AData0<=AData0;
				average_state0<=1;
				end
			default:begin
					average_state0<=0;
					AData0		  <=0;
					end
		endcase
		
		case(average_state1)
			0:begin
				if(pos_Data1_en)
					begin
						average_state1<=1;
						AData1<=Data1;
					end
				else average_state1<=0;
				end
			1:begin
				if(pos_Data1_en)AData1<=(AData1+Data1)/2;
				else AData1<=AData1;
				average_state1<=1;
				end
			default:begin
					average_state1<=0;
					AData1		  <=0;
					end
		endcase
		
		case(average_state2)
			0:begin
				if(pos_Data2_en)
					begin
						average_state2<=1;
						AData2<=Data2;
					end
				else average_state2<=0;
				end
			1:begin
				if(pos_Data2_en)AData2<=(AData2+Data2)/2;
				else AData2<=AData2;
				average_state2<=1;
				end
			default:begin
					average_state2<=0;
					AData2		  <=0;
					end
		endcase
		
		case(average_state3)
			0:begin
				if(pos_Data3_en)
					begin
						average_state3<=1;
						AData3<=Data3;
					end
				else average_state3<=0;
				end
			1:begin
				if(pos_Data3_en)AData3<=(AData3+Data3)/2;
				else AData3<=AData3;
				average_state3<=1;
				end
			default:begin
					average_state3<=0;
					AData3		  <=0;
					end
		endcase
	end
endmodule