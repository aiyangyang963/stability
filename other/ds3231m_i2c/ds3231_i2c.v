`timescale 1 ns / 1 ns
module ds3231_i2c
	(
		input rst,
		input clk_50m,
		input clk_250k,
		inout sda,
		output wire scl,
		
		input write_start_uart,
		output wire write_over_uart,
		input [47:0]write_dat_uart,
		
		output wire [7:0]ds_MsecondsL,		
		output wire [7:0]ds_MsecondsH,
		output wire [7:0]ds_Seconds,
		output wire [7:0]ds_Minutes,
		output wire [7:0]ds_Hour,
		output wire [7:0]ds_Date,
		output wire [7:0]ds_Month,
		output wire [7:0]ds_Year);
	
wire bclk=clk_250k;

wire write_start;
wire write_over;
wire[7:0]write_add;
wire [7:0]write_dat;

wire read_start;
wire read_over;
wire [7:0]read_add;
wire [7:0]read_dat;
(* syn_preserve = 1 *)wire scl_wr,scl_rd;
(* syn_preserve = 1 *)wire en_wr,en_rd;
wire sda_reg_wr,sda_reg_rd;

assign scl=(write_start)?scl_wr:
			  (read_start) ?scl_rd:1;

wire sda_wr = sda;
wire sda_rd = sda;

assign sda=(en_wr&write_start)?sda_reg_wr:
			  (en_rd&read_start )?sda_reg_rd:1'bz;	

ds3231_control ds3231_control
(
	.rst(rst),
	.clk(bclk),
	.clk_50m(clk_50m),
	
	.write_start_uart(write_start_uart),
	.write_over_uart(write_over_uart),
	.write_dat_uart(write_dat_uart),
	
	.write_start(write_start),
	.write_over(write_over),
	.write_add(write_add),
	.write_dat(write_dat),
	
	.read_start(read_start),
	.read_over(read_over),
	.read_add(read_add),
	.read_dat(read_dat),
	
	.ds_MsecondsL(ds_MsecondsL),		
	.ds_MsecondsH(ds_MsecondsH),
	.ds_Seconds(ds_Seconds),
	.ds_Minutes(ds_Minutes),
	.ds_Hour(ds_Hour),
	.ds_Date(ds_Date),
	.ds_Month(ds_Month),
	.ds_Year(ds_Year));
	

i2c_write i2c_write
(
	.rst(rst),
	.clk(bclk),
	.sda(sda_wr),
	.scl(scl_wr),
	.sda_reg(sda_reg_wr),
	.en(en_wr),

	.start(write_start),
	.over(write_over),
	
	.deviceaddw(8'b1101_000_0),
	.wradd(write_add),
	.wrdat(write_dat)
);


i2c_read i2c_read
(
	.rst(rst),
	.clk(bclk),
	.sda(sda_rd),
	.scl(scl_rd),
	.sda_reg(sda_reg_rd),
	.en(en_rd),
	
	.start(read_start),
	.over(read_over),
	
	.deviceaddw(8'b1101_000_0),
	.rdaddr(read_add),
	.deviceaddr(8'b1101_000_1),
	.rddat(read_dat)

);
		
endmodule