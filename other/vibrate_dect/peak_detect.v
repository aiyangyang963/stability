`timescale 1ns / 1ns

module peak_detect(
    input clk,rst,
	 	 
	 input [15:0]Data0,
	 input [15:0]Data1,
	 input [15:0]Data2,
	 input [15:0]Data3,
	 input Data0_en,
	 input Data1_en,
	 input Data2_en,
	 input Data3_en,
	 
	 output reg[15:0]PData0,
	 output reg[15:0]PData1,
	 output reg[15:0]PData2,
	 output reg[15:0]PData3,
	 output reg PData0_en,
	 output reg PData1_en,
	 output reg PData2_en,
	 output reg PData3_en,
	 
	 output reg[15:0]VData0,
	 output reg[15:0]VData1,
	 output reg[15:0]VData2,
	 output reg[15:0]VData3,
	 
	 output reg VData0_en,
	 output reg VData1_en,
	 output reg VData2_en,
	 output reg VData3_en
	 );
parameter DATAWIDTH=16;
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

reg [DATAWIDTH-1:0]Data0_r0,Data1_r0,Data2_r0,Data3_r0;	 
reg [DATAWIDTH-1:0]Data0_r1,Data1_r1,Data2_r1,Data3_r1;	
reg [DATAWIDTH-1:0]Data0_r2,Data1_r2,Data2_r2,Data3_r2;	
reg [DATAWIDTH-1:0]Data0_r3,Data1_r3,Data2_r3,Data3_r3;
always@(posedge clk)
	begin
		if(pos_Data0_en)
			begin
				Data0_r0<=Data0;
				Data0_r1<=Data0_r0;
				Data0_r2<=Data0_r1;
				Data0_r3<=Data0_r2;
			end
		else 
			begin
				Data0_r0<=Data0_r0;
				Data0_r1<=Data0_r1;
				Data0_r2<=Data0_r2;
				Data0_r3<=Data0_r3;
			end
			
		if(pos_Data1_en)
			begin
				Data1_r0<=Data1;
				Data1_r1<=Data1_r0;
				Data1_r2<=Data1_r1;
				Data1_r3<=Data1_r2;
			end
		else 
			begin
				Data1_r0<=Data1_r0;
				Data1_r1<=Data1_r1;
				Data1_r2<=Data1_r2;
				Data1_r3<=Data1_r3;
			end
			
		if(pos_Data2_en)
			begin
				Data2_r0<=Data2;
				Data2_r1<=Data2_r0;
				Data2_r2<=Data2_r1;
				Data2_r3<=Data2_r2;
			end
		else 
			begin
				Data2_r0<=Data2_r0;
				Data2_r1<=Data2_r1;
				Data2_r2<=Data2_r2;
				Data2_r3<=Data2_r3;
			end
			
		if(pos_Data3_en)
			begin
				Data3_r0<=Data3;
				Data3_r1<=Data3_r0;
				Data3_r2<=Data3_r1;
				Data3_r3<=Data3_r2;
			end
		else 
			begin
				Data3_r0<=Data3_r0;
				Data3_r1<=Data3_r1;
				Data3_r2<=Data3_r2;
				Data3_r3<=Data3_r3;
			end
	end
	
always@(posedge clk)
	begin
		if(Data0_en)
			begin
				if((Data0_r0>Data0)&&(Data0_r0>Data0_r1))
					begin
						PData0			<=Data0_r0;
						PData0_en		<=1;
					end
				else
					begin
						PData0			<=PData0;
						PData0_en		<=0;
					end
			end
		else 
			begin
				PData0   	<=PData0;
				PData0_en	<=0;
			end
			
		if(Data1_en)
			begin
				if((Data1_r0>Data1)&&(Data1_r0>Data1_r1))
					begin
						PData1			<=Data1_r0;
						PData1_en		<=1;
					end
				else
					begin
						PData1			<=PData1;
						PData1_en		<=0;
					end
			end
		else 
			begin
				PData1   	<=PData1;
				PData1_en	<=0;
			end
			
		if(Data2_en)
			begin
				if((Data2_r0>Data2)&&(Data2_r0>Data2_r1))
					begin
						PData2			<=Data2_r0;
						PData2_en		<=1;
					end
				else
					begin
						PData2			<=PData2;
						PData2_en		<=0;
					end
			end
		else 
			begin
				PData2   	<=PData2;
				PData2_en	<=0;
			end
			
		if(Data3_en)
			begin
				if((Data3_r0>Data3)&&(Data3_r0>Data3_r1))
					begin
						PData3			<=Data3_r0;
						PData3_en		<=1;
					end
				else
					begin
						PData3			<=PData3;
						PData3_en		<=0;
					end
			end
		else 
			begin
				PData3   	<=PData3;
				PData3_en	<=0;
			end
	end

always@(posedge clk)
	begin
		if(Data0_en)
			begin
				if((Data0_r0<Data0)&&(Data0_r0<Data0_r1))
					begin
						VData0			<=Data0_r0;
						VData0_en		<=1;
					end
				else
					begin
						VData0			<=VData0;
						VData0_en		<=0;
					end
			end
		else 
			begin
				VData0   <=VData0;
				VData0_en<=0;
			end
			
		if(Data1_en)
			begin
				if((Data1_r0<Data1)&&(Data1_r0<Data1_r1))
					begin
						VData1			<=Data1_r0;
						VData1_en		<=1;
					end
				else
					begin
						VData1			<=VData1;
						VData1_en		<=0;
					end
			end
		else 
			begin
				VData1   <=VData1;
				VData1_en<=0;
			end
			
		if(Data2_en)
			begin
				if((Data2_r0<Data2)&&(Data2_r0<Data2_r1))
					begin
						VData2			<=Data2_r0;
						VData2_en		<=1;
					end
				else
					begin
						VData2			<=VData2;
						VData2_en		<=0;
					end
			end
		else 
			begin
				VData2   <=VData2;
				VData2_en<=0;
			end
			
		if(Data3_en)
			begin
				if((Data3_r0<Data3)&&(Data3_r0<Data3_r1))
					begin
						VData3			<=Data3_r0;
						VData3_en		<=1;
					end
				else
					begin
						VData3			<=VData3;
						VData3_en		<=0;
					end
			end
		else 
			begin
				VData3   <=VData3;
				VData3_en<=0;
			end
	end
endmodule