`timescale 1 ns / 1 ns
module ds3231_initialize
	(
		input rst,
		input clk_250k,
		
		output reg write_start,
		input write_over,
		output reg[47:0]write_dat
	);
	
wire 	pos_inikey,neg_inikey;
reg inikey_r0,inikey_r1,inikey_r2;

wire 	pos_write_over,neg_write_over;
reg write_over_r0,write_over_r1,write_over_r2;
always@(posedge clk_250k)
	begin
		inikey_r0<=inikey;
		inikey_r1<=inikey_r0;
		inikey_r2<=inikey_r1;
		
		write_over_r0<=write_over;
		write_over_r1<=write_over_r0;
		write_over_r2<=write_over_r1;
	end

assign pos_inikey=(~inikey_r2)&inikey_r1;
assign neg_inikey=inikey_r2&(~inikey_r1);  

assign pos_write_over=(~write_over_r2)&write_over_r1;
assign neg_write_over=write_over_r2&(~write_over_r1); 

(* syn_preserve = 1 *)reg[7:0]ds_ini_state;
	always @ (posedge clk_250k or posedge rst)	
		begin
			if(rst)
				begin
					ds_ini_state<=0;
					write_start <=0;
				end
			else
				begin
					case (ds_ini_state)
						0://write ini
							begin
								if((pos_inikey)||(neg_inikey))ds_ini_state<=1;
								else ds_ini_state<=0;
								write_start 	  <=0;
								write_dat		  <=0;
							end	
						1:
							begin
								if(pos_write_over)ds_ini_state<=0;
								else ds_ini_state<=1;
								write_start 	  <=1;
								write_dat		  <=inivalue;
							end
						default:
							begin
								ds_ini_state<=0;
								write_start <=0;
								write_dat	<=0;
							end
					endcase
				end
		end	
		
wire inikey;
wire [47:0]inivalue;	
ds3231_inikey ds3231_inikey(
	.source(inikey),
	.probe(inikey),
	
	.source_ena(1),
	.source_clk(clk_250k));	
	
ds3231_value ds3231_value(
	.source(inivalue),
	.probe(inivalue),
	
	.source_ena(1),
	.source_clk(clk_250k));	
	
endmodule