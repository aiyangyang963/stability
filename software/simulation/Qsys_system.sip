set_global_assignment -entity "Qsys_system" -library "lib_Qsys_system" -name IP_TOOL_NAME "Qsys"
set_global_assignment -entity "Qsys_system" -library "lib_Qsys_system" -name IP_TOOL_VERSION "16.1"
set_global_assignment -entity "Qsys_system" -library "lib_Qsys_system" -name IP_TOOL_ENV "Qsys"
set_global_assignment -library "lib_Qsys_system" -name SPD_FILE [file join $::quartus(sip_path) "../Qsys_system.spd"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "../../other/Qsys_First/Qsys_system.qsys"]

set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "Qsys_system.v"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_reset_controller.v"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_reset_synchronizer.v"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_reset_controller.sdc"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Qsys_system_irq_mapper.sv"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Qsys_system_mm_interconnect_0.v"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Qsys_system_mm_interconnect_0_avalon_st_adapter.v"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Qsys_system_mm_interconnect_0_avalon_st_adapter_error_adapter_0.sv"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Qsys_system_mm_interconnect_0_rsp_mux_001.sv"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_merlin_arbitrator.sv"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Qsys_system_mm_interconnect_0_rsp_mux.sv"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Qsys_system_mm_interconnect_0_rsp_demux_002.sv"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Qsys_system_mm_interconnect_0_rsp_demux.sv"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Qsys_system_mm_interconnect_0_cmd_mux_002.sv"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Qsys_system_mm_interconnect_0_cmd_mux.sv"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Qsys_system_mm_interconnect_0_cmd_demux_001.sv"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Qsys_system_mm_interconnect_0_cmd_demux.sv"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_merlin_traffic_limiter.sv"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_merlin_reorder_memory.sv"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_avalon_sc_fifo.v"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_avalon_st_pipeline_base.v"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Qsys_system_mm_interconnect_0_router_004.sv"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Qsys_system_mm_interconnect_0_router_002.sv"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Qsys_system_mm_interconnect_0_router_001.sv"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Qsys_system_mm_interconnect_0_router.sv"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_merlin_slave_agent.sv"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_merlin_burst_uncompressor.sv"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_merlin_master_agent.sv"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_merlin_slave_translator.sv"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_merlin_master_translator.sv"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Qsys_system_sysid_qsys_0.v"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Qsys_system_pio_led.v"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Qsys_system_pio_key.v"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Qsys_system_onchip_rom.hex"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Qsys_system_onchip_rom.v"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Qsys_system_onchip_ram.hex"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Qsys_system_onchip_ram.v"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Qsys_system_nios2_qsys_0.sdc"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Qsys_system_nios2_qsys_0.vo"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Qsys_system_nios2_qsys_0_bht_ram.dat"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Qsys_system_nios2_qsys_0_bht_ram.hex"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Qsys_system_nios2_qsys_0_bht_ram.mif"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Qsys_system_nios2_qsys_0_dc_tag_ram.dat"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Qsys_system_nios2_qsys_0_dc_tag_ram.hex"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Qsys_system_nios2_qsys_0_dc_tag_ram.mif"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Qsys_system_nios2_qsys_0_ic_tag_ram.dat"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Qsys_system_nios2_qsys_0_ic_tag_ram.hex"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Qsys_system_nios2_qsys_0_ic_tag_ram.mif"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Qsys_system_nios2_qsys_0_jtag_debug_module_sysclk.v"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Qsys_system_nios2_qsys_0_jtag_debug_module_tck.v"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Qsys_system_nios2_qsys_0_jtag_debug_module_wrapper.v"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Qsys_system_nios2_qsys_0_mult_cell.v"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Qsys_system_nios2_qsys_0_nios2_waves.do"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Qsys_system_nios2_qsys_0_ociram_default_contents.dat"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Qsys_system_nios2_qsys_0_ociram_default_contents.hex"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Qsys_system_nios2_qsys_0_ociram_default_contents.mif"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Qsys_system_nios2_qsys_0_oci_test_bench.v"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Qsys_system_nios2_qsys_0_rf_ram_a.dat"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Qsys_system_nios2_qsys_0_rf_ram_a.hex"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Qsys_system_nios2_qsys_0_rf_ram_a.mif"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Qsys_system_nios2_qsys_0_rf_ram_b.dat"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Qsys_system_nios2_qsys_0_rf_ram_b.hex"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Qsys_system_nios2_qsys_0_rf_ram_b.mif"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Qsys_system_nios2_qsys_0_test_bench.v"]
set_global_assignment -library "lib_Qsys_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/Qsys_system_jtag_uart_0.v"]
