`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
module dat_decimate(
    input clk,rst,
	 
	 input [15:0]Data0_in,
	 input [15:0]Data1_in,
	 input [15:0]Data2_in,
	 input [15:0]Data3_in,
	 
	 input Data0_in_en,
	 input Data1_in_en,
	 input Data2_in_en,
	 input Data3_in_en,
	  
	 output reg[15:0]Data0_out,
	 output reg[15:0]Data1_out,
	 output reg[15:0]Data2_out,
	 output reg[15:0]Data3_out,
	 
	 output reg Data0_out_en,
	 output reg Data1_out_en,
	 output reg Data2_out_en,
	 output reg Data3_out_en);

parameter Data0_decimate_num =1000; 
parameter Data1_decimate_num =1000; 
parameter Data2_decimate_num =1000; 
parameter Data3_decimate_num =1000; 
	 
wire 	pos_Data0_in_en,neg_Data0_in_en;
wire 	pos_Data1_in_en,neg_Data1_in_en;
wire 	pos_Data2_in_en,neg_Data2_in_en;
wire 	pos_Data3_in_en,neg_Data3_in_en;
(* syn_preserve = 1 *)reg Data0_in_en_r0;
(* syn_preserve = 1 *)reg Data1_in_en_r0;
(* syn_preserve = 1 *)reg Data2_in_en_r0;
(* syn_preserve = 1 *)reg Data3_in_en_r0;
(* syn_preserve = 1 *)reg Data0_in_en_r1;
(* syn_preserve = 1 *)reg Data1_in_en_r1;
(* syn_preserve = 1 *)reg Data2_in_en_r1;
(* syn_preserve = 1 *)reg Data3_in_en_r1;
(* syn_preserve = 1 *)reg Data0_in_en_r2;
(* syn_preserve = 1 *)reg Data1_in_en_r2;
(* syn_preserve = 1 *)reg Data2_in_en_r2;
(* syn_preserve = 1 *)reg Data3_in_en_r2;

always@(posedge clk)
	begin
		Data0_in_en_r0<=Data0_in_en;
		Data0_in_en_r1<=Data0_in_en_r0;
		Data0_in_en_r2<=Data0_in_en_r1;
		
		Data1_in_en_r0<=Data1_in_en;
		Data1_in_en_r1<=Data1_in_en_r0;
		Data1_in_en_r2<=Data1_in_en_r1;
		
		Data2_in_en_r0<=Data2_in_en;
		Data2_in_en_r1<=Data2_in_en_r0;
		Data2_in_en_r2<=Data2_in_en_r1;
		
		Data3_in_en_r0<=Data3_in_en;
		Data3_in_en_r1<=Data3_in_en_r0;
		Data3_in_en_r2<=Data3_in_en_r1;
	end

assign pos_Data0_in_en=(~Data0_in_en_r2)& Data0_in_en_r1 ;
assign neg_Data0_in_en=  Data0_in_en_r2&(~Data0_in_en_r1);   
assign pos_Data1_in_en=(~Data1_in_en_r2)& Data1_in_en_r1 ;
assign neg_Data1_in_en=  Data1_in_en_r2&(~Data1_in_en_r1);  
assign pos_Data2_in_en=(~Data2_in_en_r2)& Data2_in_en_r1 ;
assign neg_Data2_in_en=  Data2_in_en_r2&(~Data2_in_en_r1);  
assign pos_Data3_in_en=(~Data3_in_en_r2)& Data3_in_en_r1 ;
assign neg_Data3_in_en=  Data3_in_en_r2&(~Data3_in_en_r1);  

wire 	pos_Data0_out_en,neg_Data0_out_en;
wire 	pos_Data1_out_en,neg_Data1_out_en;
wire 	pos_Data2_out_en,neg_Data2_out_en;
wire 	pos_Data3_out_en,neg_Data3_out_en;
(* syn_preserve = 1 *)reg Data0_out_en_r0;
(* syn_preserve = 1 *)reg Data1_out_en_r0;
(* syn_preserve = 1 *)reg Data2_out_en_r0;
(* syn_preserve = 1 *)reg Data3_out_en_r0;
(* syn_preserve = 1 *)reg Data0_out_en_r1;
(* syn_preserve = 1 *)reg Data1_out_en_r1;
(* syn_preserve = 1 *)reg Data2_out_en_r1;
(* syn_preserve = 1 *)reg Data3_out_en_r1;
(* syn_preserve = 1 *)reg Data0_out_en_r2;
(* syn_preserve = 1 *)reg Data1_out_en_r2;
(* syn_preserve = 1 *)reg Data2_out_en_r2;
(* syn_preserve = 1 *)reg Data3_out_en_r2;

always@(posedge clk)
	begin
		Data0_out_en_r0<=Data0_out_en;
		Data0_out_en_r1<=Data0_out_en_r0;
		Data0_out_en_r2<=Data0_out_en_r1;
		
		Data1_out_en_r0<=Data1_out_en;
		Data1_out_en_r1<=Data1_out_en_r0;
		Data1_out_en_r2<=Data1_out_en_r1;
		
		Data2_out_en_r0<=Data2_out_en;
		Data2_out_en_r1<=Data2_out_en_r0;
		Data2_out_en_r2<=Data2_out_en_r1;
		
		Data3_out_en_r0<=Data3_out_en;
		Data3_out_en_r1<=Data3_out_en_r0;
		Data3_out_en_r2<=Data3_out_en_r1;
	end

assign pos_Data0_out_en=(~Data0_out_en_r2)& Data0_out_en_r1 ;
assign neg_Data0_out_en=  Data0_out_en_r2&(~Data0_out_en_r1);   
assign pos_Data1_out_en=(~Data1_out_en_r2)& Data1_out_en_r1 ;
assign neg_Data1_out_en=  Data1_out_en_r2&(~Data1_out_en_r1);  
assign pos_Data2_out_en=(~Data2_out_en_r2)& Data2_out_en_r1 ;
assign neg_Data2_out_en=  Data2_out_en_r2&(~Data2_out_en_r1);  
assign pos_Data3_out_en=(~Data3_out_en_r2)& Data3_out_en_r1 ;
assign neg_Data3_out_en=  Data3_out_en_r2&(~Data3_out_en_r1);  
	 
 always @(posedge clk)
	begin
		if(pos_Data0_out_en)Data0_out<=Data0_in ;
		else 							Data0_out<=Data0_out;
		
		if(pos_Data1_out_en)Data1_out<=Data1_in ;
		else 							Data1_out<=Data1_out;
		
		if(pos_Data2_out_en)Data2_out<=Data2_in ;
		else 							Data2_out<=Data2_out;
		
		if(pos_Data3_out_en)Data3_out<=Data3_in ;
		else 							Data3_out<=Data3_out;
		
	end

(* syn_preserve = 1 *)reg[15:0]decimate_cnt_Data0;
(* syn_preserve = 1 *)reg[15:0]decimate_cnt_Data1;
(* syn_preserve = 1 *)reg[15:0]decimate_cnt_Data2;
(* syn_preserve = 1 *)reg[15:0]decimate_cnt_Data3;
 always @(posedge clk)
	begin
		if(rst)
			begin
				decimate_cnt_Data0<=0;
				decimate_cnt_Data1<=0;
				decimate_cnt_Data2<=0;
				decimate_cnt_Data3<=0;
				Data0_out_en<=0;
				Data1_out_en<=0;
				Data2_out_en<=0;
				Data3_out_en<=0;
			end
		else
			begin
				if(pos_Data0_in_en)
					begin
						if(decimate_cnt_Data0==Data0_decimate_num)decimate_cnt_Data0<=0;
						else decimate_cnt_Data0<=decimate_cnt_Data0+1;
					end
				else decimate_cnt_Data0<=decimate_cnt_Data0;
				
				if(pos_Data1_in_en)
					begin
						if(decimate_cnt_Data1==Data0_decimate_num)decimate_cnt_Data1<=0;
						else decimate_cnt_Data1<=decimate_cnt_Data1+1;
					end
				else decimate_cnt_Data1<=decimate_cnt_Data1;
				
				if(pos_Data2_in_en)
					begin
						if(decimate_cnt_Data2==Data0_decimate_num)decimate_cnt_Data2<=0;
						else decimate_cnt_Data2<=decimate_cnt_Data2+1;
					end
				else decimate_cnt_Data2<=decimate_cnt_Data2;
				
				if(pos_Data3_in_en)
					begin
						if(decimate_cnt_Data3==Data0_decimate_num)decimate_cnt_Data3<=0;
						else decimate_cnt_Data3<=decimate_cnt_Data3+1;
					end
				else decimate_cnt_Data3<=decimate_cnt_Data3;
				
				if((decimate_cnt_Data0==Data0_decimate_num))Data0_out_en<=Data0_in_en_r2;
				else Data0_out_en<=0;
				if((decimate_cnt_Data1==Data1_decimate_num))Data1_out_en<=Data1_in_en_r2;
				else Data1_out_en<=0;
				if((decimate_cnt_Data2==Data2_decimate_num))Data2_out_en<=Data2_in_en_r2;
				else Data2_out_en<=0;
				if((decimate_cnt_Data3==Data3_decimate_num))Data3_out_en<=Data3_in_en_r2;
				else Data3_out_en<=0;
			end
	end
	
endmodule