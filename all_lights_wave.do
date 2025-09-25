onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /all_lights_testbench/clk
add wave -noupdate /all_lights_testbench/reset
add wave -noupdate /all_lights_testbench/l_player
add wave -noupdate /all_lights_testbench/r_player
add wave -noupdate /all_lights_testbench/LEDR
add wave -noupdate /all_lights_testbench/HEX0
add wave -noupdate /all_lights_testbench/HEX1
add wave -noupdate /all_lights_testbench/HEX2
add wave -noupdate /all_lights_testbench/HEX3
add wave -noupdate /all_lights_testbench/HEX4
add wave -noupdate /all_lights_testbench/HEX5
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3460 ps} 0}
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
WaveRestoreZoom {0 ps} {4253 ps}
