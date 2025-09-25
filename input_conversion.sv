module input_conversion (clk, reset, player_input, out);
	output logic out;
	input logic clk, reset, player_input;
	
	// State variables
	enum {released, pressed} ps, ns;
	
	always_comb begin
		case (ps)
		
		released: 	if(player_input)  ns = pressed;
						else 					ns = released;
		
		pressed:		if(player_input)	ns = pressed;
						else					ns = released;
			
		endcase
	end

	assign out = (ps == released & player_input);
	
	// DFFs
	always_ff @(posedge clk) begin
		if (reset)
			ps <= released;
		else
			ps <= ns;
	end
endmodule


module input_conversion_testbench();
	logic clk, reset, player_input;
	logic out;
	input_conversion dut (clk, reset, player_input, out);
	
	// Set up a simulated clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
	end
	
	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
											  @(posedge clk);
		reset <= 1; 					  @(posedge clk); // Always reset FSMs at start
		reset <= 0; 
		player_input <= 1; repeat(4) @(posedge clk);
		player_input <= 0; repeat(4) @(posedge clk);
		player_input <= 1; repeat(3) @(posedge clk);
		player_input <= 0; repeat(5) @(posedge clk);
		player_input <= 1; repeat(7) @(posedge clk);
		player_input <= 0; repeat(3) @(posedge clk);

		$stop; // End the simulation.
	end
endmodule
