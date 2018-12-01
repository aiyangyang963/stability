`timescale 1 ns / 1 ns
module i2c_read
	(
		input rst,
		input clk,
		input sda,
		output reg scl,
		output reg sda_reg,
		output reg en,
		
		input start,
		output reg over,
		
		input [7:0]deviceaddw,deviceaddr,rdaddr,
		output wire[7:0]rddat
	
	);
wire [7:0]DEVICEADDRWRITE=deviceaddw;
wire [7:0]BYTEADDR=rdaddr;
wire [7:0]DEVICEADDRREAD=deviceaddr;

wire bclk;
reg [7:0] dataread;//read data from i2c
assign rddat = dataread;

reg [7:0] cnt;

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
							
							4:begin scl<=1'b0;sda_reg<=DEVICEADDRWRITE[7];end
							5:begin scl<=1'b1;end	
							
							6:begin scl<=1'b0;sda_reg<=DEVICEADDRWRITE[6];end
							7:begin scl<=1'b1;end	
							
							8:begin scl<=1'b0;sda_reg<=DEVICEADDRWRITE[5];end
							9:begin scl<=1'b1;end	
							
							10:begin scl<=1'b0;sda_reg<=DEVICEADDRWRITE[4];end
							11:begin scl<=1'b1;end	
							
							12:begin scl<=1'b0;sda_reg<=DEVICEADDRWRITE[3];end
							13:begin scl<=1'b1;end	
							
							14:begin scl<=1'b0;sda_reg<=DEVICEADDRWRITE[2];end
							15:begin scl<=1'b1;end	
							
							16:begin scl<=1'b0;sda_reg<=DEVICEADDRWRITE[1];end
							17:begin scl<=1'b1;end			
							
							18:begin scl<=1'b0;sda_reg<=DEVICEADDRWRITE[0];end
							19:begin scl<=1'b1;end	
							20:begin scl<=1'b0;end//set scl down,then set en
							
							21:begin en<=1'b0; end//sda use as input,ready for receive ACK
							22:begin scl<=1'b1;end
							23:begin
								scl<=1'b0;	
								if (sda==1'b0) //ack
									begin cnt<=24;end
								else
									begin cnt<=22;end
								end
						
							24:begin en<=1'b1;end//sda output
							25:begin scl<=1'b0;sda_reg=BYTEADDR[7];end//addr MSB
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
							
							42:begin en<=1'b0;end//sda use as input,ready for receive ACK
							43:begin scl<=1'b1;end
							44:begin
								scl<=1'b0;
								if (sda==1'b0) //ack
									begin cnt<=45;end
								else
									cnt<=43;
								end
							//start,secondly
							45:begin en<=1'b1;end//sda output
							46:begin scl<=1'b1;end
							47:begin sda_reg<=1'b1;end
							48:begin sda_reg<=1'b0;end
							
							49:begin scl<=1'b0;sda_reg<=DEVICEADDRREAD[7];end
							50:begin scl<=1'b1;end	
							
							51:begin scl<=1'b0;sda_reg<=DEVICEADDRREAD[6];end
							52:begin scl<=1'b1;end	
							
							53:begin scl<=1'b0;sda_reg<=DEVICEADDRREAD[5];end
							54:begin scl<=1'b1;end	
							
							55:begin scl<=1'b0;sda_reg<=DEVICEADDRREAD[4];end
							56:begin scl<=1'b1;end	
							
							57:begin scl<=1'b0;sda_reg<=DEVICEADDRREAD[3];end
							58:begin scl<=1'b1;end	
							
							59:begin scl<=1'b0;sda_reg<=DEVICEADDRREAD[2];end
							60:begin scl<=1'b1;end	
							
							61:begin scl<=1'b0;sda_reg<=DEVICEADDRREAD[1];end
							62:begin scl<=1'b1;end			
							
							63:begin scl<=1'b0;sda_reg<=DEVICEADDRREAD[0];end
							64:begin scl<=1'b1;end	
							65:begin scl<=1'b0;end//set scl down,then set en
							
							66:begin en<=1'b0; end//sda use as input,ready for receive ACK
							67:begin scl<=1'b1;end
							68:begin
								scl<=1'b0;	
								if (sda==1'b0) //ack
									begin cnt<=69;end//
								else
									begin cnt<=67;end
								end
							
							//sda as input,begin to read data from i2c
							69:begin scl<=1'b1;end
							70:begin dataread[7]=sda;end
							71:begin scl<=1'b0;end
							
							72:begin scl<=1'b1;end
							73:begin dataread[6]=sda;end
							74:begin scl<=1'b0;end
							
							75:begin scl<=1'b1;end
							76:dataread[5]=sda;
							77:begin scl<=1'b0;end
							
							78:begin scl<=1'b1;end
							79:dataread[4]=sda;
							80:begin scl<=1'b0;end
							
							81:begin scl<=1'b1;end
							82:dataread[3]=sda;
							83:begin scl<=1'b0;end
							
							84:begin scl<=1'b1;end
							85:dataread[2]=sda;
							86:begin scl<=1'b0;end
							
							87:begin scl<=1'b1;end
							88:dataread[1]=sda;
							89:begin scl<=1'b0;end
							
							90:begin scl<=1'b1;end
							91:dataread[0]=sda;
							92:begin scl<=1'b0;end
							
							93:begin en<=1'b1;end//sda output,don't send ack signal
							
							94:begin scl<=1'b1;end//stop
							95:begin sda_reg<=1'b0;end
							96:begin sda_reg<=1'b1;end
							97:begin over<=1'b1;end
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