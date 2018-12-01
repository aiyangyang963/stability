`timescale 1ns / 1ns

module signal_move(
	 input rst,
	 input clk,
	 
    input 	  [11:0]sigin,
	 output reg[11:0]sigout
	 
    );

(* syn_preserve = 1 *)reg [11:0]sigin_o,sigin_o0,sigin_o1,sigin_o2,sigin_o3,sigin_o4;
		
always@(*)
	begin
		sigin_o<=sigin;
		sigin_o0[11:0]<=sigin_o[11:0]-1;
		sigin_o1[11:0]<=~sigin_o0[11:0];
		if(sigin_o[11]) sigin_o2<={1'b0,sigin_o1[10:0]};
		else sigin_o2 <= sigin_o;
		sigin_o3<=sigin_o2+12'h7ff;
		if(sigin_o[11])sigin_o4<=sigin_o3-(2*(sigin_o3-12'h7ff));
		else sigin_o4<=sigin_o3;
		sigout<=sigin_o4;
	end	 
	 
endmodule