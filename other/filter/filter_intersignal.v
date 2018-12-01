`timescale 1ns / 1ns

module filter_intersignal(
	 input rst,
	 input clk1,//50M
	 
	 input [11:0]signal_nco,signal_out_6Hz_decimate,signal_out_15Hz_decimate,signal_out_mix_decimate,
	 input signal_enable_decimate,
	 input sample_clk,
	 
	 output reg[FILTEROUTWITH_NCO-1:0]ast_source_data_nco_r,ast_source_data_nco_r0,ast_source_data_nco_r1,ast_source_data_nco_r2,
	 output reg ast_source_valid_nco_r
    );
	 
wire 	pos_signal_enable_decimate;
reg signal_enable_decimate_r0,signal_enable_decimate_r1,signal_enable_decimate_r2;
always@(posedge clk1)
	begin
		signal_enable_decimate_r0<=signal_enable_decimate;
		signal_enable_decimate_r1<=signal_enable_decimate_r0;
		signal_enable_decimate_r2<=signal_enable_decimate_r1;
	end

assign pos_signal_enable_decimate=(~signal_enable_decimate_r2)&signal_enable_decimate_r1; 	 
	 
parameter FILTEROUTWITH_NCO=24;	
(* syn_preserve = 1 *)wire [12:0]filter_in_nco;
assign filter_in_nco = {1'b0,signal_out_mix_decimate};
(* syn_preserve = 1 *)wire [FILTEROUTWITH_NCO-1:0] ast_source_data_nco; 
(* syn_preserve = 1 *)wire        ast_source_valid_nco; 
(* syn_preserve = 1 *)wire [1:0]  ast_source_error_nco;  

fir_2_10hz_nco fir_2_10hz_nco (
		.clk              (clk1),            	 	//clk.clk
		.reset_n          (~rst),               	//rst.reset_n
		.ast_sink_data    (filter_in_nco),        //avalon_streaming_sink.data
		.ast_sink_valid   (pos_signal_enable_decimate), 							//.valid
		.ast_sink_error   (0),   					 	//.error
		.ast_source_data  (ast_source_data_nco),  //avalon_streaming_source.data
		.ast_source_valid (ast_source_valid_nco), //.valid
		.ast_source_error (ast_source_error_nco)  //.error
	);
always@(*)
	begin
		ast_source_data_nco_r0[FILTEROUTWITH_NCO-10]		<=	ast_source_data_nco[FILTEROUTWITH_NCO-1];
		ast_source_data_nco_r0[FILTEROUTWITH_NCO-11:0]	<= ast_source_data_nco[FILTEROUTWITH_NCO-11:0];
	end
	
always@(posedge clk1)
	begin
		if(ast_source_valid_nco)
			begin
				if(ast_source_data_nco[FILTEROUTWITH_NCO-1]) 
					begin
						ast_source_data_nco_r<={1'b0,(~(ast_source_data_nco[(FILTEROUTWITH_NCO-2):0]-1))};
					end
					
				else 
					begin
						ast_source_data_nco_r <= ast_source_data_nco;
					end
					
				
				
				ast_source_valid_nco_r<=1;
			end
		else 	
			begin
				ast_source_data_nco_r	<=ast_source_data_nco_r;
				ast_source_valid_nco_r<=0;
			end
			
	end
	
endmodule