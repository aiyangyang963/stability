// uart_115200.v

// Generated using ACDS version 16.1 203

`timescale 1 ps / 1 ps
module uart_115200 (
		input  wire       from_uart_ready, // avalon_data_receive_source.ready
		output wire [7:0] from_uart_data,  //                           .data
		output wire       from_uart_error, //                           .error
		output wire       from_uart_valid, //                           .valid
		input  wire [7:0] to_uart_data,    //  avalon_data_transmit_sink.data
		input  wire       to_uart_error,   //                           .error
		input  wire       to_uart_valid,   //                           .valid
		output wire       to_uart_ready,   //                           .ready
		input  wire       clk,             //                        clk.clk
		input  wire       UART_RXD,        //         external_interface.RXD
		output wire       UART_TXD,        //                           .TXD
		input  wire       reset            //                      reset.reset
	);

	uart_115200_rs232_0 rs232_0 (
		.clk             (clk),             //                        clk.clk
		.reset           (reset),           //                      reset.reset
		.from_uart_ready (from_uart_ready), // avalon_data_receive_source.ready
		.from_uart_data  (from_uart_data),  //                           .data
		.from_uart_error (from_uart_error), //                           .error
		.from_uart_valid (from_uart_valid), //                           .valid
		.to_uart_data    (to_uart_data),    //  avalon_data_transmit_sink.data
		.to_uart_error   (to_uart_error),   //                           .error
		.to_uart_valid   (to_uart_valid),   //                           .valid
		.to_uart_ready   (to_uart_ready),   //                           .ready
		.UART_RXD        (UART_RXD),        //         external_interface.export
		.UART_TXD        (UART_TXD)         //                           .export
	);

endmodule
