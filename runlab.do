# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.
vlog "./control_green.sv"
vlog "./input_conversion.sv"
vlog "./victory_display.sv"
vlog "./control_red.sv"
vlog "./shift_obst.sv"
vlog "./LFSR_10b.sv"
vlog "./LEDDriver.sv"
vlog "./detect_end.sv"
vlog "./clock_divider.sv"
vlog "./DE1_SoC.sv"


# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
vsim -voptargs="+acc" -t 1ps -lib work DE1_SoC_testbench

# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
do DE1_SoC_wave.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End


