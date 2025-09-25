onerror {resume}
quietly virtual function -install /DE1_SoC_testbench -env /DE1_SoC_testbench { &{/DE1_SoC_testbench/LEDR[9], /DE1_SoC_testbench/LEDR[8], /DE1_SoC_testbench/LEDR[7], /DE1_SoC_testbench/LEDR[6], /DE1_SoC_testbench/LEDR[5], /DE1_SoC_testbench/LEDR[4], /DE1_SoC_testbench/LEDR[3], /DE1_SoC_testbench/LEDR[2], /DE1_SoC_testbench/LEDR[1] }} lights
quietly WaveActivateNextPane {} 0
add wave -noupdate /DE1_SoC_testbench/CLOCK_50
add wave -noupdate /DE1_SoC_testbench/KEY
add wave -noupdate -label {SW[0] (reset)} {/DE1_SoC_testbench/SW[0]}
add wave -noupdate -label {KEY[3] (left)} {/DE1_SoC_testbench/KEY[3]}
add wave -noupdate -label {KEY[2](up)} {/DE1_SoC_testbench/KEY[2]}
add wave -noupdate -label {KEY[1] (down)} {/DE1_SoC_testbench/KEY[1]}
add wave -noupdate -label {KEY[0] (right)} {/DE1_SoC_testbench/KEY[0]}
add wave -noupdate /DE1_SoC_testbench/dut/detector/win
add wave -noupdate /DE1_SoC_testbench/dut/detector/loss
add wave -noupdate /DE1_SoC_testbench/dut/Driver/RedPixels
add wave -noupdate /DE1_SoC_testbench/dut/Driver/GrnPixels
add wave -noupdate /DE1_SoC_testbench/GPIO_1
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {5021 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 50
configure wave -gridperiod 100
configure wave -griddelta 2
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {4513 ps} {6648 ps}
