`timescale 1ns / 1ns

module uart_top(//when neg_to_uart_valid valid,send data to to_uart_data bus 
					 //when neg_from_uart_ready valid,get data from from_uart_data bus
		 input reset,
		 input clk,
		 input uart_rx,
		 output uart_tx,
			 
		 input [7:0]ALARM_Overview_Tflag_ads1,
		 input [7:0]ALARM_Ch03_Tfag_ads1,
		 input [7:0]ALARM_Ch03_Aflag_ads1,
		 input [15:0]Ch0_Data_ads1,
		 input [15:0]Ch1_Data_ads1,
		 input [15:0]Ch2_Data_ads1,
		 input [15:0]Ch3_Data_ads1,
		 
		 input [7:0]ALARM_Overview_Tflag_ads2,
		 input [7:0]ALARM_Ch03_Tfag_ads2,
		 input [7:0]ALARM_Ch03_Aflag_ads2,
		 input [15:0]Ch0_Data_ads2,
		 input [15:0]Ch1_Data_ads2,
		 input [15:0]Ch2_Data_ads2,
		 input [15:0]Ch3_Data_ads2,
		 
		 input Ch0_Data_en_ads2,
		 input Ch1_Data_en_ads2,
		 input Ch2_Data_en_ads2,
		 input Ch3_Data_en_ads2,
		 
		 input [55:0]Ch0_Dataf_ads2,
		 input Ch0_Dataf_en_ads2,
		 
		 output wire[24:0]ddr_add,
		 output wire [7:0]ddr_op,
		 
		 output wire [7:0]time_message_cnt,
		 output wire [7:0]year,
		 output wire [7:0]month,
		 output wire [7:0]day,
		 output wire [7:0]hour,
		 output wire [7:0]minute,
		 output wire [7:0]second,
		 
		 output wire ds3231_write_start,
		 input 		 ds3231_write_over,
		 output wire [47:0]ds3231_write_dat,
		 output wire [07:0]control_infor,//from k64 control information
		 
		 input incident_inform,
		 input[7:0]incident_b0,
		 input[7:0]incident_b1,
		 input[7:0]incident_b2,
		 input[7:0]incident_b3);
					 
wire to_uart_ready;
wire to_uart_valid;
wire [7:0]to_uart_data;

wire from_uart_valid;
wire [7:0]from_uart_data;					 
					 
		  
reg[7:0]to_uart_cnt;
reg from_uart_ready = 0;

uart_115200 uart_115200 (
		.from_uart_ready(from_uart_ready), 
		.from_uart_data(from_uart_data),  
		.from_uart_error(), 
		.from_uart_valid(from_uart_valid), 
		.to_uart_data(to_uart_data),    
		.to_uart_error(),   
		.to_uart_valid(to_uart_valid),   
		.to_uart_ready(to_uart_ready),   
		.clk(clk),             
		.UART_RXD(uart_rx),       
		.UART_TXD(uart_tx),        
		.reset(reset)        
	);
	
/************************receive data model*********************/

wire pos_from_uart_ready,neg_from_uart_ready;
reg from_uart_ready_r0,from_uart_ready_r1,from_uart_ready_r2;
always@(posedge clk)
	begin
		from_uart_ready_r0<=from_uart_ready;
		from_uart_ready_r1<=from_uart_ready_r0;
		from_uart_ready_r2<=from_uart_ready_r1;
	end

assign pos_from_uart_ready=(~from_uart_ready_r2)&from_uart_ready_r1;
assign neg_from_uart_ready=from_uart_ready_r2&(~from_uart_ready_r1);   
always @(posedge clk)begin
	if(from_uart_valid)
		begin
			from_uart_ready = 1;
		end
	else
		begin
			from_uart_ready = 0;
		end	
end
/********************uart user control logic**********************/		
uart_control uart_control(
		  .clk(clk),
		  .rst(reset),
		 
		  .to_uart_ready(to_uart_ready),
		  .to_uart_valid(to_uart_valid),
		  .to_uart_data(to_uart_data),
		 
		  .from_uart_valid(from_uart_valid),
		  .from_uart_data(from_uart_data),
		  
		  .ALARM_Overview_Tflag_ads1(ALARM_Overview_Tflag_ads1),
		  .ALARM_Ch03_Tfag_ads1(ALARM_Ch03_Tfag_ads1),
	     .ALARM_Ch03_Aflag_ads1(ALARM_Ch03_Aflag_ads1),
	     .Ch0_Data_ads1(Ch0_Data_ads1),
	     .Ch1_Data_ads1(Ch1_Data_ads1),
	     .Ch2_Data_ads1(Ch2_Data_ads1),
	     .Ch3_Data_ads1(Ch3_Data_ads1),
		  .ALARM_Overview_Tflag_ads2(ALARM_Overview_Tflag_ads2),
		  .ALARM_Ch03_Tfag_ads2(ALARM_Ch03_Tfag_ads2),
	     .ALARM_Ch03_Aflag_ads2(ALARM_Ch03_Aflag_ads2),
	     .Ch0_Data_ads2(Ch0_Data_ads2),
	     .Ch1_Data_ads2(Ch1_Data_ads2),
	     .Ch2_Data_ads2(Ch2_Data_ads2),
	     .Ch3_Data_ads2(Ch3_Data_ads2),
		  
		  .Ch0_Dataf_ads2(Ch0_Dataf_ads2),
		  .Ch0_Dataf_en_ads2(Ch0_Dataf_en_ads2),
		  
		  .ddr_add(ddr_add),
		  .ddr_op(ddr_op),
		  
		  .time_message_cnt(time_message_cnt),
		  .year(year),
		  .month(month),
		  .day(day),
		  .hour(hour),
		  .minute(minute),
		  .second(second),
		  
		  .ds3231_write_start(ds3231_write_start),
		  .ds3231_write_over(ds3231_write_over),
		  .ds3231_write_dat(ds3231_write_dat),
		  .control_infor(control_infor),
		  
		  .Ch0_Data_en_ads2(Ch0_Data_en_ads2),
		  .Ch1_Data_en_ads2(Ch1_Data_en_ads2),
		  .Ch2_Data_en_ads2(Ch2_Data_en_ads2),
		  .Ch3_Data_en_ads2(Ch3_Data_en_ads2),
		 
		  .incident_inform(incident_inform),
		  .incident_b0(incident_b0),
		  .incident_b1(incident_b1),
		  .incident_b2(incident_b2),
		  .incident_b3(incident_b3));	 
		  				  

endmodule
