onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /victory_display_testbench/clk
add wave -noupdate /victory_display_testbench/reset
add wave -noupdate /victory_display_testbench/leftmost
add wave -noupdate /victory_display_testbench/rightmost
add wave -noupdate /victory_display_testbench/l_player
add wave -noupdate /victory_display_testbench/r_player
add wave -noupdate /victory_display_testbench/HEX5
add wave -noupdate /victory_display_testbench/HEX4
add wave -noupdate /victory_display_testbench/HEX3
add wave -noupdate /victory_display_testbench/HEX2
add wave -noupdate /victory_display_testbench/HEX1
add wave -noupdate /victory_display_testbench/HEX0
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1711 ps} 0}
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
WaveRestoreZoom {0 ps} {1838 ps}
