
`timescale 1 ns / 1 ps
module mt41j128m16_control(		
		input ppl_clk,
		input rst,
		
		output wire [13:0] 	mem_a,            //memory.mem_a
		output wire [2:0]  	mem_ba,           //.mem_ba
		output wire [0:0]		mem_ck,           //.mem_ck
		output wire [0:0]		mem_ck_n,         //.mem_ck_n
		output wire mem_cke,                   //.mem_cke
		output wire mem_cs_n,                  //.mem_cs_n
		output wire [1:0]  	mem_dm,           //.mem_dm
		output wire mem_ras_n,                 //.mem_ras_n
		output wire mem_cas_n,                 //.mem_cas_n
		output wire mem_we_n,                  //.mem_we_n
		output wire mem_reset_n,               //.mem_reset_n
		inout  wire [15:0] 	mem_dq,           //.mem_dq
		inout  wire [1:0]  	mem_dqs,          //.mem_dqs
		inout  wire [1:0]  	mem_dqs_n,        //.mem_dqs_n
		output wire mem_odt,                   //.mem_odt
		input  wire oct_rzqin,                 //oct.rzqin
		output wire local_init_done,
		
		input [7:0]ds_MsecondsL,		
		input [7:0]ds_MsecondsH,
		input [7:0]ds_Seconds,
		input [7:0]ds_Minutes,
		input [7:0]ds_Hour,
		input [7:0]ds_Date,
		input [7:0]ds_Month,
		input [7:0]ds_Year,
		
		input [15:0]Ch0_Dataf_ads1,
		input [15:0]Ch1_Dataf_ads1,
		input [15:0]Ch0_Dataf_ads2,
		input [15:0]Ch1_Dataf_ads2,
		 
		input Ch1_Dataf_en_ads2,
		input Ch0_Dataf_en_ads2,
		input Ch1_Dataf_en_ads1,
		input Ch0_Dataf_en_ads1,
		
		//data to flexbus		
		output wire afi_clk,
		input ddrL_RdStar,
		input ddrH_RdStar,
		output wire [63:00]ddr_dat_timing,
		output wire ddr_timing_en,
		output wire [63:00]ddr_dat,
		output wire ddr_dat_en,
		output wire ddrL_read_switch,
      output wire ddrH_read_switch,
		
//		output wire[7:0]ddr_MsecondsL,		
//		output wire[7:0]ddr_MsecondsH,
//		output wire[7:0]ddr_Seconds,
//		output wire[7:0]ddr_Minutes,
//		output wire[7:0]ddr_Hour,
//		output wire[7:0]ddr_Date,
//		output wire[7:0]ddr_Month,
//		output wire[7:0]ddr_Year,
//		
//		output wire[7:0]ddr_pkg_mun_Dataf,
//		output wire[15:0]ddr_Ch0_Dataf_ads1,
//		output wire[15:0]ddr_Ch1_Dataf_ads1,
//		output wire[15:0]ddr_Ch0_Dataf_ads2,
//		output wire[15:0]ddr_Ch1_Dataf_ads2,
		
		input incident_inform,
		input[7:0]incident_b0,
		input[7:0]incident_b1,
		input[7:0]incident_b2,
		input[7:0]incident_b3,
		
		input[24:0]ddr_add,
		input[7:0] ddr_op,
		input[63:0]ads_dat,
		input[3:0]ads_dat_en);

//wire 			afi_clk; 
wire        avl_ready;                 //avl.waitrequest_n
wire        avl_burstbegin;            //.beginbursttransfer
wire [24:0] avl_addr;                  //.address
wire        avl_rdata_valid;           //.readdatavalid
wire [63:0] avl_rdata;                 //.readdata
wire [63:0] avl_wdata;                 //.writedata
wire [7:0]  avl_be;                    //.byteenable
wire        avl_read_req;              //.read
wire        avl_write_req;             //.write
wire [3:0]  avl_size;                  //.burstcount
		
mt41j128m16_0002 mt41j128m16_inst (
	.pll_ref_clk               (ppl_clk),               	  //pll_ref_clk.clk
	.global_reset_n            (~rst),            		  	  //global_reset.reset_n
	.soft_reset_n              (~rst),              	  	  //soft_reset.reset_n
	.afi_clk                   (afi_clk),                   //afi_clk.clk
	.afi_half_clk              (),              				  //afi_half_clk.clk
	.afi_reset_n               (),               			  //afi_reset.reset_n
	.afi_reset_export_n        (),        						  //afi_reset_export.reset_n
	.mem_a                     (mem_a),                     //memory.mem_a
	.mem_ba                    (mem_ba),                    //.mem_ba
	.mem_ck                    (mem_ck),                    //.mem_ck
	.mem_ck_n                  (mem_ck_n),                  //.mem_ck_n
	.mem_cke                   (mem_cke),                   //.mem_cke
	.mem_cs_n                  (mem_cs_n),                  //.mem_cs_n
	.mem_dm                    (mem_dm),                    //.mem_dm
	.mem_ras_n                 (mem_ras_n),                 //.mem_ras_n
	.mem_cas_n                 (mem_cas_n),                 //.mem_cas_n
	.mem_we_n                  (mem_we_n),                  //.mem_we_n
	.mem_reset_n               (mem_reset_n),               //.mem_reset_n
	.mem_dq                    (mem_dq),                    //.mem_dq
	.mem_dqs                   (mem_dqs),                   //.mem_dqs
	.mem_dqs_n                 (mem_dqs_n),                 //.mem_dqs_n
	.mem_odt                   (mem_odt),                   //.mem_odt
	.avl_ready                 (avl_ready),                 //avl.waitrequest_n
	.avl_burstbegin            (avl_burstbegin),            //.beginbursttransfer
	.avl_addr                  (avl_addr),                  //.address
	.avl_rdata_valid           (avl_rdata_valid),           //.readdatavalid
	.avl_rdata                 (avl_rdata),                 //.readdata
	.avl_wdata                 (avl_wdata),                 //.writedata
	.avl_be                    (avl_be),                    //.byteenable
	.avl_read_req              (avl_read_req),              //.read
	.avl_write_req             (avl_write_req),             //.write
	.avl_size                  (avl_size),                  //.burstcount	
	.local_init_done           (local_init_done),           //status.local_init_done
	.local_cal_success         (),         					  //.local_cal_success
	.local_cal_fail            (),            				  //.local_cal_fail
	.oct_rzqin                 (oct_rzqin),                 //oct.rzqin
	.pll_mem_clk               (),               			  //pll_sharing.pll_mem_clk
	.pll_write_clk             (),             				  //.pll_write_clk
	.pll_locked                (),                			  //.pll_locked
	.pll_write_clk_pre_phy_clk (), 								  //.pll_write_clk_pre_phy_clk
	.pll_addr_cmd_clk          (),          					  //.pll_addr_cmd_clk
	.pll_avl_clk               (),               			  //.pll_avl_clk
	.pll_config_clk            (),            				  //.pll_config_clk
	.pll_mem_phy_clk           (),           					  //.pll_mem_phy_clk
	.afi_phy_clk               (),               			  //.afi_phy_clk
	.pll_avl_phy_clk           ()            					  //.pll_avl_phy_clk
	);
	
mt41j128m16_user_control mt41j128m16_user_control(
	.clk(afi_clk),
	.clk_50m(ppl_clk),
	.test_complete(local_init_done),
	
	.user0_avl_address(avl_addr),                        
	.user0_avl_write(avl_write_req),                          
	.user0_avl_read(avl_read_req),                           
	.user0_avl_readdata(avl_rdata),                       
	.user0_avl_writedata(avl_wdata),                      
	.user0_avl_beginbursttransfer(avl_burstbegin),          
	.user0_avl_burstcount(avl_size),                     
	.user0_avl_byteenable(avl_be),                     
	.user0_avl_readdatavalid(avl_rdata_valid),                  
	.user0_avl_waitrequest(avl_ready),
	
	.ds_MsecondsL(ds_MsecondsL),		
	.ds_MsecondsH(ds_MsecondsH),
	.ds_Seconds(ds_Seconds),
	.ds_Minutes(ds_Minutes),
	.ds_Hour(ds_Hour),
	.ds_Date(ds_Date),
	.ds_Month(ds_Month),
	.ds_Year(ds_Year),
	
	.Ch0_Dataf_ads1(Ch0_Dataf_ads1),
	.Ch1_Dataf_ads1(Ch1_Dataf_ads1),
	.Ch0_Dataf_ads2(Ch0_Dataf_ads2),
	.Ch1_Dataf_ads2(Ch1_Dataf_ads2),
	 
	.Ch1_Dataf_en_ads2(Ch1_Dataf_en_ads2),
	.Ch0_Dataf_en_ads2(Ch0_Dataf_en_ads2),
	.Ch1_Dataf_en_ads1(Ch1_Dataf_en_ads1),
	.Ch0_Dataf_en_ads1(Ch0_Dataf_en_ads1),
//data to flexbus	
	.ddrL_RdStar(ddrL_RdStar),
	.ddrH_RdStar(ddrH_RdStar),
	.ddr_dat_timing(ddr_dat_timing),
	.ddr_timing_en(ddr_timing_en),
	.ddr_dat(ddr_dat),
	.ddr_dat_en(ddr_dat_en),
	.ddrL_read_switch(ddrL_read_switch),
	.ddrH_read_switch(ddrH_read_switch),
	
//	.ddr_MsecondsL(ddr_MsecondsL),		
//	.ddr_MsecondsH(ddr_MsecondsH),
//	.ddr_Seconds(ddr_Seconds),
//	.ddr_Minutes(ddr_Minutes),
//	.ddr_Hour(ddr_Hour),
//	.ddr_Date(ddr_Date),
//	.ddr_Month(ddr_Month),
//	.ddr_Year(ddr_Year),
//	
//	.ddr_pkg_mun_Dataf(ddr_pkg_mun_Dataf),
//	.ddr_Ch0_Dataf_ads1(ddr_Ch0_Dataf_ads1),
//	.ddr_Ch1_Dataf_ads1(ddr_Ch1_Dataf_ads1),
//	.ddr_Ch0_Dataf_ads2(ddr_Ch0_Dataf_ads2),
//	.ddr_Ch1_Dataf_ads2(ddr_Ch1_Dataf_ads2),
	
	.incident_inform(),
	.incident_b0(),
	.incident_b1(),
	.incident_b2(),
	.incident_b3(incident_b3),
	
	.user0_ddr_add(ddr_add),
	.user0_ddr_op(ddr_op),
	
	.user0_ads_dat(ads_dat),
	.user0_ads_dat_en(ads_dat_en)
	);
		
endmodule