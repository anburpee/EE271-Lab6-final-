// Top-level module that defines the I/Os for the DE-1 SoC board
module DE1_SoC_combined (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, LEDR, SW); 
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5; 
	output logic [9:0] LEDR; 
	input logic [9:0] SW;

	theft_flagger f (.LEDR, .SW);
	hex_displays h (.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .SW);
endmodule

module DE1_SoC_combined_testbench(); 
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5; 
	logic [9:0] LEDR; 
	logic [9:0] SW;
	DE1_SoC_combined dut (.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .LEDR, .SW);

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