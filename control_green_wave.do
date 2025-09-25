onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /control_green_testbench/clk
add wave -noupdate /control_green_testbench/reset
add wave -noupdate /control_green_testbench/key
add wave -noupdate -radix hexadecimal -childformat {{{/control_green_testbench/green[15]} -radix hexadecimal} {{/control_green_testbench/green[14]} -radix hexadecimal} {{/control_green_testbench/green[13]} -radix hexadecimal} {{/control_green_testbench/green[12]} -radix hexadecimal} {{/control_green_testbench/green[11]} -radix hexadecimal} {{/control_green_testbench/green[10]} -radix hexadecimal} {{/control_green_testbench/green[9]} -radix hexadecimal} {{/control_green_testbench/green[8]} -radix hexadecimal} {{/control_green_testbench/green[7]} -radix hexadecimal} {{/control_green_testbench/green[6]} -radix hexadecimal} {{/control_green_testbench/green[5]} -radix hexadecimal} {{/control_green_testbench/green[4]} -radix hexadecimal} {{/control_green_testbench/green[3]} -radix hexadecimal} {{/control_green_testbench/green[2]} -radix hexadecimal} {{/control_green_testbench/green[1]} -radix hexadecimal} {{/control_green_testbench/green[0]} -radix hexadecimal}} -expand -subitemconfig {{/control_green_testbench/green[15]} {-height 15 -radix hexadecimal} {/control_green_testbench/green[14]} {-height 15 -radix hexadecimal} {/control_green_testbench/green[13]} {-height 15 -radix hexadecimal} {/control_green_testbench/green[12]} {-height 15 -radix hexadecimal} {/control_green_testbench/green[11]} {-height 15 -radix hexadecimal} {/control_green_testbench/green[10]} {-height 15 -radix hexadecimal} {/control_green_testbench/green[9]} {-height 15 -radix hexadecimal} {/control_green_testbench/green[8]} {-height 15 -radix hexadecimal} {/control_green_testbench/green[7]} {-height 15 -radix hexadecimal} {/control_green_testbench/green[6]} {-height 15 -radix hexadecimal} {/control_green_testbench/green[5]} {-height 15 -radix hexadecimal} {/control_green_testbench/green[4]} {-height 15 -radix hexadecimal} {/control_green_testbench/green[3]} {-height 15 -radix hexadecimal} {/control_green_testbench/green[2]} {-height 15 -radix hexadecimal} {/control_green_testbench/green[1]} {-height 15 -radix hexadecimal} {/control_green_testbench/green[0]} {-height 15 -radix hexadecimal}} /control_green_testbench/green
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {18950 ps} 0}
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
WaveRestoreZoom {0 ps} {21263 ps}
