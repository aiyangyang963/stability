
cp -f C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco_sim/fir_2_10hz_nco_rtl_core_u0_m0_wo0_cm0_lutmem.hex ./
cp -f C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco_sim/fir_2_10hz_nco_rtl_core_u0_m0_wo0_wi0_r0_ra0_count1_lut_lutmem.hex ./

ncvhdl -v93 "C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco_sim/dspba_library_package.vhd"                      
ncvhdl -v93 "C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco_sim/dspba_library.vhd"                              
ncvhdl -v93 "C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco_sim/auk_dspip_math_pkg_hpfir.vhd"                   
ncvhdl -v93 "C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco_sim/auk_dspip_lib_pkg_hpfir.vhd"                    
ncvhdl -v93 "C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco_sim/auk_dspip_avalon_streaming_controller_hpfir.vhd"
ncvhdl -v93 "C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco_sim/auk_dspip_avalon_streaming_sink_hpfir.vhd"      
ncvhdl -v93 "C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco_sim/auk_dspip_avalon_streaming_source_hpfir.vhd"    
ncvhdl -v93 "C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco_sim/auk_dspip_roundsat_hpfir.vhd"                   
ncvlog      "C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco_sim/altera_avalon_sc_fifo.v"                        
ncvhdl -v93 "C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco_sim/fir_2_10hz_nco_rtl_core.vhd"                    
ncvhdl -v93 "C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco_sim/fir_2_10hz_nco_ast.vhd"                         
ncvhdl -v93 "C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco_sim/fir_2_10hz_nco.vhd"                             
ncvhdl -v93 "C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco_sim/fir_2_10hz_nco_tb.vhd"                          
ncvlog      "C:/Users/Magic_Boy/Desktop/stability/other/pll/pll_L_sim/pll_L.vo"                                                          
ncvlog      "C:/Users/Magic_Boy/Desktop/stability/other/pll/pll_H_sim/pll_H.vo"                                                          
