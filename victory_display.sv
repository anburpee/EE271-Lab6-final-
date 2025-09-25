module victory_display (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, clk, reset, win, loss); 
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5; 
	input logic clk, reset, win, loss;
	
	enum {success, failure, neither} ps, ns;
		
	// next state logic
	always_comb begin
	
		ns = neither; //default
		
		if (win)
			ns = success;
		
		else if (loss)
			ns = failure;
	end
		
		
		
	// DFF
	always_ff @(posedge clk) begin
		if (reset)
			ps <= neither;
		else
			ps <= ns;
	end	
		
		
	// output logic
	always_comb begin	
		case(ps)
		
			success: begin
				HEX5 = 7'b0011001; // y
				HEX4 = 7'b1100011; // u
				HEX3 = 7'b0001011; // h
				HEX2 = 7'b0001011; // h
				HEX1 = 7'b0001011; // h
				HEX0 = 7'b0001011; // h
		
			end
		
//				HEX5 = 7'b0100001; // d
//				HEX4 = 7'b0000110; // E
//				HEX3 = 7'b0101111; // r
//				HEX2 = 7'b1100011; // u
//				HEX1 = 7'b1100111; // l
//				HEX0 = 7'b0100011; // o
//			end
			
			failure: begin
				HEX5 = 7'b0000011; // b
				HEX4 = 7'b0100011; // o
				HEX3 = 7'b0100011; // o
				HEX2 = 7'b0100011; // o
				HEX1 = 7'b0100011; // o
				HEX0 = 7'b0100011; // o
			end
		
			neither: begin
				HEX5 = 7'b1111111; //
				HEX4 = 7'b1111111; //
				HEX3 = 7'b1111111; //
				HEX2 = 7'b1111111; //
				HEX1 = 7'b1111111; //
				HEX0 = 7'b1111111; // 
			end
			
		endcase
	end
	
endmodule



module victory_display_testbench();
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5; 
	logic clk, reset, win, loss;
	victory_display dut (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, clk, reset, win, loss);
	
	// Set up a simulated clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
	end
	
	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
														@(posedge clk);
		reset <= 1; 					 			@(posedge clk); // off
		win <= 0;
		loss<= 0;
		reset <= 0; 								@(posedge clk)	 // neither
		
		win <= 1;									@(posedge clk); // 
		// go back to neither 
		reset <= 1;									@(posedge clk); // yuhhhh
		reset <= 0;			
		win	<= 0; 				  			   @(posedge clk); // neither
		// go back to neither 
		loss <= 1;					  repeat(2) @(posedge clk); // booooo



		$stop; // End the simulation.
	end
endmodule
