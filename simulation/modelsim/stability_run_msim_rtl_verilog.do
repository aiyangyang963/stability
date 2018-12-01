transcript on
if ![file isdirectory stability_iputf_libs] {
	file mkdir stability_iputf_libs
}

if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

###### Libraries for IPUTF cores 
###### End libraries for IPUTF cores 
###### MIF file copy and HDL compilation commands for IPUTF cores 

file copy -force C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco_sim/fir_2_10hz_nco_rtl_core_u0_m0_wo0_cm0_lutmem.hex ./
file copy -force C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco_sim/fir_2_10hz_nco_rtl_core_u0_m0_wo0_wi0_r0_ra0_count1_lut_lutmem.hex ./

vcom "C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco_sim/dspba_library_package.vhd"                      
vcom "C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco_sim/dspba_library.vhd"                              
vcom "C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco_sim/auk_dspip_math_pkg_hpfir.vhd"                   
vcom "C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco_sim/auk_dspip_lib_pkg_hpfir.vhd"                    
vcom "C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco_sim/auk_dspip_avalon_streaming_controller_hpfir.vhd"
vcom "C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco_sim/auk_dspip_avalon_streaming_sink_hpfir.vhd"      
vcom "C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco_sim/auk_dspip_avalon_streaming_source_hpfir.vhd"    
vcom "C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco_sim/auk_dspip_roundsat_hpfir.vhd"                   
vlog "C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco_sim/altera_avalon_sc_fifo.v"                        
vcom "C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco_sim/fir_2_10hz_nco_rtl_core.vhd"                    
vcom "C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco_sim/fir_2_10hz_nco_ast.vhd"                         
vcom "C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco_sim/fir_2_10hz_nco.vhd"                             
vcom "C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco_sim/fir_2_10hz_nco_tb.vhd"                          
vlog "C:/Users/Magic_Boy/Desktop/stability/other/pll/pll_L_sim/pll_L.vo"                                                          
vlog "C:/Users/Magic_Boy/Desktop/stability/other/pll/pll_H_sim/pll_H.vo"                                                          

vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii {C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz.vo}
vlib fir_2_10hz
vmap fir_2_10hz fir_2_10hz
vlog -vlog01compat -work fir_2_10hz +incdir+C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii {C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii {C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco.vo}
vlib fir_2_10hz_nco
vmap fir_2_10hz_nco fir_2_10hz_nco
vlog -vlog01compat -work fir_2_10hz_nco +incdir+C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii {C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/pll {C:/Users/Magic_Boy/Desktop/stability/other/pll/pll_L.vo}
vlib pll_L
vmap pll_L pll_L
vlog -vlog01compat -work pll_L +incdir+C:/Users/Magic_Boy/Desktop/stability/other/pll {C:/Users/Magic_Boy/Desktop/stability/other/pll/pll_L.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/pll {C:/Users/Magic_Boy/Desktop/stability/other/pll/pll_H.vo}
vlib pll_H
vmap pll_H pll_H
vlog -vlog01compat -work pll_H +incdir+C:/Users/Magic_Boy/Desktop/stability/other/pll {C:/Users/Magic_Boy/Desktop/stability/other/pll/pll_H.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/sys {C:/Users/Magic_Boy/Desktop/stability/other/sys/top.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/sys {C:/Users/Magic_Boy/Desktop/stability/other/sys/sys_rst.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/sys {C:/Users/Magic_Boy/Desktop/stability/other/sys/LED.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/microchip {C:/Users/Magic_Boy/Desktop/stability/other/microchip/K64_SPI_SLAVE.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/microchip {C:/Users/Magic_Boy/Desktop/stability/other/microchip/flexbus.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/mt41j128m16_user_control.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/ddr_control_test_brust8.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/ddr_control_read_allmem.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/ddr_control_ads_minute5.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/sequencer_scc_reg_file.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/sequencer_scc_acv_phase_decode.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/rw_manager_write_decoder.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/rw_manager_read_datapath.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/rw_manager_pattern_fifo.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/rw_manager_lfsr36.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/rw_manager_lfsr12.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/rw_manager_jumplogic.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/rw_manager_inst_ROM_no_ifdef_params.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/rw_manager_dm_decoder.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/rw_manager_di_buffer_wrap.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/rw_manager_di_buffer.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/rw_manager_ddr3.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/rw_manager_datamux.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/rw_manager_data_decoder.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/rw_manager_data_broadcast.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/rw_manager_bitcheck.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/rw_manager_ac_ROM_no_ifdef_params.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/mt41j128m16_s0_mm_interconnect_0_avalon_st_adapter.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/mt41j128m16_s0_mm_interconnect_0.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/mt41j128m16_s0.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/mt41j128m16_p0_write_datapath.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/mt41j128m16_p0_reset_sync.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/mt41j128m16_p0_reset.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/mt41j128m16_p0_read_valid_selector.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/mt41j128m16_p0_new_io_pads.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/mt41j128m16_p0_fr_cycle_shifter.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/mt41j128m16_p0_fr_cycle_extender.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/mt41j128m16_p0_clock_pair_generator.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/mt41j128m16_p0_altdqdqs.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/mt41j128m16_p0_addr_cmd_pads.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/mt41j128m16_p0_addr_cmd_datapath.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/mt41j128m16_p0_acv_ldc.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/mt41j128m16_mm_interconnect_0.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/mt41j128m16_dmaster.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/mt41j128m16_c0.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/mt41j128m16_0002.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/altera_std_synchronizer_nocut.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/altera_reset_synchronizer.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/altera_reset_controller.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/altera_mem_if_sequencer_cpu_cv_synth_cpu_inst_test_bench.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/altera_mem_if_sequencer_cpu_cv_synth_cpu_inst.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/altera_jtag_streaming.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/altera_jtag_sld_node.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/altera_jtag_dc_streaming.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/altera_avalon_st_pipeline_base.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/altera_avalon_st_packets_to_bytes.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/altera_avalon_st_jtag_interface.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/altera_avalon_st_idle_remover.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/altera_avalon_st_idle_inserter.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/altera_avalon_st_clock_crosser.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/altera_avalon_st_bytes_to_packets.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/altera_avalon_sc_fifo.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/altera_avalon_packets_to_master.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/altera_avalon_mm_bridge.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/alt_mem_ddrx_wdata_path.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/alt_mem_ddrx_rdwr_data_tmg.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/alt_mem_ddrx_rank_timer.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/alt_mem_ddrx_mm_st_converter.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/alt_mem_ddrx_list.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/alt_mem_ddrx_input_if.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/alt_mem_ddrx_fifo.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/alt_mem_ddrx_ecc_encoder_decoder_wrapper.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/alt_mem_ddrx_ecc_encoder_32_syn.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/alt_mem_ddrx_ecc_encoder.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/alt_mem_ddrx_ecc_decoder_32_syn.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/alt_mem_ddrx_ecc_decoder.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/alt_mem_ddrx_ddr3_odt_gen.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/alt_mem_ddrx_ddr2_odt_gen.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/alt_mem_ddrx_dataid_manager.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/alt_mem_ddrx_controller.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/alt_mem_ddrx_burst_tracking.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/alt_mem_ddrx_buffer.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/alt_mem_ddrx_arbiter.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/afi_mux_ddr3_ddrx.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/uart {C:/Users/Magic_Boy/Desktop/stability/other/uart/uart_top.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/uart {C:/Users/Magic_Boy/Desktop/stability/other/uart/uart_control.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/ads {C:/Users/Magic_Boy/Desktop/stability/other/ads/V11_SPI.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/ads {C:/Users/Magic_Boy/Desktop/stability/other/ads/AD2.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/vibrate_dect {C:/Users/Magic_Boy/Desktop/stability/other/vibrate_dect/pass_zero_max.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/vibrate_dect {C:/Users/Magic_Boy/Desktop/stability/other/vibrate_dect/pass_zero_alarm.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/vibrate_dect {C:/Users/Magic_Boy/Desktop/stability/other/vibrate_dect/pass_zero_detect.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/ads {C:/Users/Magic_Boy/Desktop/stability/other/ads/ads1_dat_acquire.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/ads {C:/Users/Magic_Boy/Desktop/stability/other/ads/ads2_dat_acquire.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/ds3231m_i2c {C:/Users/Magic_Boy/Desktop/stability/other/ds3231m_i2c/ds3231_i2c.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/ds3231m_i2c {C:/Users/Magic_Boy/Desktop/stability/other/ds3231m_i2c/i2c_write.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/ds3231m_i2c {C:/Users/Magic_Boy/Desktop/stability/other/ds3231m_i2c/gen_divd.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/ds3231m_i2c {C:/Users/Magic_Boy/Desktop/stability/other/ds3231m_i2c/i2c_read.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/ds3231m_i2c {C:/Users/Magic_Boy/Desktop/stability/other/ds3231m_i2c/ds3231_control.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/mt41j128m16_control.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/ads {C:/Users/Magic_Boy/Desktop/stability/other/ads/ads_top.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/microchip {C:/Users/Magic_Boy/Desktop/stability/other/microchip/microchip_interact.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/ads {C:/Users/Magic_Boy/Desktop/stability/other/ads/ads_dat_decimate.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/vibrate_dect {C:/Users/Magic_Boy/Desktop/stability/other/vibrate_dect/shake_detect.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/vibrate_dect {C:/Users/Magic_Boy/Desktop/stability/other/vibrate_dect/peak_detect.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/vibrate_dect {C:/Users/Magic_Boy/Desktop/stability/other/vibrate_dect/search_peak_detect.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/vibrate_dect {C:/Users/Magic_Boy/Desktop/stability/other/vibrate_dect/peak_alarm.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/nco {C:/Users/Magic_Boy/Desktop/stability/other/nco/signal_produce.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/sys {C:/Users/Magic_Boy/Desktop/stability/other/sys/clock_lf.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/filter {C:/Users/Magic_Boy/Desktop/stability/other/filter/filter.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/filter {C:/Users/Magic_Boy/Desktop/stability/other/filter/filter_outersignal.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/filter {C:/Users/Magic_Boy/Desktop/stability/other/filter/filter_intersignal.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/signal_source {C:/Users/Magic_Boy/Desktop/stability/other/signal_source/signal_source.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/signal_detect {C:/Users/Magic_Boy/Desktop/stability/other/signal_detect/signal_detect.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/signal_detect {C:/Users/Magic_Boy/Desktop/stability/other/signal_detect/disconnect_detect.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/signal_detect {C:/Users/Magic_Boy/Desktop/stability/other/signal_detect/trouble_detect.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/timer {C:/Users/Magic_Boy/Desktop/stability/other/timer/timer.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/signal_detect {C:/Users/Magic_Boy/Desktop/stability/other/signal_detect/incident_process.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/vibrate_dect {C:/Users/Magic_Boy/Desktop/stability/other/vibrate_dect/baseline_available_detect.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/vibrate_dect {C:/Users/Magic_Boy/Desktop/stability/other/vibrate_dect/pass_baseline_pole.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/vibrate_dect {C:/Users/Magic_Boy/Desktop/stability/other/vibrate_dect/search_alarm.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/arithmetic {C:/Users/Magic_Boy/Desktop/stability/other/arithmetic/peak_divide.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/arithmetic {C:/Users/Magic_Boy/Desktop/stability/other/arithmetic/filter_out_mult.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/arithmetic {C:/Users/Magic_Boy/Desktop/stability/other/arithmetic/filter_out_divide.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/vibrate_dect {C:/Users/Magic_Boy/Desktop/stability/other/vibrate_dect/average_base6.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/vibrate_dect {C:/Users/Magic_Boy/Desktop/stability/other/vibrate_dect/filter_scale_divisor.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/vibrate_dect {C:/Users/Magic_Boy/Desktop/stability/other/vibrate_dect/zero_swing_detect.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/vibrate_dect {C:/Users/Magic_Boy/Desktop/stability/other/vibrate_dect/search_pole.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/vibrate_dect {C:/Users/Magic_Boy/Desktop/stability/other/vibrate_dect/generate_alarm.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/signal_process {C:/Users/Magic_Boy/Desktop/stability/other/signal_process/signal_process.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/signal_source {C:/Users/Magic_Boy/Desktop/stability/other/signal_source/signal_move.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/signal_store {C:/Users/Magic_Boy/Desktop/stability/other/signal_store/signal_store.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/ddr_control_ads.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/signal_detect {C:/Users/Magic_Boy/Desktop/stability/other/signal_detect/edge_detect.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/sys {C:/Users/Magic_Boy/Desktop/stability/other/sys/sys_control.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/microchip {C:/Users/Magic_Boy/Desktop/stability/other/microchip/ads_to_flex_fifo.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/ddr_control_alarm.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/microchip {C:/Users/Magic_Boy/Desktop/stability/other/microchip/ddr_befor5_fifo.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/microchip {C:/Users/Magic_Boy/Desktop/stability/other/microchip/ddr_after5_fifo.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/db {C:/Users/Magic_Boy/Desktop/stability/db/mult_e8n.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/alt_mem_ddrx_timing_param.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/alt_mem_ddrx_tbp.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/alt_mem_ddrx_sideband.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/alt_mem_ddrx_rdata_path.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/alt_mem_ddrx_odt_gen.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/alt_mem_ddrx_controller_st_top.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/alt_mem_ddrx_cmd_gen.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/alt_mem_ddrx_burst_gen.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/alt_mem_ddrx_addr_cmd_wrap.v}
vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/alt_mem_ddrx_addr_cmd.v}
vlib uart_115200
vmap uart_115200 uart_115200
vlog -vlog01compat -work uart_115200 +incdir+C:/Users/Magic_Boy/Desktop/stability/other/uart/uart_115200/synthesis {C:/Users/Magic_Boy/Desktop/stability/other/uart/uart_115200/synthesis/uart_115200.v}
vlog -vlog01compat -work uart_115200 +incdir+C:/Users/Magic_Boy/Desktop/stability/other/uart/uart_115200/synthesis/submodules {C:/Users/Magic_Boy/Desktop/stability/other/uart/uart_115200/synthesis/submodules/altera_up_rs232_counters.v}
vlog -vlog01compat -work uart_115200 +incdir+C:/Users/Magic_Boy/Desktop/stability/other/uart/uart_115200/synthesis/submodules {C:/Users/Magic_Boy/Desktop/stability/other/uart/uart_115200/synthesis/submodules/altera_up_rs232_in_deserializer.v}
vlog -vlog01compat -work uart_115200 +incdir+C:/Users/Magic_Boy/Desktop/stability/other/uart/uart_115200/synthesis/submodules {C:/Users/Magic_Boy/Desktop/stability/other/uart/uart_115200/synthesis/submodules/altera_up_rs232_out_serializer.v}
vlog -vlog01compat -work uart_115200 +incdir+C:/Users/Magic_Boy/Desktop/stability/other/uart/uart_115200/synthesis/submodules {C:/Users/Magic_Boy/Desktop/stability/other/uart/uart_115200/synthesis/submodules/altera_up_sync_fifo.v}
vlog -vlog01compat -work uart_115200 +incdir+C:/Users/Magic_Boy/Desktop/stability/other/uart/uart_115200/synthesis/submodules {C:/Users/Magic_Boy/Desktop/stability/other/uart/uart_115200/synthesis/submodules/uart_115200_rs232_0.v}
vlog -vlog01compat -work pll_L +incdir+C:/Users/Magic_Boy/Desktop/stability/other/pll/pll_L {C:/Users/Magic_Boy/Desktop/stability/other/pll/pll_L/pll_L_0002.v}
vlib read_buffer
vmap read_buffer read_buffer
vlog -vlog01compat -work read_buffer +incdir+c:/users/magic_boy/desktop/stability/db/ip/read_buffer {c:/users/magic_boy/desktop/stability/db/ip/read_buffer/read_buffer.v}
vlog -vlog01compat -work read_buffer +incdir+c:/users/magic_boy/desktop/stability/db/ip/read_buffer/submodules {c:/users/magic_boy/desktop/stability/db/ip/read_buffer/submodules/altsource_probe_top.v}
vlog -vlog01compat -work pll_H +incdir+C:/Users/Magic_Boy/Desktop/stability/other/pll/pll_H {C:/Users/Magic_Boy/Desktop/stability/other/pll/pll_H/pll_H_0002.v}
vlib signal_band_internalL
vmap signal_band_internalL signal_band_internalL
vlog -vlog01compat -work signal_band_internalL +incdir+c:/users/magic_boy/desktop/stability/db/ip/signal_band_internall {c:/users/magic_boy/desktop/stability/db/ip/signal_band_internall/signal_band_internall.v}
vlog -vlog01compat -work signal_band_internalL +incdir+c:/users/magic_boy/desktop/stability/db/ip/signal_band_internall/submodules {c:/users/magic_boy/desktop/stability/db/ip/signal_band_internall/submodules/signal_band_internall_nco_ii_0.v}
vlib signal_band_internal
vmap signal_band_internal signal_band_internal
vlog -vlog01compat -work signal_band_internal +incdir+c:/users/magic_boy/desktop/stability/db/ip/signal_band_internal {c:/users/magic_boy/desktop/stability/db/ip/signal_band_internal/signal_band_internal.v}
vlog -vlog01compat -work signal_band_internal +incdir+c:/users/magic_boy/desktop/stability/db/ip/signal_band_internal/submodules {c:/users/magic_boy/desktop/stability/db/ip/signal_band_internal/submodules/signal_band_internal_nco_ii_0.v}
vlib signal_band_externalL
vmap signal_band_externalL signal_band_externalL
vlog -vlog01compat -work signal_band_externalL +incdir+c:/users/magic_boy/desktop/stability/db/ip/signal_band_externall {c:/users/magic_boy/desktop/stability/db/ip/signal_band_externall/signal_band_externall.v}
vlog -vlog01compat -work signal_band_externalL +incdir+c:/users/magic_boy/desktop/stability/db/ip/signal_band_externall/submodules {c:/users/magic_boy/desktop/stability/db/ip/signal_band_externall/submodules/signal_band_externall_nco_ii_0.v}
vlib signal_band_external
vmap signal_band_external signal_band_external
vlog -vlog01compat -work signal_band_external +incdir+c:/users/magic_boy/desktop/stability/db/ip/signal_band_external {c:/users/magic_boy/desktop/stability/db/ip/signal_band_external/signal_band_external.v}
vlog -vlog01compat -work signal_band_external +incdir+c:/users/magic_boy/desktop/stability/db/ip/signal_band_external/submodules {c:/users/magic_boy/desktop/stability/db/ip/signal_band_external/submodules/signal_band_external_nco_ii_0.v}
vlib issp_dat_abs
vmap issp_dat_abs issp_dat_abs
vlog -vlog01compat -work issp_dat_abs +incdir+c:/users/magic_boy/desktop/stability/db/ip/issp_dat_abs {c:/users/magic_boy/desktop/stability/db/ip/issp_dat_abs/issp_dat_abs.v}
vlog -vlog01compat -work issp_dat_abs +incdir+c:/users/magic_boy/desktop/stability/db/ip/issp_dat_abs/submodules {c:/users/magic_boy/desktop/stability/db/ip/issp_dat_abs/submodules/altsource_probe_top.v}
vlog -sv -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/sequencer_scc_mgr.sv}
vlog -sv -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/sequencer_scc_acv_wrapper.sv}
vlog -sv -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/sequencer_reg_file.sv}
vlog -sv -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/sequencer_phy_mgr.sv}
vlog -sv -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/sequencer_data_mgr.sv}
vlog -sv -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/rw_manager_generic.sv}
vlog -sv -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/rw_manager_core.sv}
vlog -sv -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/mt41j128m16_s0_mm_interconnect_0_rsp_mux_002.sv}
vlog -sv -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/mt41j128m16_s0_mm_interconnect_0_rsp_mux_001.sv}
vlog -sv -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/mt41j128m16_s0_mm_interconnect_0_rsp_mux.sv}
vlog -sv -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/mt41j128m16_s0_mm_interconnect_0_rsp_demux_005.sv}
vlog -sv -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/mt41j128m16_s0_mm_interconnect_0_rsp_demux_003.sv}
vlog -sv -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/mt41j128m16_s0_mm_interconnect_0_router_008.sv}
vlog -sv -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/mt41j128m16_s0_mm_interconnect_0_router_006.sv}
vlog -sv -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/mt41j128m16_s0_mm_interconnect_0_router_003.sv}
vlog -sv -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/mt41j128m16_s0_mm_interconnect_0_router_002.sv}
vlog -sv -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/mt41j128m16_s0_mm_interconnect_0_router_001.sv}
vlog -sv -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/mt41j128m16_s0_mm_interconnect_0_router.sv}
vlog -sv -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/mt41j128m16_s0_mm_interconnect_0_cmd_mux_005.sv}
vlog -sv -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/mt41j128m16_s0_mm_interconnect_0_cmd_mux_003.sv}
vlog -sv -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/mt41j128m16_s0_mm_interconnect_0_cmd_mux.sv}
vlog -sv -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/mt41j128m16_s0_mm_interconnect_0_cmd_demux_002.sv}
vlog -sv -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/mt41j128m16_s0_mm_interconnect_0_cmd_demux_001.sv}
vlog -sv -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/mt41j128m16_s0_mm_interconnect_0_cmd_demux.sv}
vlog -sv -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/mt41j128m16_s0_mm_interconnect_0_avalon_st_adapter_error_adapter_0.sv}
vlog -sv -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/mt41j128m16_s0_irq_mapper.sv}
vlog -sv -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/mt41j128m16_pll0.sv}
vlog -sv -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/mt41j128m16_p0_read_datapath.sv}
vlog -sv -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/mt41j128m16_p0_memphy.sv}
vlog -sv -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/mt41j128m16_dmaster_timing_adt.sv}
vlog -sv -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/mt41j128m16_dmaster_p2b_adapter.sv}
vlog -sv -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/mt41j128m16_dmaster_b2p_adapter.sv}
vlog -sv -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/altera_merlin_traffic_limiter.sv}
vlog -sv -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/altera_merlin_slave_translator.sv}
vlog -sv -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/altera_merlin_slave_agent.sv}
vlog -sv -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/altera_merlin_master_translator.sv}
vlog -sv -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/altera_merlin_master_agent.sv}
vlog -sv -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/altera_merlin_burst_uncompressor.sv}
vlog -sv -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/altera_merlin_arbitrator.sv}
vlog -sv -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/altera_mem_if_sequencer_rst.sv}
vlog -sv -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/altera_mem_if_sequencer_mem_no_ifdef_params.sv}
vlog -sv -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/altera_mem_if_oct_cyclonev.sv}
vlog -sv -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/altera_mem_if_dll_cyclonev.sv}
vlog -sv -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/altdq_dqs2_acv_cyclonev.sv}
vlog -sv -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/alt_mem_if_nextgen_ddr3_controller_core.sv}
vlog -sv -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16 {C:/Users/Magic_Boy/Desktop/stability/other/mt41j128m16/mt41j128m16_p0.sv}
vcom -2008 -work fir_2_10hz {C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz/dspba_library_package.vhd}
vcom -2008 -work fir_2_10hz {C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz/auk_dspip_math_pkg_hpfir.vhd}
vcom -2008 -work fir_2_10hz {C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz/auk_dspip_avalon_streaming_controller_hpfir.vhd}
vcom -2008 -work fir_2_10hz {C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz/auk_dspip_roundsat_hpfir.vhd}
vcom -2008 -work fir_2_10hz_nco {C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco/dspba_library_package.vhd}
vcom -2008 -work fir_2_10hz_nco {C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco/auk_dspip_math_pkg_hpfir.vhd}
vcom -2008 -work fir_2_10hz_nco {C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco/auk_dspip_avalon_streaming_controller_hpfir.vhd}
vcom -2008 -work fir_2_10hz_nco {C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco/auk_dspip_roundsat_hpfir.vhd}
vcom -2008 -work fir_2_10hz {C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz/dspba_library.vhd}
vcom -2008 -work fir_2_10hz {C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz/auk_dspip_lib_pkg_hpfir.vhd}
vcom -2008 -work fir_2_10hz {C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz/auk_dspip_avalon_streaming_source_hpfir.vhd}
vcom -2008 -work fir_2_10hz {C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz/fir_2_10hz_0002_rtl_core.vhd}
vcom -2008 -work fir_2_10hz_nco {C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco/dspba_library.vhd}
vcom -2008 -work fir_2_10hz_nco {C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco/auk_dspip_lib_pkg_hpfir.vhd}
vcom -2008 -work fir_2_10hz_nco {C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco/auk_dspip_avalon_streaming_source_hpfir.vhd}
vcom -2008 -work fir_2_10hz_nco {C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco/fir_2_10hz_nco_0002_rtl_core.vhd}
vcom -2008 -work fir_2_10hz {C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz/auk_dspip_avalon_streaming_sink_hpfir.vhd}
vcom -2008 -work fir_2_10hz {C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz/fir_2_10hz_0002_ast.vhd}
vcom -2008 -work fir_2_10hz {C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz/fir_2_10hz_0002.vhd}
vcom -2008 -work fir_2_10hz_nco {C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco/auk_dspip_avalon_streaming_sink_hpfir.vhd}
vcom -2008 -work fir_2_10hz_nco {C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco/fir_2_10hz_nco_0002_ast.vhd}
vcom -2008 -work fir_2_10hz_nco {C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco/fir_2_10hz_nco_0002.vhd}
vlib Qsys_system
vmap Qsys_system Qsys_system
vlib fft
vmap fft fft

vlog -vlog01compat -work work +incdir+C:/Users/Magic_Boy/Desktop/stability/simulation/modelsim {C:/Users/Magic_Boy/Desktop/stability/simulation/modelsim/top.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -L fir_2_10hz -L fir_2_10hz_nco -L pll_L -L pll_H -L uart_115200 -L read_buffer -L signal_band_internalL -L signal_band_internal -L signal_band_externalL -L signal_band_external -L issp_dat_abs -L Qsys_system -L fft -voptargs="+acc"  top_vlg_tst

add wave *
view structure
view signals
run -all