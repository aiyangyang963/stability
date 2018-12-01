`timescale 1ns / 1ns

module K64_SPI(input clk,
			  input rst_n,
			  output wire CS_N,
			  output wire SCK,
			  input MOSI,
			  output wire MISO);

reg csn,dout;			  
wire sclk = (~csn)?clk:0;
assign SCK = sclk;
assign CS_N = csn;
assign MISO = dout;

reg [7:0]byte_cnt,pkg_cnt,frame_cnt;
reg [7:0]dat_temp;
reg [7:0] tx_state;
always@(posedge clk)
	begin
		case(tx_state)
				0:begin
						csn <= 1;
						byte_cnt <= 0;
						pkg_cnt <= pkg_cnt;
						frame_cnt<=0;
						dat_temp <= dat_temp;
						tx_state <= 1;
					  end
				1:begin
						csn <= 0;
						dout <= dat_temp[byte_cnt];
						byte_cnt <= byte_cnt +1;
						if(byte_cnt==7)tx_state <= 2;
						else tx_state <=1;
					  end
				2:begin
						csn <= 1;
						pkg_cnt <= pkg_cnt +1;
						dat_temp<= dat_temp+1;
						if(pkg_cnt==9)tx_state <=3;
						else tx_state <=0;
					  end
				3:begin	
						csn <= 1;
						dout <= 1;
						if(frame_cnt==100)tx_state <=0;
						else tx_state <=3;
						frame_cnt<=frame_cnt+1;
				     end
				default:begin
						csn <= 1;
						dout <= 1;
						byte_cnt <= 0;
						pkg_cnt <= 0;
						dat_temp <= 0;
						tx_state <= 0;
						frame_cnt<= 0;
					  end
		endcase
	end
			  

endmodule
