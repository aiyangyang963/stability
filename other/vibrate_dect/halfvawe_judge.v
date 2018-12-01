`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
module vibrate_dect(
    input clk,
	 
	 input channel_2_en,
	 input [15:0]channel_2_dat,
	 output reg channel_2_alarm,
	 
	 input channel_3_en,
	 input [15:0]channel_3_dat,
	 output reg channel_3_alarm
    );
	 
//parameter define
parameter base_line_h = 16'h8500;
parameter base_line_l = 16'h7500;
parameter high_threshold =16'ha000;
parameter low_threshold  =16'h4000;
parameter high_cnt =10;
parameter low_cnt  =5;

reg	[15:0]data_high;
reg	rdreq_high;
reg	wrreq_high;
wire  empty_high;
wire  full_high;
wire 	[15:0]q_high;
wire 	[8:0]usedw_high;

wire [15:0]datn;
reg  [15:0]datn_d1,datn_d2;
(* syn_preserve = 1 *)reg [7:0] halfvaweh_s;
always@(posedge clk)
	begin
		case(halfvaweh_s)
				0:begin
						if(pos_channel_2_en)
							begin
								if(channel_2_dat<base_line_h)	halfvaweh_s<=1;
								else halfvaweh_s<=0;
							end
						else halfvaweh_s<=0;
					  end
				1:begin
						if(pos_channel_2_en)
							begin
								if(channel_2_dat>=base_line_h) halfvaweh_s<=2;
								else halfvaweh_s<=0;
							end
						else halfvaweh_s<=1;
					  end
				2:begin
						if(pos_channel_2_en)
							begin
								if(channel_2_dat>base_line_h)	halfvaweh_s<=3;
								else halfvaweh_s<=0;
							end
						else halfvaweh_s<=2;
					  end
				3:begin//later can add overtime for every state
						if(pos_channel_2_en)
							begin
								if(channel_2_dat<=base_line_h) halfvaweh_s<=4;
								else halfvaweh_s<=3;
							end
						else halfvaweh_s<=3;
					  end
				4:begin
						if(pos_channel_2_en)
							begin	
								if(channel_2_dat<base_line_h)  halfvaweh_s<=0;
								else halfvaweh_s<=3;
							end
							&&
						else halfvaweh_s<=4;
					  end
				default:begin
						halfvaweh_s<=0;
					  end
		endcase
	end

fifo_halfwave	fifo_halfwave_high (
	.clock ( clk ),
	.data  ( data_high ),
	.rdreq ( rdreq_high ),
	.wrreq ( wrreq_high ),
	.empty ( empty_high ),
	.full  ( full_high ),
	.q 	 ( q_high ),
	.usedw ( usedw_high )
	);
	
reg	[15:0]data_low;
reg	rdreq_low;
reg	wrreq_low;
wire  empty_low;
wire  full_low;
wire 	[15:0]q_low;
wire 	[8:0]usedw_low;
	
fifo_halfwave	fifo_halfwave_low (
	.clock ( clk ),
	.data  ( data_low ),
	.rdreq ( rdreq_low ),
	.wrreq ( wrreq_low ),
	.empty ( empty_low ),
	.full  ( full_low ),
	.q 	 ( q_low ),
	.usedw ( usedw_low )
	);

	
endmodule
