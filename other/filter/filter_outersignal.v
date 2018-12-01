`timescale 1ns / 1ns
//`define USE_scale_divisor
module filter_outersignal(
	 input rst,
	 input clk, //50M
	 input clk1,//400M
	 
	 input [15:0]Ch0_Data_ads1,
	 input [15:0]Ch1_Data_ads1,
	 input [15:0]Ch0_Data_ads2,
	 input [15:0]Ch1_Data_ads2,
	 
	 input Ch1_Data_en_ads2,
	 input Ch0_Data_en_ads2,
	 input Ch1_Data_en_ads1,
	 input Ch0_Data_en_ads1,
	 
	 input [15:0]Data_template,
	 input Data_template_en,
	 
    output wire[15:0]Ch0_Dataf_ads1,
    output wire[15:0]Ch1_Dataf_ads1,
    output wire[15:0]Ch0_Dataf_ads2,
    output wire[15:0]Ch1_Dataf_ads2,
   
    output wire Ch1_Dataf_sign_ads2,
    output wire Ch0_Dataf_sign_ads2,
    output wire Ch1_Dataf_sign_ads1,
    output wire Ch0_Dataf_sign_ads1,
   
    output reg Ch1_Dataf_en_ads2,
    output reg Ch0_Dataf_en_ads2,
    output reg Ch1_Dataf_en_ads1,
    output reg Ch0_Dataf_en_ads1,
   
    output wire[15:0]Ori_Ch0_Dataf_ads1,
    output wire[15:0]Ori_Ch1_Dataf_ads1,
    output wire[15:0]Ori_Ch0_Dataf_ads2,
    output wire[15:0]Ori_Ch1_Dataf_ads2,
	 
	 output wire Ori_Ch1_Dataf_en_ads2,
    output wire Ori_Ch0_Dataf_en_ads2,
    output wire Ori_Ch1_Dataf_en_ads1,
    output wire Ori_Ch0_Dataf_en_ads1,
   
    output reg[FILTEROUTWITH-1:0]ast_source_data_ch0_r,ast_source_data_ch0_r0,ast_source_data_ch0_r1,ast_source_data_ch0_r2,ast_source_data_ch0_r3,
    output reg ast_source_valid_ch0_r0,ast_source_valid_ch0_r1,ast_source_valid_ch0_r2,ast_source_valid_ch0_r3,
    output reg[FILTEROUTWITH-1:0]ast_source_data_ch1_r,ast_source_data_ch1_r0,ast_source_data_ch1_r1,ast_source_data_ch1_r2,ast_source_data_ch1_r3,
    output reg ast_source_valid_ch1_r0,ast_source_valid_ch1_r1,ast_source_valid_ch1_r2,ast_source_valid_ch1_r3,
    output reg[FILTEROUTWITH-1:0]ast_source_data_ch2_r,ast_source_data_ch2_r0,ast_source_data_ch2_r1,ast_source_data_ch2_r2,ast_source_data_ch2_r3,
    output reg ast_source_valid_ch2_r0,ast_source_valid_ch2_r1,ast_source_valid_ch2_r2,ast_source_valid_ch2_r3,
    output reg[FILTEROUTWITH-1:0]ast_source_data_ch3_r,ast_source_data_ch3_r0,ast_source_data_ch3_r1,ast_source_data_ch3_r2,ast_source_data_ch3_r3,
    output reg ast_source_valid_ch3_r0,ast_source_valid_ch3_r1,ast_source_valid_ch3_r2,ast_source_valid_ch3_r3
    );

parameter FILTEROUTWITH=48;	
parameter PEAKDECTWITH=16;	
 
(* syn_preserve = 1 *)reg [FILTEROUTWITH-1:0]filter_out_ch0,filter_out_ch1,filter_out_ch2,filter_out_ch3; 
(* syn_preserve = 1 *)reg filter_out_en_ch0,filter_out_en_ch1,filter_out_en_ch2,filter_out_en_ch3; 
(* syn_preserve = 1 *)wire [12:0]filter_in_ch0,filter_in_ch1,filter_in_ch2,filter_in_ch3;

(* keep = 1 *)assign filter_in_ch0 	= {1'b0,Ch0_Data_ads1[15:4]};
(* keep = 1 *)assign filter_in_ch1 	= {1'b0,Ch1_Data_ads1[15:4]};
(* keep = 1 *)assign filter_in_ch2 	= {1'b0,Ch0_Data_ads2[15:4]};
(* keep = 1 *)assign filter_in_ch3 	= {1'b0,Ch1_Data_ads2[15:4]};

(* syn_preserve = 1 *)wire [FILTEROUTWITH-1:0] ast_source_data_ch0,ast_source_data_ch1,ast_source_data_ch2,ast_source_data_ch3; 
(* syn_preserve = 1 *)wire       ast_source_valid_ch0,ast_source_valid_ch1,ast_source_valid_ch2,ast_source_valid_ch3; 
(* syn_preserve = 1 *)wire [1:0] ast_source_error_ch0,ast_source_error_ch1,ast_source_error_ch2,ast_source_error_ch3;

(* syn_preserve = 1 *)wire [15:0]APfilter_in_template,APfilter_out_template,APfilter_in_template_w,APfilter_out_template_w;
(* syn_preserve = 1 *)wire APfilter_in_template_en,APfilter_out_template_en;

`ifdef USE_scale_divisor

assign APfilter_in_template =APfilter_in_template_w;
assign APfilter_out_template=APfilter_out_template_w;

`else

assign APfilter_in_template =1;
assign APfilter_out_template=1;

`endif

filter_scale_divisor filter_scale_divisor(
	 .rst(rst),
	 .clk(clk), //50M
	 
	 .Data_template(Data_template),
	 .Data_template_en(Data_template_en),
	 
	 .APfilter_in_template(APfilter_in_template_w),
	 .APfilter_out_template(APfilter_out_template_w),
	 .APfilter_in_template_en(APfilter_in_template_en),
	 .APfilter_out_template_en(APfilter_out_template_en));

 
wire [31:0]filter_out_mult_result_ch0;
wire [31:0]filter_out_mult_result_ch1;
wire [31:0]filter_out_mult_result_ch2;
wire [31:0]filter_out_mult_result_ch3;

filter_out_mult filter_out_mult_ch0 (
	.dataa({4'b0,ast_source_data_ch0_r[37:27]}),
	.datab(APfilter_in_template),
	.result(filter_out_mult_result_ch0));
filter_out_mult filter_out_mult_ch1 (
	.dataa({4'b0,ast_source_data_ch1_r[37:27]}),
	.datab(APfilter_in_template),
	.result(filter_out_mult_result_ch1));
filter_out_mult filter_out_mult_ch2 (
	.dataa({4'b0,ast_source_data_ch2_r[37:27]}),
	.datab(APfilter_in_template),
	.result(filter_out_mult_result_ch2));
filter_out_mult filter_out_mult_ch3 (
	.dataa({4'b0,ast_source_data_ch3_r[37:27]}),
	.datab(APfilter_in_template),
	.result(filter_out_mult_result_ch3));

wire [31:0]filter_out_div_quotient_ch0;
wire [31:0]filter_out_div_quotient_ch1;
wire [31:0]filter_out_div_quotient_ch2;
wire [31:0]filter_out_div_quotient_ch3;
wire [15:0]filter_out_div_remain_ch0;
wire [15:0]filter_out_div_remain_ch1;
wire [15:0]filter_out_div_remain_ch2;
wire [15:0]filter_out_div_remain_ch3;
filter_out_divide filter_out_divide_ch0 (
	.numer(filter_out_mult_result_ch0),
	.denom(APfilter_out_template),
	.quotient(filter_out_div_quotient_ch0),
	.remain(filter_out_div_remain_ch0));
filter_out_divide filter_out_divide_ch1 (
	.numer(filter_out_mult_result_ch1),
	.denom(APfilter_out_template),
	.quotient(filter_out_div_quotient_ch1),
	.remain(filter_out_div_remain_ch1));
filter_out_divide filter_out_divide_ch2 (
	.numer(filter_out_mult_result_ch2),
	.denom(APfilter_out_template),
	.quotient(filter_out_div_quotient_ch2),
	.remain(filter_out_div_remain_ch2));
filter_out_divide filter_out_divide_ch3 (
	.numer(filter_out_mult_result_ch3),
	.denom(APfilter_out_template),
	.quotient(filter_out_div_quotient_ch3),
	.remain(filter_out_div_remain_ch3));

(* keep = 1 *)assign Ch0_Dataf_ads1 = filter_out_div_quotient_ch0[15:0];
(* keep = 1 *)assign Ch1_Dataf_ads1 = filter_out_div_quotient_ch1[15:0];
(* keep = 1 *)assign Ch0_Dataf_ads2 = filter_out_div_quotient_ch2[15:0];
(* keep = 1 *)assign Ch1_Dataf_ads2 = filter_out_div_quotient_ch3[15:0];

(* keep = 1 *)assign Ch0_Dataf_sign_ads1 = ast_source_data_ch0_r1[FILTEROUTWITH-1];
(* keep = 1 *)assign Ch1_Dataf_sign_ads1 = ast_source_data_ch1_r1[FILTEROUTWITH-1];
(* keep = 1 *)assign Ch0_Dataf_sign_ads2 = ast_source_data_ch2_r1[FILTEROUTWITH-1];
(* keep = 1 *)assign Ch1_Dataf_sign_ads2 = ast_source_data_ch3_r1[FILTEROUTWITH-1];

(* keep = 1 *)assign Ori_Ch0_Dataf_ads1={filter_out_ch0[47],filter_out_ch0[37:27]};
(* keep = 1 *)assign Ori_Ch1_Dataf_ads1={filter_out_ch1[47],filter_out_ch1[37:27]};
(* keep = 1 *)assign Ori_Ch0_Dataf_ads2={filter_out_ch2[47],filter_out_ch2[37:27]};
(* keep = 1 *)assign Ori_Ch1_Dataf_ads2={filter_out_ch3[47],filter_out_ch3[37:27]};

(* keep = 1 *)assign Ori_Ch1_Dataf_en_ads2=filter_out_en_ch3;
(* keep = 1 *)assign Ori_Ch0_Dataf_en_ads2=filter_out_en_ch2;
(* keep = 1 *)assign Ori_Ch1_Dataf_en_ads1=filter_out_en_ch1;
(* keep = 1 *)assign Ori_Ch0_Dataf_en_ads1=filter_out_en_ch0;

always@(posedge clk)
	begin
		if(ast_source_valid_ch0	  ||
		   ast_source_valid_ch0_r0||
			ast_source_valid_ch0_r1||
			ast_source_valid_ch0_r2||
			ast_source_valid_ch0_r3)Ch0_Dataf_en_ads1<=1;
		else Ch0_Dataf_en_ads1<=0;
		
		if(ast_source_valid_ch1	  ||
		   ast_source_valid_ch1_r0||
			ast_source_valid_ch1_r1||
			ast_source_valid_ch1_r2||
			ast_source_valid_ch1_r3)Ch1_Dataf_en_ads1<=1;
		else Ch1_Dataf_en_ads1<=0;
		
		if(ast_source_valid_ch2	  ||
		   ast_source_valid_ch2_r0||
			ast_source_valid_ch2_r1||
			ast_source_valid_ch2_r2||
			ast_source_valid_ch2_r3)Ch0_Dataf_en_ads2<=1;
		else Ch0_Dataf_en_ads2<=0;
		
		if(ast_source_valid_ch3	  ||
		   ast_source_valid_ch3_r0||
			ast_source_valid_ch3_r1||
			ast_source_valid_ch3_r2||
			ast_source_valid_ch3_r3)Ch1_Dataf_en_ads2<=1;
		else Ch1_Dataf_en_ads2<=0;	
	end

always@(posedge clk)
	begin
		ast_source_valid_ch0_r0<=ast_source_valid_ch0;
		ast_source_valid_ch0_r1<=ast_source_valid_ch0_r0;
		ast_source_valid_ch0_r2<=ast_source_valid_ch0_r1;
		ast_source_valid_ch0_r3<=ast_source_valid_ch0_r2;
		
		ast_source_valid_ch1_r0<=ast_source_valid_ch1;
		ast_source_valid_ch1_r1<=ast_source_valid_ch1_r0;
		ast_source_valid_ch1_r2<=ast_source_valid_ch1_r1;
		ast_source_valid_ch1_r3<=ast_source_valid_ch1_r2;
		
		ast_source_valid_ch2_r0<=ast_source_valid_ch2;
		ast_source_valid_ch2_r1<=ast_source_valid_ch2_r0;
		ast_source_valid_ch2_r2<=ast_source_valid_ch2_r1;
		ast_source_valid_ch2_r3<=ast_source_valid_ch2_r2;
		
		ast_source_valid_ch3_r0<=ast_source_valid_ch3;
		ast_source_valid_ch3_r1<=ast_source_valid_ch3_r0;
		ast_source_valid_ch3_r2<=ast_source_valid_ch3_r1;
		ast_source_valid_ch3_r3<=ast_source_valid_ch3_r2;
		
		ast_source_data_ch0_r1<=ast_source_data_ch0_r0;
		ast_source_data_ch0_r2<=ast_source_data_ch0_r1;
		ast_source_data_ch0_r3<=ast_source_data_ch0_r2;
		
		ast_source_data_ch1_r1<=ast_source_data_ch1_r0;
		ast_source_data_ch1_r2<=ast_source_data_ch1_r1;
		ast_source_data_ch1_r3<=ast_source_data_ch1_r2;
		
		ast_source_data_ch2_r1<=ast_source_data_ch2_r0;
		ast_source_data_ch2_r2<=ast_source_data_ch2_r1;
		ast_source_data_ch2_r3<=ast_source_data_ch2_r2;
		
		ast_source_data_ch3_r1<=ast_source_data_ch3_r0;
		ast_source_data_ch3_r2<=ast_source_data_ch3_r1;
		ast_source_data_ch3_r3<=ast_source_data_ch3_r2;
	end

wire 	pos_Ch0_Data_en_ads1;
wire 	pos_Ch1_Data_en_ads1;
wire 	pos_Ch0_Data_en_ads2;
wire 	pos_Ch1_Data_en_ads2;

reg Ch0_Data_en_ads1_r0,Ch0_Data_en_ads1_r1,Ch0_Data_en_ads1_r2;
reg Ch1_Data_en_ads1_r0,Ch1_Data_en_ads1_r1,Ch1_Data_en_ads1_r2;
reg Ch0_Data_en_ads2_r0,Ch0_Data_en_ads2_r1,Ch0_Data_en_ads2_r2;
reg Ch1_Data_en_ads2_r0,Ch1_Data_en_ads2_r1,Ch1_Data_en_ads2_r2;


always@(posedge clk)
	begin
		Ch0_Data_en_ads1_r0<=Ch0_Data_en_ads1;
		Ch0_Data_en_ads1_r1<=Ch0_Data_en_ads1_r0;
		Ch0_Data_en_ads1_r2<=Ch0_Data_en_ads1_r1;
		
		Ch1_Data_en_ads1_r0<=Ch1_Data_en_ads1;
		Ch1_Data_en_ads1_r1<=Ch1_Data_en_ads1_r0;
		Ch1_Data_en_ads1_r2<=Ch1_Data_en_ads1_r1;
		
		Ch0_Data_en_ads2_r0<=Ch0_Data_en_ads2;
		Ch0_Data_en_ads2_r1<=Ch0_Data_en_ads2_r0;
		Ch0_Data_en_ads2_r2<=Ch0_Data_en_ads2_r1;
		
		Ch1_Data_en_ads2_r0<=Ch1_Data_en_ads2;
		Ch1_Data_en_ads2_r1<=Ch1_Data_en_ads2_r0;
		Ch1_Data_en_ads2_r2<=Ch1_Data_en_ads2_r1;
	end

assign pos_Ch0_Data_en_ads1=(~Ch0_Data_en_ads1_r2)&Ch0_Data_en_ads1_r1;  
assign pos_Ch1_Data_en_ads1=(~Ch1_Data_en_ads1_r2)&Ch1_Data_en_ads1_r1; 
assign pos_Ch0_Data_en_ads2=(~Ch0_Data_en_ads2_r2)&Ch0_Data_en_ads2_r1; 
assign pos_Ch1_Data_en_ads2=(~Ch1_Data_en_ads2_r2)&Ch1_Data_en_ads2_r1; 

 		
fir_2_10hz fir_2_10hz_ch0 (
		.clk              (clk),            	 	//clk.clk
		.reset_n          (~rst),               	//rst.reset_n
		.ast_sink_data    (filter_in_ch0),        //avalon_streaming_sink.data
		.ast_sink_valid   (pos_Ch0_Data_en_ads1), //.valid
		.ast_sink_error   (0),   					 	//.error
		.ast_source_data  (ast_source_data_ch0),  //avalon_streaming_source.data
		.ast_source_valid (ast_source_valid_ch0), //.valid
		.ast_source_error (ast_source_error_ch0)  //.error
	);
	
always@(posedge clk)
	begin
		if(ast_source_valid_ch0)
			begin
				filter_out_ch0		<=ast_source_data_ch0;
				filter_out_en_ch0	<=1;
			end
		
		else 
			begin
				filter_out_ch0		<=filter_out_ch0;
				filter_out_en_ch0 <=0;
			end
	end

always@(posedge clk)
	begin
		if(ast_source_valid_ch0)
			begin
				if(ast_source_data_ch0[FILTEROUTWITH-1]) ast_source_data_ch0_r<={1'b0,(~(ast_source_data_ch0[(FILTEROUTWITH-2):0]-1))};
				else ast_source_data_ch0_r <= ast_source_data_ch0;
				ast_source_data_ch0_r0<=ast_source_data_ch0;
			end
		else 	
			begin
				ast_source_data_ch0_r	<=ast_source_data_ch0_r;
				ast_source_data_ch0_r0  <=ast_source_data_ch0_r0;
			end
	end
	
fir_2_10hz fir_2_10hz_ch1 (
		.clk              (clk),            	 	//clk.clk
		.reset_n          (~rst),               	//rst.reset_n
		.ast_sink_data    (filter_in_ch1),        //avalon_streaming_sink.data
		.ast_sink_valid   (pos_Ch1_Data_en_ads1), //.valid
		.ast_sink_error   (0),   					 	//.error
		.ast_source_data  (ast_source_data_ch1),  //avalon_streaming_source.data
		.ast_source_valid (ast_source_valid_ch1), //.valid
		.ast_source_error (ast_source_error_ch1)  //.error
	);
	
always@(posedge clk)
	begin
		if(ast_source_valid_ch1)
			begin
				filter_out_ch1		<=ast_source_data_ch1;
				filter_out_en_ch1	<=1;
			end
		
		else 
			begin
				filter_out_ch1		<=filter_out_ch1;
				filter_out_en_ch1 <=0;
			end
	end

always@(posedge clk)
	begin
		if(ast_source_valid_ch1)
			begin
				if(ast_source_data_ch1[FILTEROUTWITH-1]) ast_source_data_ch1_r<={1'b0,(~(ast_source_data_ch1[(FILTEROUTWITH-2):0]-1))};
				else ast_source_data_ch1_r <= ast_source_data_ch1;
				ast_source_data_ch1_r0<=ast_source_data_ch1;
			end
		else 	
			begin
				ast_source_data_ch1_r	<=ast_source_data_ch1_r;
				ast_source_data_ch1_r0<=ast_source_data_ch1_r0;
			end
	end
	
fir_2_10hz fir_2_10hz_ch2 (
		.clk              (clk),            	 	//clk.clk
		.reset_n          (~rst),               	//rst.reset_n
		.ast_sink_data    (filter_in_ch2),        //avalon_streaming_sink.data
		.ast_sink_valid   (pos_Ch0_Data_en_ads2), //.valid
		.ast_sink_error   (0),   					 	//.error
		.ast_source_data  (ast_source_data_ch2),  //avalon_streaming_source.data
		.ast_source_valid (ast_source_valid_ch2), //.valid
		.ast_source_error (ast_source_error_ch2)  //.error
	);
	
always@(posedge clk)
	begin
		if(ast_source_valid_ch2)
			begin
				filter_out_ch2		<=ast_source_data_ch2;
				filter_out_en_ch2	<=1;
			end
		
		else 
			begin
				filter_out_ch2		<=filter_out_ch2;
				filter_out_en_ch2 <=0;
			end
	end

always@(posedge clk)
	begin
		if(ast_source_valid_ch2)
			begin
				if(ast_source_data_ch2[FILTEROUTWITH-1]) ast_source_data_ch2_r<={1'b0,(~(ast_source_data_ch2[(FILTEROUTWITH-2):0]-1))};
				else ast_source_data_ch2_r <= ast_source_data_ch2;
				ast_source_data_ch2_r0<=ast_source_data_ch2;
			end
		else 	
			begin
				ast_source_data_ch2_r	<=ast_source_data_ch2_r;
				ast_source_data_ch2_r0<=ast_source_data_ch2_r0;
			end
	end
	
fir_2_10hz fir_2_10hz_ch3 (
		.clk              (clk),            	 	//clk.clk
		.reset_n          (~rst),               	//rst.reset_n
		.ast_sink_data    (filter_in_ch3),        //avalon_streaming_sink.data
		.ast_sink_valid   (pos_Ch1_Data_en_ads2), //.valid
		.ast_sink_error   (0),   					 	//.error
		.ast_source_data  (ast_source_data_ch3),  //avalon_streaming_source.data
		.ast_source_valid (ast_source_valid_ch3), //.valid
		.ast_source_error (ast_source_error_ch3)  //.error
	);
	
always@(posedge clk)
	begin
		if(ast_source_valid_ch3)
			begin
				filter_out_ch3		<=ast_source_data_ch3;
				filter_out_en_ch3	<=1;
			end
		
		else 
			begin
				filter_out_ch3		<=filter_out_ch3;
				filter_out_en_ch3 <=0;
			end
	end

always@(posedge clk)
	begin
		if(ast_source_valid_ch3)
			begin
				if(ast_source_data_ch3[FILTEROUTWITH-1]) ast_source_data_ch3_r<={1'b0,(~(ast_source_data_ch3[(FILTEROUTWITH-2):0]-1))};
				else ast_source_data_ch3_r <= ast_source_data_ch3;
				ast_source_data_ch3_r0<=ast_source_data_ch3;
			end
		else 	
			begin
				ast_source_data_ch3_r	<=ast_source_data_ch3_r;
				ast_source_data_ch3_r0<=ast_source_data_ch3_r0;
			end
	end	

(* syn_preserve = 1 *)wire [PEAKDECTWITH-1:0]Pfilter_in_ch0,Vfilter_in_ch0,Pfilter_out_ch0,Vfilter_out_ch0;
(* syn_preserve = 1 *)wire [PEAKDECTWITH-1:0]Pfilter_in_ch1,Vfilter_in_ch1,Pfilter_out_ch1,Vfilter_out_ch1;
(* syn_preserve = 1 *)wire [PEAKDECTWITH-1:0]Pfilter_in_ch2,Vfilter_in_ch2,Pfilter_out_ch2,Vfilter_out_ch2;
(* syn_preserve = 1 *)wire [PEAKDECTWITH-1:0]Pfilter_in_ch3,Vfilter_in_ch3,Pfilter_out_ch3,Vfilter_out_ch3;

(* syn_preserve = 1 *)wire Pfilter_in_ch0_en,Vfilter_in_ch0_en,Pfilter_out_ch0_en,Vfilter_out_ch0_en;
(* syn_preserve = 1 *)wire Pfilter_in_ch1_en,Vfilter_in_ch1_en,Pfilter_out_ch1_en,Vfilter_out_ch1_en;
(* syn_preserve = 1 *)wire Pfilter_in_ch2_en,Vfilter_in_ch2_en,Pfilter_out_ch2_en,Vfilter_out_ch2_en;
(* syn_preserve = 1 *)wire Pfilter_in_ch3_en,Vfilter_in_ch3_en,Pfilter_out_ch3_en,Vfilter_out_ch3_en;

defparam peak_detect_filterin.DATAWIDTH=PEAKDECTWITH;	
peak_detect peak_detect_filterin(
	.clk(clk),
	.rst(rst),
	 
	.Data0(filter_in_ch0),
	.Data0_en(Ch0_Data_en_ads1),
	.Data1(filter_in_ch0),
	.Data1_en(Ch1_Data_en_ads1),
	.Data2(filter_in_ch0),
	.Data2_en(Ch0_Data_en_ads2),
	.Data3(filter_in_ch0),
	.Data3_en(Ch1_Data_en_ads2),
	
	.PData0(Pfilter_in_ch0),
	.PData0_en(Pfilter_in_ch0_en),
	.VData0(Vfilter_in_ch0),
	.VData0_en(Vfilter_in_ch0_en),
	
	.PData1(Pfilter_in_ch1),
	.PData1_en(Pfilter_in_ch1_en),
	.VData1(Vfilter_in_ch1),
	.VData1_en(Vfilter_in_ch1_en),
	
	.PData2(Pfilter_in_ch2),
	.PData2_en(Pfilter_in_ch2_en),
	.VData2(Vfilter_in_ch2),
	.VData2_en(Vfilter_in_ch2_en),
	
	.PData3(Pfilter_in_ch3),
	.PData3_en(Pfilter_in_ch3_en),
	.VData3(Vfilter_in_ch3),
	.VData3_en(Vfilter_in_ch3_en));
	
defparam peak_detect_filterout.DATAWIDTH=PEAKDECTWITH;	
peak_detect peak_detect_filterout(
	.clk(clk),
	.rst(rst),
	 
	.Data0({4'b0,ast_source_data_ch0_r[37:26]}),
	.Data0_en(ast_source_valid_ch0_r),
	.Data1({4'b0,ast_source_data_ch1_r[37:26]}),
	.Data1_en(ast_source_valid_ch1_r),
	.Data2({4'b0,ast_source_data_ch2_r[37:26]}),
	.Data2_en(ast_source_valid_ch2_r),
	.Data3({4'b0,ast_source_data_ch3_r[37:26]}),
	.Data3_en(ast_source_valid_ch3_r),
	
	.PData0(Pfilter_out_ch0),
	.PData0_en(Pfilter_out_ch0_en),
	.VData0(Vfilter_out_ch0),
	.VData0_en(Vfilter_out_ch0_en),
	.PData1(Pfilter_out_ch1),
	.PData1_en(Pfilter_out_ch1_en),
	.VData1(Vfilter_out_ch1),
	.VData1_en(Vfilter_out_ch1_en),
	.PData2(Pfilter_out_ch2),
	.PData2_en(Pfilter_out_ch2_en),
	.VData2(Vfilter_out_ch2),
	.VData2_en(Vfilter_out_ch2_en),
	.PData3(Pfilter_out_ch3),
	.PData3_en(Pfilter_out_ch3_en),
	.VData3(Vfilter_out_ch3),
	.VData3_en(Vfilter_out_ch3_en));

(* syn_preserve = 1 *)wire [PEAKDECTWITH-1:0]quotient_ch0,quotient_ch1,quotient_ch2,quotient_ch3;
(* syn_preserve = 1 *)wire [PEAKDECTWITH-1:0]quotient_ch0_calibration,quotient_ch1_calibration,quotient_ch2_calibration,quotient_ch3_calibration;
(* syn_preserve = 1 *)wire [PEAKDECTWITH-1:0]remain_ch0,remain_ch1,remain_ch2,remain_ch3;
(* syn_preserve = 1 *)wire [PEAKDECTWITH-1:0]remain_ch0_calibration,remain_ch1_calibration,remain_ch2_calibration,remain_ch3_calibration;

peak_divide peak_divide_ch0_calibration(
	.numer(Pfilter_in_ch0_calibration),
	.denom(Pfilter_out_ch0_calibration),
	.quotient(quotient_ch0_calibration),
	.remain(remain_ch0_calibration));
	
peak_divide peak_divide_ch0 (
	.numer(Pfilter_in_ch0),
	.denom(Pfilter_out_ch0),
	.quotient(quotient_ch0),
	.remain(remain_ch0));
peak_divide peak_divide_ch1 (
	.numer(Pfilter_in_ch1),
	.denom(Pfilter_out_ch1),
	.quotient(quotient_ch1),
	.remain(remain_ch1));
peak_divide peak_divide_ch2 (
	.numer(Pfilter_in_ch2),
	.denom(Pfilter_out_ch2),
	.quotient(quotient_ch2),
	.remain(remain_ch2));
peak_divide peak_divide_ch3 (
	.numer((Pfilter_in_ch0/3)),
	.denom(Pfilter_out_ch3),
	.quotient(quotient_ch3),
	.remain(remain_ch3));

	
endmodule