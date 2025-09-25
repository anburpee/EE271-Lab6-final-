// Top-level module that defines the I/Os for the DE-1 SoC board
module theft_flagger (LEDR, SW);  
output logic [9:0] LEDR; 
input logic [9:0] SW;
logic a1out, a2out, n1out;

// Logic to check if an items is discounted and
// to flag stolen items.
// Result should drive LEDR[1](signifies whether an item is discounted)
// and LEDR[0](signifies whether an item is stolen or not)
// SW[9] = U
// SW[8] = P
// SW[7] = C
// SW[0] = M
//assign LEDR[1] = SW[8] | (SW[9] & SW[7]);
//assign LEDR[0] = ~(SW[8] | SW[0] | (SW[7] & ~SW[9]));
and a1 (a1out, SW[7], SW[9]);
or o1 (LEDR[1], a1out, SW[8]);

not n1 (n1out, SW[9]);
and a2 (a2out, n1out, SW[7]);
nor norGate (LEDR[0], a2out, SW[0], SW[8]);

endmodule

module theft_flagger_testbench(); 
logic [9:0] LEDR; 
logic [9:0] SW;
theft_flagger dut (.LEDR, .SW);

// Try all combinations of inputs. 
integer i; 
initial begin
SW[6] = 1'b0;
SW[5] = 1'b0;
SW[4] = 1'b0;
SW[3] = 1'b0;
SW[2] = 1'b0;
SW[1] = 1'b0;
for(i = 0; i < 16; i++) begin
{SW[9], SW[8], SW[7], SW[0]} = i; #10;
end
end
endmodule 