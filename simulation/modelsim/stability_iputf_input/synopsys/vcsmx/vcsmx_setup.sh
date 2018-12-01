
cp -f C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco_sim/fir_2_10hz_nco_rtl_core_u0_m0_wo0_cm0_lutmem.hex ./
cp -f C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco_sim/fir_2_10hz_nco_rtl_core_u0_m0_wo0_wi0_r0_ra0_count1_lut_lutmem.hex ./

vhdlan -xlrm "C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco_sim/dspba_library_package.vhd"                      
vhdlan -xlrm "C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco_sim/dspba_library.vhd"                              
vhdlan -xlrm "C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco_sim/auk_dspip_math_pkg_hpfir.vhd"                   
vhdlan -xlrm "C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco_sim/auk_dspip_lib_pkg_hpfir.vhd"                    
vhdlan -xlrm "C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco_sim/auk_dspip_avalon_streaming_controller_hpfir.vhd"
vhdlan -xlrm "C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco_sim/auk_dspip_avalon_streaming_sink_hpfir.vhd"      
vhdlan -xlrm "C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco_sim/auk_dspip_avalon_streaming_source_hpfir.vhd"    
vhdlan -xlrm "C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco_sim/auk_dspip_roundsat_hpfir.vhd"                   
vlogan +v2k  "C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco_sim/altera_avalon_sc_fifo.v"                        
vhdlan -xlrm "C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco_sim/fir_2_10hz_nco_rtl_core.vhd"                    
vhdlan -xlrm "C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco_sim/fir_2_10hz_nco_ast.vhd"                         
vhdlan -xlrm "C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco_sim/fir_2_10hz_nco.vhd"                             
vhdlan -xlrm "C:/Users/Magic_Boy/Desktop/stability/other/filter/fir_ii/fir_2_10hz_nco_sim/fir_2_10hz_nco_tb.vhd"                          
vlogan +v2k  "C:/Users/Magic_Boy/Desktop/stability/other/pll/pll_L_sim/pll_L.vo"                                                          
vlogan +v2k  "C:/Users/Magic_Boy/Desktop/stability/other/pll/pll_H_sim/pll_H.vo"                                                          
