`timescale 1ns / 1ps


module top_th;

	// Inputs
	reg clk;


	// Instantiate the Unit Under Test (UUT)
 top uut(
/**************clock in***************/
			.clk_in1(clk),
			.clk_in2(clk),
	   	.clk_in3(clk), 
/************ads interface************/
//////////////ads1
			.AD1_CS(),
			.AD1_SCLK(),
			.AD1_MISO(),
			.AD1_MOSI(),
//////////////ads2
			.AD2_CS(),
			.AD2_SCLK(),
			.AD2_MISO(),
			.AD2_MOSI(),
/**********microchip interface*********/
//////////K64 SPI
		   .k64_spi_cs(),
			.k64_spi_clk(),
			.k64_spi_din(),
			.k64_spi_dout(),
//////////K64 Flexbus
			.K64_AD(),
			.K64_ALE(),
			.K64_RW(),	
			.K64_CS0(),
			.K64_CLK(),
/************uart interface***********/		
			.uart_rx(),
			.uart_tx(),		
/************ddr3 interface***********/
			.mem_a(),    //memory.mem_a
			.mem_ba(),   //.mem_ba
			.mem_ck(),   //.mem_ck
			.mem_ck_n(), //.mem_ck_n
			.mem_cke(),           //.mem_cke
			.mem_cs_n(),          //.mem_cs_n
			.mem_dm(),   //.mem_dm
			.mem_ras_n(),         //.mem_ras_n
			.mem_cas_n(),         //.mem_cas_n
			.mem_we_n(),          //.mem_we_n
			.mem_reset_n(),       //.mem_reset_n
			.mem_dq(),   //.mem_dq
			.mem_dqs(),  //.mem_dqs
			.mem_dqs_n(),//.mem_dqs_n
			.mem_odt(),           //.mem_odt
			.oct_rzqin(),         //oct.rzqin
/************ds3231 interface***********/
			.ds3231_rstn(),
//			.ds3231_32khz,
			.ds3231_intn_sqw(),
			.ds3231_scl(),
			.ds3231_sda(),
/************max7410 clkin***********/
/////////////7K//////////////
			.A7K(),
/*****************test led***********/
//////////LED//////////		
			.LED_FPGA0(),
			.LED_FPGA1(),

			.key()
);
	
	initial begin
		// Initialize Inputs
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
     
always #10 clk=~clk;

	  
endmodule