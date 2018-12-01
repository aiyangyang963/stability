`timescale 1 ns / 1 ns
module led_test(
		input wire	rst,
		input	 wire	CLK_IN,
		output reg	LED_FPGA0,
		output reg	LED_FPGA1
		);
		

reg[7:0]counter;
	
always@(posedge CLK_IN)
	begin
		if(counter==200)counter<=0;
		else counter<=counter+1;
	end
always@(posedge CLK_IN)
	begin
		if(counter==150)begin LED_FPGA0<=~LED_FPGA0;LED_FPGA1<=~LED_FPGA1;end
		else begin LED_FPGA0<=LED_FPGA0;LED_FPGA1<=LED_FPGA1;end
	end
endmodule