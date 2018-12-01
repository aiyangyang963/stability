set_global_assignment -entity "pll_L" -library "lib_pll_L" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "pll_L" -library "lib_pll_L" -name IP_TOOL_VERSION "17.0"
set_global_assignment -entity "pll_L" -library "lib_pll_L" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_pll_L" -name SPD_FILE [file join $::quartus(sip_path) "pll_L.spd"]

set_global_assignment -library "lib_pll_L" -name MISC_FILE [file join $::quartus(sip_path) "pll_L_sim/pll_L.vo"]
