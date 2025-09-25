module LFSR_10b (out, clk, enable); // make it so it only activates once at the beginning of the game
	output logic [9:0] out =  10'b0011001001;
	input logic clk, enable; // enable=single pulse triggered by reset
	
	logic [9:0] intermediate = 10'b0011001001;
	
	// DFFS
	always_ff @(posedge clk) begin // generates a new combination every clk cycle
		
		intermediate <= {~(intermediate[3] ^ intermediate[0]), intermediate[9:1]};
		
	end


	always_ff @(posedge clk) begin // outputs a combination only on reset(which triggers enable)
		
		if (enable)
			out <= intermediate;
		
	end
endmodule
	
	
module LFSR_10b_testbench();
	logic [9:0] out;
	logic clk, enable; 
	LFSR_10b dut (out, clk, enable); //why do we not need the . in front of each input/output?
	
	// Set up a simulated clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
	end
	
	// Test the design.
	initial begin
	
		enable <= 0;		repeat(20) @(posedge clk);
		enable <= 1; 		repeat(1) @(posedge clk);
		enable <= 0;		repeat(20) @(posedge clk);
		enable <= 1; 		repeat(1) @(posedge clk);
		enable <= 0;		repeat(20) @(posedge clk);

		$stop; // End the simulation.
	end
endmodule

