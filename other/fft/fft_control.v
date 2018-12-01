`timescale 1ns / 1ns

module fft_control(
	 input rst,
	 input clk,
	 
	 
	 input [11:0]Ch0_Data_ads1,
	 input [11:0]Ch1_Data_ads1,
	 input [11:0]Ch0_Data_ads2,
	 input [11:0]Ch1_Data_ads2,
	 
	 input Ch1_Data_en_ads2,
	 input Ch0_Data_en_ads2,
	 input Ch1_Data_en_ads1,
	 input Ch0_Data_en_ads1,
	 
	 output wire ch0_ads2_clk,
	 output wire ch0_ads2_reset_n,
	 output reg ch0_ads2_sink_valid,
	 input  ch0_ads2_sink_ready,
	 output wire[1:0]ch0_ads2_sink_error,
	 output reg ch0_ads2_sink_sop,
	 output reg ch0_ads2_sink_eop,
	 output reg[11:0]ch0_ads2_sink_real,
	 output [11:0]ch0_ads2_sink_imag,
	 
	 input ch0_ads2_source_valid
	 
    );
	 
	 assign ch0_ads2_reset_n =~rst_out;
	 assign ch0_ads2_sink_error =0;
	 assign ch0_ads2_clk=Ch0_Data_en_ads2;

(* syn_preserve = 1 *)reg [15:0]frame_cnt=0;
(* syn_preserve = 1 *)reg [7:0]frame_state=0;
(* syn_preserve = 1 *)reg [15:0]frame_delay=0;
	always @ (posedge clk or posedge rst_out)	
		begin
			if(rst_out)
				begin
					frame_state=0;
				end
			else
				begin
					case (frame_state)
						0://read
							begin
								if(ch0_ads2_source_valid)frame_state<=1;
								else frame_state<=0;
							end	
						1:
							begin
								if(~ch0_ads2_source_valid)frame_state<=0;
								else frame_state<=1; 
//								if(frame_delay<20000)
//									begin
//										frame_delay<=frame_delay+1;
//									end
//								else
//									begin
//										frame_delay<=0;
//									end
							end
						default:
							begin

							end
					endcase
				end
		end

always@(posedge clk)
	begin
		if(frame_state==0)
			begin
				if(ch0_ads2_sink_ready)
					begin
						if(frame_cnt==0) ch0_ads2_sink_sop<=1;
						else ch0_ads2_sink_sop<=0;
						if(frame_cnt==1023)ch0_ads2_sink_eop<=1;
						else ch0_ads2_sink_eop<=0;
						if(frame_cnt==1023)frame_cnt<=0;
						else frame_cnt<=frame_cnt+1;
						ch0_ads2_sink_valid=1;
						ch0_ads2_sink_real<=Ch0_Data_ads2;
					end
				else
					begin
						ch0_ads2_sink_sop<=0;
						ch0_ads2_sink_eop<=0;
						ch0_ads2_sink_valid=0;
						frame_cnt<=frame_cnt;
						ch0_ads2_sink_real<=0;
					end
			end
		else
			begin
				ch0_ads2_sink_sop<=0;
				ch0_ads2_sink_eop<=0;
				ch0_ads2_sink_valid=0;
				frame_cnt<=0;
				ch0_ads2_sink_real<=0;
			end
	end	 

reg[7:0] rst_cnt = 0;	
reg rst_out;
always @(posedge clk)begin
	if (rst_cnt < 100)  begin
		rst_cnt <=rst_cnt + 1;
		rst_out <= 1'b1;
	end
	else begin
		rst_out <= 1'b0;
	end
end
	
endmodule