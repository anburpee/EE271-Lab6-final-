module center_light (clk, reset, NL, NR, l_player, r_player, out);
	output logic out;
	input logic clk, reset, NL, NR, l_player, r_player;
	
	// State variables
	enum {off, on} ps, ns;
	
	always_comb begin
		case (ps)
		
		off: 	if((NL & r_player) | (NR & l_player))  	ns = on;
				else 													ns = off;
		
		on:	if(l_player | r_player)							ns = off;
				else													ns = on;
			
		endcase
	end

	assign out = ps;
	
	// DFFs
	always_ff @(posedge clk) begin
		if (reset)
			ps <= on;
		else
			ps <= ns;
	end
endmodule


module center_light_testbench();
	logic clk, reset, NL, NR, l_player, r_player;
	logic out;
	center_light dut (clk, reset, NL, NR, l_player, r_player, out);
	
	// Set up a simulated clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
	end
	
	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
														  @(posedge clk);
		reset <= 1; 					 			  @(posedge clk); // on
		reset <= 0; 														// off
		NL <= 1; 	l_player <= 1;	 repeat(2) @(posedge clk); // off
						l_player <= 0;	 repeat(2) @(posedge clk); // off
						r_player <= 1;  repeat(2) @(posedge clk); // on 1 cycle, off 1 cycle
						r_player <= 0;  repeat(2) @(posedge clk); // off
		
		NL <= 0;
		NR <= 1; 	l_player <= 1;	 repeat(2) @(posedge clk); // on 1 cycle, off 1 cycle
						l_player <= 0;	 repeat(2) @(posedge clk); // off
						r_player <= 1;  repeat(2) @(posedge clk); // off
						r_player <= 0;  repeat(2) @(posedge clk); // off

		$stop; // End the simulation.
	end
endmodule
