# Create a clock with a period of 10 ns (100 MHz)
create_clock -period 10.0 [get_ports {clk}]

# Define input delay
set_input_delay -clock [get_clocks {clk}] 2.0 [get_ports {officer_button[*]}]

# Define output delay
set_output_delay -clock [get_clocks {clk}] 2.0 [get_ports {seg_ticket[*]}]
set_output_delay -clock [get_clocks {clk}] 2.0 [get_ports {seg_officer[*]}]

