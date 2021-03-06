// Qsys_system_epcq_controller2_0_asmi2_inst_epcq_ctrl.v

// This file was auto-generated from altera_asmi_parallel2_hw.tcl.  If you edit it your changes
// will probably be lost.
// 
// Generated using ACDS version 17.0 595

`timescale 1 ps / 1 ps
module Qsys_system_epcq_controller2_0_asmi2_inst_epcq_ctrl #(
		parameter WR_ID_LIST      = "0 1 2",
		parameter RD_ID_LIST      = "0 1 2 3",
		parameter DEVICE_FAMILY   = "Cyclone V",
		parameter ADDR_WIDTH      = 23,
		parameter ASMI_ADDR_WIDTH = 32,
		parameter CHIP_SELS       = 1
	) (
		input  wire [5:0]  avl_csr_address,         //     avl_csr.address
		input  wire        avl_csr_read,            //            .read
		output wire [31:0] avl_csr_readdata,        //            .readdata
		input  wire        avl_csr_write,           //            .write
		input  wire [31:0] avl_csr_writedata,       //            .writedata
		output wire        avl_csr_waitrequest,     //            .waitrequest
		output wire        avl_csr_readdatavalid,   //            .readdatavalid
		input  wire [31:0] avl_mem_address,         //     avl_mem.address
		input  wire        avl_mem_read,            //            .read
		output wire [31:0] avl_mem_readdata,        //            .readdata
		input  wire        avl_mem_write,           //            .write
		input  wire [31:0] avl_mem_writedata,       //            .writedata
		input  wire [3:0]  avl_mem_byteenable,      //            .byteenable
		input  wire [6:0]  avl_mem_burstcount,      //            .burstcount
		output wire        avl_mem_waitrequest,     //            .waitrequest
		output wire        avl_mem_readdatavalid,   //            .readdatavalid
		input  wire        clk_clk,                 //         clk.clk
		input  wire        reset_reset,             //       reset.reset
		input  wire [3:0]  chip_select_chip_select  // chip_select.chip_select
	);

	wire         csr_controller_cmd_pck_valid;                       // csr_controller:cmd_valid -> multiplexer:sink1_valid
	wire  [31:0] csr_controller_cmd_pck_data;                        // csr_controller:cmd_data -> multiplexer:sink1_data
	wire         csr_controller_cmd_pck_ready;                       // multiplexer:sink1_ready -> csr_controller:cmd_ready
	wire   [1:0] csr_controller_cmd_pck_channel;                     // csr_controller:cmd_channel -> multiplexer:sink1_channel
	wire         csr_controller_cmd_pck_startofpacket;               // csr_controller:cmd_sop -> multiplexer:sink1_startofpacket
	wire         csr_controller_cmd_pck_endofpacket;                 // csr_controller:cmd_eop -> multiplexer:sink1_endofpacket
	wire         xip_controller_cmd_pck_valid;                       // xip_controller:cmd_valid -> multiplexer:sink0_valid
	wire  [31:0] xip_controller_cmd_pck_data;                        // xip_controller:cmd_data -> multiplexer:sink0_data
	wire         xip_controller_cmd_pck_ready;                       // multiplexer:sink0_ready -> xip_controller:cmd_ready
	wire   [1:0] xip_controller_cmd_pck_channel;                     // xip_controller:cmd_channel -> multiplexer:sink0_channel
	wire         xip_controller_cmd_pck_startofpacket;               // xip_controller:cmd_sop -> multiplexer:sink0_startofpacket
	wire         xip_controller_cmd_pck_endofpacket;                 // xip_controller:cmd_eop -> multiplexer:sink0_endofpacket
	wire         merlin_demultiplexer_0_src1_valid;                  // merlin_demultiplexer_0:src1_valid -> csr_controller:rsp_valid
	wire  [31:0] merlin_demultiplexer_0_src1_data;                   // merlin_demultiplexer_0:src1_data -> csr_controller:rsp_data
	wire         merlin_demultiplexer_0_src1_ready;                  // csr_controller:rsp_ready -> merlin_demultiplexer_0:src1_ready
	wire   [1:0] merlin_demultiplexer_0_src1_channel;                // merlin_demultiplexer_0:src1_channel -> csr_controller:rsp_channel
	wire         merlin_demultiplexer_0_src1_startofpacket;          // merlin_demultiplexer_0:src1_startofpacket -> csr_controller:rsp_sop
	wire         merlin_demultiplexer_0_src1_endofpacket;            // merlin_demultiplexer_0:src1_endofpacket -> csr_controller:rsp_eop
	wire         merlin_demultiplexer_0_src0_valid;                  // merlin_demultiplexer_0:src0_valid -> xip_controller:rsp_valid
	wire  [31:0] merlin_demultiplexer_0_src0_data;                   // merlin_demultiplexer_0:src0_data -> xip_controller:rsp_data
	wire         merlin_demultiplexer_0_src0_ready;                  // xip_controller:rsp_ready -> merlin_demultiplexer_0:src0_ready
	wire   [1:0] merlin_demultiplexer_0_src0_channel;                // merlin_demultiplexer_0:src0_channel -> xip_controller:rsp_channel
	wire         merlin_demultiplexer_0_src0_startofpacket;          // merlin_demultiplexer_0:src0_startofpacket -> xip_controller:rsp_sop
	wire         merlin_demultiplexer_0_src0_endofpacket;            // merlin_demultiplexer_0:src0_endofpacket -> xip_controller:rsp_eop
	wire  [31:0] csr_controller_addr_bytes_csr_addr_bytes_csr;       // csr_controller:addr_bytes_csr -> asmi2_cmd_generator_0:addr_bytes_csr
	wire  [31:0] xip_controller_addr_bytes_xip_addr_bytes_xip;       // xip_controller:addr_bytes_xip -> asmi2_cmd_generator_0:addr_bytes_xip
	wire         asmi2_cmd_generator_0_out_rsp_pck_valid;            // asmi2_cmd_generator_0:out_rsp_valid -> merlin_demultiplexer_0:sink_valid
	wire  [31:0] asmi2_cmd_generator_0_out_rsp_pck_data;             // asmi2_cmd_generator_0:out_rsp_data -> merlin_demultiplexer_0:sink_data
	wire         asmi2_cmd_generator_0_out_rsp_pck_ready;            // merlin_demultiplexer_0:sink_ready -> asmi2_cmd_generator_0:out_rsp_ready
	wire   [1:0] asmi2_cmd_generator_0_out_rsp_pck_channel;          // asmi2_cmd_generator_0:out_rsp_channel -> merlin_demultiplexer_0:sink_channel
	wire         asmi2_cmd_generator_0_out_rsp_pck_startofpacket;    // asmi2_cmd_generator_0:out_rsp_sop -> merlin_demultiplexer_0:sink_startofpacket
	wire         asmi2_cmd_generator_0_out_rsp_pck_endofpacket;      // asmi2_cmd_generator_0:out_rsp_eop -> merlin_demultiplexer_0:sink_endofpacket
	wire         asmi2_qspi_interface_0_out_rsp_pck_valid;           // asmi2_qspi_interface_0:out_rsp_valid -> asmi2_cmd_generator_0:in_rsp_valid
	wire   [7:0] asmi2_qspi_interface_0_out_rsp_pck_data;            // asmi2_qspi_interface_0:out_rsp_data -> asmi2_cmd_generator_0:in_rsp_data
	wire         asmi2_qspi_interface_0_out_rsp_pck_ready;           // asmi2_cmd_generator_0:in_rsp_ready -> asmi2_qspi_interface_0:out_rsp_ready
	wire   [4:0] asmi2_cmd_generator_0_dummy_cycles_dummy_cycles;    // asmi2_cmd_generator_0:dummy_cycles -> asmi2_qspi_interface_0:dummy_cycles
	wire   [3:0] asmi2_cmd_generator_0_chip_select_chip_select;      // asmi2_cmd_generator_0:chip_select -> asmi2_qspi_interface_0:chip_select
	wire         asmi2_cmd_generator_0_require_rdata_require_rdata;  // asmi2_cmd_generator_0:require_rdata -> asmi2_qspi_interface_0:require_rdata
	wire         csr_controller_qspi_interface_en_qspi_interface_en; // csr_controller:qspi_interface_en -> asmi2_qspi_interface_0:qspi_interface_en
	wire         asmi2_cmd_generator_0_out_cmd_pck_valid;            // asmi2_cmd_generator_0:out_cmd_valid -> asmi2_qspi_interface_0:in_cmd_valid
	wire   [7:0] asmi2_cmd_generator_0_out_cmd_pck_data;             // asmi2_cmd_generator_0:out_cmd_data -> asmi2_qspi_interface_0:in_cmd_data
	wire         asmi2_cmd_generator_0_out_cmd_pck_ready;            // asmi2_qspi_interface_0:in_cmd_ready -> asmi2_cmd_generator_0:out_cmd_ready
	wire   [1:0] asmi2_cmd_generator_0_out_cmd_pck_channel;          // asmi2_cmd_generator_0:out_cmd_channel -> asmi2_qspi_interface_0:in_cmd_channel
	wire         asmi2_cmd_generator_0_out_cmd_pck_startofpacket;    // asmi2_cmd_generator_0:out_cmd_sop -> asmi2_qspi_interface_0:in_cmd_sop
	wire         asmi2_cmd_generator_0_out_cmd_pck_endofpacket;      // asmi2_cmd_generator_0:out_cmd_eop -> asmi2_qspi_interface_0:in_cmd_eop
	wire         multiplexer_src_valid;                              // multiplexer:src_valid -> asmi2_cmd_generator_0:in_cmd_valid
	wire  [31:0] multiplexer_src_data;                               // multiplexer:src_data -> asmi2_cmd_generator_0:in_cmd_data
	wire         multiplexer_src_ready;                              // asmi2_cmd_generator_0:in_cmd_ready -> multiplexer:src_ready
	wire   [1:0] multiplexer_src_channel;                            // multiplexer:src_channel -> asmi2_cmd_generator_0:in_cmd_channel
	wire         multiplexer_src_startofpacket;                      // multiplexer:src_startofpacket -> asmi2_cmd_generator_0:in_cmd_sop
	wire         multiplexer_src_endofpacket;                        // multiplexer:src_endofpacket -> asmi2_cmd_generator_0:in_cmd_eop
	wire         rst_controller_reset_out_reset;                     // rst_controller:reset_out -> [asmi2_cmd_generator_0:reset, asmi2_qspi_interface_0:reset, csr_controller:reset, merlin_demultiplexer_0:reset, multiplexer:reset, xip_controller:reset]

	generate
		// If any of the display statements (or deliberately broken
		// instantiations) within this generate block triggers then this module
		// has been instantiated this module with a set of parameters different
		// from those it was generated for.  This will usually result in a
		// non-functioning system.
		if (WR_ID_LIST != "0 1 2")
		begin
			initial begin
				$display("Generated module instantiated with wrong parameters");
				$stop;
			end
			instantiated_with_wrong_parameters_error_see_comment_above
					wr_id_list_check ( .error(1'b1) );
		end
		if (RD_ID_LIST != "0 1 2 3")
		begin
			initial begin
				$display("Generated module instantiated with wrong parameters");
				$stop;
			end
			instantiated_with_wrong_parameters_error_see_comment_above
					rd_id_list_check ( .error(1'b1) );
		end
		if (DEVICE_FAMILY != "Cyclone V")
		begin
			initial begin
				$display("Generated module instantiated with wrong parameters");
				$stop;
			end
			instantiated_with_wrong_parameters_error_see_comment_above
					device_family_check ( .error(1'b1) );
		end
		if (ADDR_WIDTH != 23)
		begin
			initial begin
				$display("Generated module instantiated with wrong parameters");
				$stop;
			end
			instantiated_with_wrong_parameters_error_see_comment_above
					addr_width_check ( .error(1'b1) );
		end
		if (ASMI_ADDR_WIDTH != 32)
		begin
			initial begin
				$display("Generated module instantiated with wrong parameters");
				$stop;
			end
			instantiated_with_wrong_parameters_error_see_comment_above
					asmi_addr_width_check ( .error(1'b1) );
		end
		if (CHIP_SELS != 1)
		begin
			initial begin
				$display("Generated module instantiated with wrong parameters");
				$stop;
			end
			instantiated_with_wrong_parameters_error_see_comment_above
					chip_sels_check ( .error(1'b1) );
		end
	endgenerate

	Qsys_system_epcq_controller2_0_asmi2_inst_epcq_ctrl_csr_controller csr_controller (
		.csr_addr          (avl_csr_address),                                    //               csr.address
		.csr_rd            (avl_csr_read),                                       //                  .read
		.csr_rddata        (avl_csr_readdata),                                   //                  .readdata
		.csr_wr            (avl_csr_write),                                      //                  .write
		.csr_wrdata        (avl_csr_writedata),                                  //                  .writedata
		.csr_waitrequest   (avl_csr_waitrequest),                                //                  .waitrequest
		.csr_rddatavalid   (avl_csr_readdatavalid),                              //                  .readdatavalid
		.clk               (clk_clk),                                            //               clk.clk
		.reset             (rst_controller_reset_out_reset),                     //             reset.reset
		.cmd_channel       (csr_controller_cmd_pck_channel),                     //           cmd_pck.channel
		.cmd_eop           (csr_controller_cmd_pck_endofpacket),                 //                  .endofpacket
		.cmd_ready         (csr_controller_cmd_pck_ready),                       //                  .ready
		.cmd_sop           (csr_controller_cmd_pck_startofpacket),               //                  .startofpacket
		.cmd_data          (csr_controller_cmd_pck_data),                        //                  .data
		.cmd_valid         (csr_controller_cmd_pck_valid),                       //                  .valid
		.rsp_channel       (merlin_demultiplexer_0_src1_channel),                //           rsp_pck.channel
		.rsp_data          (merlin_demultiplexer_0_src1_data),                   //                  .data
		.rsp_eop           (merlin_demultiplexer_0_src1_endofpacket),            //                  .endofpacket
		.rsp_ready         (merlin_demultiplexer_0_src1_ready),                  //                  .ready
		.rsp_sop           (merlin_demultiplexer_0_src1_startofpacket),          //                  .startofpacket
		.rsp_valid         (merlin_demultiplexer_0_src1_valid),                  //                  .valid
		.addr_bytes_csr    (csr_controller_addr_bytes_csr_addr_bytes_csr),       //    addr_bytes_csr.addr_bytes_csr
		.qspi_interface_en (csr_controller_qspi_interface_en_qspi_interface_en)  // qspi_interface_en.qspi_interface_en
	);

	altera_asmi2_xip_controller #(
		.ADDR_WIDTH (32)
	) xip_controller (
		.clk             (clk_clk),                                      //            clk.clk
		.reset           (rst_controller_reset_out_reset),               //          reset.reset
		.mem_addr        (avl_mem_address),                              //            mem.address
		.mem_rd          (avl_mem_read),                                 //               .read
		.mem_rddata      (avl_mem_readdata),                             //               .readdata
		.mem_wr          (avl_mem_write),                                //               .write
		.mem_wrdata      (avl_mem_writedata),                            //               .writedata
		.mem_byteenable  (avl_mem_byteenable),                           //               .byteenable
		.mem_burstcount  (avl_mem_burstcount),                           //               .burstcount
		.mem_waitrequest (avl_mem_waitrequest),                          //               .waitrequest
		.mem_rddatavalid (avl_mem_readdatavalid),                        //               .readdatavalid
		.addr_bytes_xip  (xip_controller_addr_bytes_xip_addr_bytes_xip), // addr_bytes_xip.addr_bytes_xip
		.cmd_channel     (xip_controller_cmd_pck_channel),               //        cmd_pck.channel
		.cmd_eop         (xip_controller_cmd_pck_endofpacket),           //               .endofpacket
		.cmd_ready       (xip_controller_cmd_pck_ready),                 //               .ready
		.cmd_sop         (xip_controller_cmd_pck_startofpacket),         //               .startofpacket
		.cmd_data        (xip_controller_cmd_pck_data),                  //               .data
		.cmd_valid       (xip_controller_cmd_pck_valid),                 //               .valid
		.rsp_channel     (merlin_demultiplexer_0_src0_channel),          //        rsp_pck.channel
		.rsp_data        (merlin_demultiplexer_0_src0_data),             //               .data
		.rsp_eop         (merlin_demultiplexer_0_src0_endofpacket),      //               .endofpacket
		.rsp_ready       (merlin_demultiplexer_0_src0_ready),            //               .ready
		.rsp_sop         (merlin_demultiplexer_0_src0_startofpacket),    //               .startofpacket
		.rsp_valid       (merlin_demultiplexer_0_src0_valid),            //               .valid
		.chip_select     (chip_select_chip_select)                       //    chip_select.chip_select
	);

	Qsys_system_epcq_controller2_0_asmi2_inst_epcq_ctrl_merlin_demultiplexer_0 merlin_demultiplexer_0 (
		.clk                (clk_clk),                                         //       clk.clk
		.reset              (rst_controller_reset_out_reset),                  // clk_reset.reset
		.sink_ready         (asmi2_cmd_generator_0_out_rsp_pck_ready),         //      sink.ready
		.sink_channel       (asmi2_cmd_generator_0_out_rsp_pck_channel),       //          .channel
		.sink_data          (asmi2_cmd_generator_0_out_rsp_pck_data),          //          .data
		.sink_startofpacket (asmi2_cmd_generator_0_out_rsp_pck_startofpacket), //          .startofpacket
		.sink_endofpacket   (asmi2_cmd_generator_0_out_rsp_pck_endofpacket),   //          .endofpacket
		.sink_valid         (asmi2_cmd_generator_0_out_rsp_pck_valid),         //          .valid
		.src0_ready         (merlin_demultiplexer_0_src0_ready),               //      src0.ready
		.src0_valid         (merlin_demultiplexer_0_src0_valid),               //          .valid
		.src0_data          (merlin_demultiplexer_0_src0_data),                //          .data
		.src0_channel       (merlin_demultiplexer_0_src0_channel),             //          .channel
		.src0_startofpacket (merlin_demultiplexer_0_src0_startofpacket),       //          .startofpacket
		.src0_endofpacket   (merlin_demultiplexer_0_src0_endofpacket),         //          .endofpacket
		.src1_ready         (merlin_demultiplexer_0_src1_ready),               //      src1.ready
		.src1_valid         (merlin_demultiplexer_0_src1_valid),               //          .valid
		.src1_data          (merlin_demultiplexer_0_src1_data),                //          .data
		.src1_channel       (merlin_demultiplexer_0_src1_channel),             //          .channel
		.src1_startofpacket (merlin_demultiplexer_0_src1_startofpacket),       //          .startofpacket
		.src1_endofpacket   (merlin_demultiplexer_0_src1_endofpacket)          //          .endofpacket
	);

	Qsys_system_epcq_controller2_0_asmi2_inst_epcq_ctrl_multiplexer multiplexer (
		.clk                 (clk_clk),                              //       clk.clk
		.reset               (rst_controller_reset_out_reset),       // clk_reset.reset
		.src_ready           (multiplexer_src_ready),                //       src.ready
		.src_valid           (multiplexer_src_valid),                //          .valid
		.src_data            (multiplexer_src_data),                 //          .data
		.src_channel         (multiplexer_src_channel),              //          .channel
		.src_startofpacket   (multiplexer_src_startofpacket),        //          .startofpacket
		.src_endofpacket     (multiplexer_src_endofpacket),          //          .endofpacket
		.sink0_ready         (xip_controller_cmd_pck_ready),         //     sink0.ready
		.sink0_valid         (xip_controller_cmd_pck_valid),         //          .valid
		.sink0_channel       (xip_controller_cmd_pck_channel),       //          .channel
		.sink0_data          (xip_controller_cmd_pck_data),          //          .data
		.sink0_startofpacket (xip_controller_cmd_pck_startofpacket), //          .startofpacket
		.sink0_endofpacket   (xip_controller_cmd_pck_endofpacket),   //          .endofpacket
		.sink1_ready         (csr_controller_cmd_pck_ready),         //     sink1.ready
		.sink1_valid         (csr_controller_cmd_pck_valid),         //          .valid
		.sink1_channel       (csr_controller_cmd_pck_channel),       //          .channel
		.sink1_data          (csr_controller_cmd_pck_data),          //          .data
		.sink1_startofpacket (csr_controller_cmd_pck_startofpacket), //          .startofpacket
		.sink1_endofpacket   (csr_controller_cmd_pck_endofpacket)    //          .endofpacket
	);

	altera_asmi2_cmd_generator asmi2_cmd_generator_0 (
		.clk             (clk_clk),                                           //            clk.clk
		.reset           (rst_controller_reset_out_reset),                    //          reset.reset
		.in_cmd_channel  (multiplexer_src_channel),                           //     in_cmd_pck.channel
		.in_cmd_eop      (multiplexer_src_endofpacket),                       //               .endofpacket
		.in_cmd_ready    (multiplexer_src_ready),                             //               .ready
		.in_cmd_sop      (multiplexer_src_startofpacket),                     //               .startofpacket
		.in_cmd_data     (multiplexer_src_data),                              //               .data
		.in_cmd_valid    (multiplexer_src_valid),                             //               .valid
		.out_cmd_channel (asmi2_cmd_generator_0_out_cmd_pck_channel),         //    out_cmd_pck.channel
		.out_cmd_eop     (asmi2_cmd_generator_0_out_cmd_pck_endofpacket),     //               .endofpacket
		.out_cmd_ready   (asmi2_cmd_generator_0_out_cmd_pck_ready),           //               .ready
		.out_cmd_sop     (asmi2_cmd_generator_0_out_cmd_pck_startofpacket),   //               .startofpacket
		.out_cmd_data    (asmi2_cmd_generator_0_out_cmd_pck_data),            //               .data
		.out_cmd_valid   (asmi2_cmd_generator_0_out_cmd_pck_valid),           //               .valid
		.in_rsp_data     (asmi2_qspi_interface_0_out_rsp_pck_data),           //     in_rsp_pck.data
		.in_rsp_ready    (asmi2_qspi_interface_0_out_rsp_pck_ready),          //               .ready
		.in_rsp_valid    (asmi2_qspi_interface_0_out_rsp_pck_valid),          //               .valid
		.out_rsp_channel (asmi2_cmd_generator_0_out_rsp_pck_channel),         //    out_rsp_pck.channel
		.out_rsp_data    (asmi2_cmd_generator_0_out_rsp_pck_data),            //               .data
		.out_rsp_eop     (asmi2_cmd_generator_0_out_rsp_pck_endofpacket),     //               .endofpacket
		.out_rsp_ready   (asmi2_cmd_generator_0_out_rsp_pck_ready),           //               .ready
		.out_rsp_sop     (asmi2_cmd_generator_0_out_rsp_pck_startofpacket),   //               .startofpacket
		.out_rsp_valid   (asmi2_cmd_generator_0_out_rsp_pck_valid),           //               .valid
		.addr_bytes_csr  (csr_controller_addr_bytes_csr_addr_bytes_csr),      // addr_bytes_csr.addr_bytes_csr
		.addr_bytes_xip  (xip_controller_addr_bytes_xip_addr_bytes_xip),      // addr_bytes_xip.addr_bytes_xip
		.dummy_cycles    (asmi2_cmd_generator_0_dummy_cycles_dummy_cycles),   //   dummy_cycles.dummy_cycles
		.chip_select     (asmi2_cmd_generator_0_chip_select_chip_select),     //    chip_select.chip_select
		.require_rdata   (asmi2_cmd_generator_0_require_rdata_require_rdata)  //  require_rdata.require_rdata
	);

	altera_asmi2_qspi_interface #(
		.DEV_FAMILY       ("Cyclone V"),
		.NCS_LENGTH       (1),
		.DATA_LENGTH      (4),
		.MODE_LENGTH      (1),
		.ENABLE_SIM_MODEL ("false")
	) asmi2_qspi_interface_0 (
		.clk               (clk_clk),                                            //               clk.clk
		.reset             (rst_controller_reset_out_reset),                     //             reset.reset
		.in_cmd_channel    (asmi2_cmd_generator_0_out_cmd_pck_channel),          //        in_cmd_pck.channel
		.in_cmd_eop        (asmi2_cmd_generator_0_out_cmd_pck_endofpacket),      //                  .endofpacket
		.in_cmd_ready      (asmi2_cmd_generator_0_out_cmd_pck_ready),            //                  .ready
		.in_cmd_sop        (asmi2_cmd_generator_0_out_cmd_pck_startofpacket),    //                  .startofpacket
		.in_cmd_data       (asmi2_cmd_generator_0_out_cmd_pck_data),             //                  .data
		.in_cmd_valid      (asmi2_cmd_generator_0_out_cmd_pck_valid),            //                  .valid
		.out_rsp_data      (asmi2_qspi_interface_0_out_rsp_pck_data),            //       out_rsp_pck.data
		.out_rsp_valid     (asmi2_qspi_interface_0_out_rsp_pck_valid),           //                  .valid
		.out_rsp_ready     (asmi2_qspi_interface_0_out_rsp_pck_ready),           //                  .ready
		.dummy_cycles      (asmi2_cmd_generator_0_dummy_cycles_dummy_cycles),    //      dummy_cycles.dummy_cycles
		.chip_select       (asmi2_cmd_generator_0_chip_select_chip_select),      //       chip_select.chip_select
		.qspi_interface_en (csr_controller_qspi_interface_en_qspi_interface_en), // qspi_interface_en.qspi_interface_en
		.require_rdata     (asmi2_cmd_generator_0_require_rdata_require_rdata)   //     require_rdata.require_rdata
	);

	altera_reset_controller #(
		.NUM_RESET_INPUTS          (1),
		.OUTPUT_RESET_SYNC_EDGES   ("deassert"),
		.SYNC_DEPTH                (2),
		.RESET_REQUEST_PRESENT     (0),
		.RESET_REQ_WAIT_TIME       (1),
		.MIN_RST_ASSERTION_TIME    (3),
		.RESET_REQ_EARLY_DSRT_TIME (1),
		.USE_RESET_REQUEST_IN0     (0),
		.USE_RESET_REQUEST_IN1     (0),
		.USE_RESET_REQUEST_IN2     (0),
		.USE_RESET_REQUEST_IN3     (0),
		.USE_RESET_REQUEST_IN4     (0),
		.USE_RESET_REQUEST_IN5     (0),
		.USE_RESET_REQUEST_IN6     (0),
		.USE_RESET_REQUEST_IN7     (0),
		.USE_RESET_REQUEST_IN8     (0),
		.USE_RESET_REQUEST_IN9     (0),
		.USE_RESET_REQUEST_IN10    (0),
		.USE_RESET_REQUEST_IN11    (0),
		.USE_RESET_REQUEST_IN12    (0),
		.USE_RESET_REQUEST_IN13    (0),
		.USE_RESET_REQUEST_IN14    (0),
		.USE_RESET_REQUEST_IN15    (0),
		.ADAPT_RESET_REQUEST       (0)
	) rst_controller (
		.reset_in0      (reset_reset),                    // reset_in0.reset
		.clk            (clk_clk),                        //       clk.clk
		.reset_out      (rst_controller_reset_out_reset), // reset_out.reset
		.reset_req      (),                               // (terminated)
		.reset_req_in0  (1'b0),                           // (terminated)
		.reset_in1      (1'b0),                           // (terminated)
		.reset_req_in1  (1'b0),                           // (terminated)
		.reset_in2      (1'b0),                           // (terminated)
		.reset_req_in2  (1'b0),                           // (terminated)
		.reset_in3      (1'b0),                           // (terminated)
		.reset_req_in3  (1'b0),                           // (terminated)
		.reset_in4      (1'b0),                           // (terminated)
		.reset_req_in4  (1'b0),                           // (terminated)
		.reset_in5      (1'b0),                           // (terminated)
		.reset_req_in5  (1'b0),                           // (terminated)
		.reset_in6      (1'b0),                           // (terminated)
		.reset_req_in6  (1'b0),                           // (terminated)
		.reset_in7      (1'b0),                           // (terminated)
		.reset_req_in7  (1'b0),                           // (terminated)
		.reset_in8      (1'b0),                           // (terminated)
		.reset_req_in8  (1'b0),                           // (terminated)
		.reset_in9      (1'b0),                           // (terminated)
		.reset_req_in9  (1'b0),                           // (terminated)
		.reset_in10     (1'b0),                           // (terminated)
		.reset_req_in10 (1'b0),                           // (terminated)
		.reset_in11     (1'b0),                           // (terminated)
		.reset_req_in11 (1'b0),                           // (terminated)
		.reset_in12     (1'b0),                           // (terminated)
		.reset_req_in12 (1'b0),                           // (terminated)
		.reset_in13     (1'b0),                           // (terminated)
		.reset_req_in13 (1'b0),                           // (terminated)
		.reset_in14     (1'b0),                           // (terminated)
		.reset_req_in14 (1'b0),                           // (terminated)
		.reset_in15     (1'b0),                           // (terminated)
		.reset_req_in15 (1'b0)                            // (terminated)
	);

endmodule
