onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /detect_end_testbench/clk
add wave -noupdate /detect_end_testbench/reset
add wave -noupdate /detect_end_testbench/green
add wave -noupdate /detect_end_testbench/red
add wave -noupdate /detect_end_testbench/win
add wave -noupdate /detect_end_testbench/loss
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1783 ps} 0}
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
WaveRestoreZoom {0 ps} {2468 ps}
