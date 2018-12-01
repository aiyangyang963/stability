set_global_assignment -entity "uart_115200" -library "lib_uart_115200" -name IP_TOOL_NAME "Qsys"
set_global_assignment -entity "uart_115200" -library "lib_uart_115200" -name IP_TOOL_VERSION "16.1"
set_global_assignment -entity "uart_115200" -library "lib_uart_115200" -name IP_TOOL_ENV "Qsys"
set_global_assignment -library "lib_uart_115200" -name SPD_FILE [file join $::quartus(sip_path) "../uart_115200.spd"]
set_global_assignment -library "lib_uart_115200" -name MISC_FILE [file join $::quartus(sip_path) "../../uart_115200.qsys"]

set_global_assignment -library "lib_uart_115200" -name MISC_FILE [file join $::quartus(sip_path) "uart_115200.v"]
set_global_assignment -library "lib_uart_115200" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_up_rs232_counters.v"]
set_global_assignment -library "lib_uart_115200" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_up_rs232_in_deserializer.v"]
set_global_assignment -library "lib_uart_115200" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_up_rs232_out_serializer.v"]
set_global_assignment -library "lib_uart_115200" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_up_sync_fifo.v"]
set_global_assignment -library "lib_uart_115200" -name MISC_FILE [file join $::quartus(sip_path) "submodules/uart_115200_rs232_0.v"]
