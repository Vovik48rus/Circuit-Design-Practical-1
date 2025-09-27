create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {clk}]
set_property PACKAGE_PIN E3 [get_ports {clk}]
set_property IOSTANDARD LVCMOS33 [get_ports {clk}]

set_property PACKAGE_PIN N16 [get_ports {led_r}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_r}]

set_property PACKAGE_PIN R11 [get_ports {led_g}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_g}]

set_property PACKAGE_PIN G14 [get_ports {led_b}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_b}]
