onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /LFSR_10b_testbench/clk
add wave -noupdate /LFSR_10b_testbench/enable
add wave -noupdate -radix hexadecimal /LFSR_10b_testbench/dut/intermediate
add wave -noupdate -radix hexadecimal /LFSR_10b_testbench/out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4450 ps} 0}
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
WaveRestoreZoom {0 ps} {2670 ps}
