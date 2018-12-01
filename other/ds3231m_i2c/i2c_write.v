`timescale 1 ns / 1 ns
module i2c_write
	(
		input rst,
		input clk,
		input sda,
		output reg scl,
		output reg sda_reg,
		output reg en,
		
		input start,
		output reg over,
		
		input [7:0]deviceaddw,
		input [7:0]wradd,
		input [7:0]wrdat
	);
//control signal from uart edge detect
wire 	pos_start,neg_start;
reg start_r0,start_r1,start_r2;
always@(posedge clk)
	begin
		start_r0<=start;
		start_r1<=start_r0;
		start_r2<=start_r1;
	end

assign pos_start=(~start_r2)&start_r1;
assign neg_start=start_r2&(~start_r1);  

reg [7:0] cnt;

wire [7:0]DEVICEADDR	=deviceaddw;
wire [7:0]BYTEADDR	=wradd;
wire [7:0]BYTEWRITE	=wrdat;

//assign sda=en?sda_reg:1'bz;	

always @ (posedge clk or posedge rst)	
begin
	if(rst)
		begin
			en<=1'b1;
			sda_reg<=1'b1;
			scl<=1'b1;
			cnt<=0;
			over<=0;
		end
	else
		begin
			if(start)
				begin
					cnt<=cnt+1'b1;
					case (cnt)
						0:begin en<=1'b1;end
						
						1:begin scl<=1'b1;end//start
						2:begin sda_reg<=1'b1;end
						3:begin sda_reg<=1'b0;end
						
						4:begin scl<=1'b0;sda_reg<=DEVICEADDR[7];end
						5:begin scl<=1'b1;end	
						
						6:begin scl<=1'b0;sda_reg<=DEVICEADDR[6];end
						7:begin scl<=1'b1;end	
						
						8:begin scl<=1'b0;sda_reg<=DEVICEADDR[5];end
						9:begin scl<=1'b1;end	
						
						10:begin scl<=1'b0;sda_reg<=DEVICEADDR[4];end
						11:begin scl<=1'b1;end	
						
						12:begin scl<=1'b0;sda_reg<=DEVICEADDR[3];end
						13:begin scl<=1'b1;end	
						
						14:begin scl<=1'b0;sda_reg<=DEVICEADDR[2];end
						15:begin scl<=1'b1;end	
						
						16:begin scl<=1'b0;sda_reg<=DEVICEADDR[1];end
						17:begin scl<=1'b1;end			
						
						18:begin scl<=1'b0;sda_reg<=DEVICEADDR[0];end
						19:begin scl<=1'b1;end	
						20:begin scl<=1'b0;end//first put scl down then,set en
						
						21:begin en<=1'b0; end//set sda input,ready to receive device ACK
						22:begin scl<=1'b1;end
						23:begin
							scl<=1'b0;	
							if (sda==1'b0) //ack
								begin cnt<=24;end
							else
								begin cnt<=22;end
							end
					
						24:begin en<=1'b1;end//sda output
						25:begin scl<=1'b0;sda_reg=BYTEADDR[7];end//address MSB
						26:begin scl<=1'b1;end
						
						27:begin scl<=1'b0;sda_reg=BYTEADDR[6];end
						28:begin scl<=1'b1;end
						
						29:begin scl<=1'b0;sda_reg=BYTEADDR[5];end
						30:begin scl<=1'b1;end
						
						31:begin scl<=1'b0;sda_reg=BYTEADDR[4];end
						32:begin scl<=1'b1;end
						
						33:begin scl<=1'b0;sda_reg=BYTEADDR[3];end
						34:begin scl<=1'b1;end
						
						35:begin scl<=1'b0;sda_reg=BYTEADDR[2];end
						36:begin scl<=1'b1;end
						
						37:begin scl<=1'b0;sda_reg=BYTEADDR[1];end
						38:begin scl<=1'b1;end
						
						39:begin scl<=1'b0;sda_reg=BYTEADDR[0];end//LSB
						40:begin scl<=1'b1;end
						41:begin scl<=1'b0;end
						
						42:begin en<=1'b0;end//set sda input,ready to receive device ACK
						43:begin scl<=1'b1;end
						44:begin
							scl<=1'b0;
							if (sda==1'b0) //ack
								begin cnt<=45;end
							else
								cnt<=43;
							end
						45:begin en<=1'b1;end//sda output
						46:begin scl<=1'b0;sda_reg=BYTEWRITE[7];end//dat MSB
						47:begin scl<=1'b1;end
						
						48:begin scl<=1'b0;sda_reg=BYTEWRITE[6];end
						49:begin scl<=1'b1;end
						
						50:begin scl<=1'b0;sda_reg=BYTEWRITE[5];end
						51:begin scl<=1'b1;end
						
						52:begin scl<=1'b0;sda_reg=BYTEWRITE[4];end
						53:begin scl<=1'b1;end
						
						54:begin scl<=1'b0;sda_reg=BYTEWRITE[3];end
						55:begin scl<=1'b1;end
						
						56:begin scl<=1'b0;sda_reg=BYTEWRITE[2];end
						57:begin scl<=1'b1;end
						
						58:begin scl<=1'b0;sda_reg=BYTEWRITE[1];end
						59:begin scl<=1'b1;end
						
						60:begin scl<=1'b0;sda_reg=BYTEWRITE[0];end
						61:begin scl<=1'b1;end
						62:begin scl<=1'b0;end
						
						63:begin en<=1'b0;end//sda input
						64:begin scl<=1'b1;end
						65:begin
							scl<=1'b0;
							if (sda==1'b0) //ack
								begin cnt<=66;end
							else
								cnt<=64;
							end
						
						66:begin en<=1'b1;end//sda output
						
						67:begin scl<=1'b1;end//stop
						68:begin sda_reg<=1'b0;end
						69:begin sda_reg<=1'b1;end
						70:begin over<=1;end
						
						default:
							begin
								en<=1'b1;
								sda_reg<=1'b1;
								scl<=1'b1;
								cnt<=0;
								over<=0;
							end
					endcase
				end
			else
				begin
					en<=1'b1;
					sda_reg<=1'b1;
					scl<=1'b1;
					cnt<=0;
					over<=0;
				end
		
	end
end
	
endmodule