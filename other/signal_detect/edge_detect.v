`timescale 1 ns / 1 ns
module edge_detect(
		input clk,
		input signal,
		
		output wire pos_signal,
		output wire neg_signal
	);


reg signal_r0,signal_r1,signal_r2;
always@(posedge clk)
	begin
		signal_r0<=signal;
		signal_r1<=signal_r0;
		signal_r2<=signal_r1;
	end

assign pos_signal=(~signal_r2)&signal_r1;
assign neg_signal=signal_r2&(~signal_r1);  
	
endmodule