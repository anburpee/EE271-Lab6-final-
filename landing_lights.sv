module landing_lights (clk, reset, wind, out);
	input logic clk;
	input logic reset;
	input logic [1:0] wind;
	output logic [2:0] out;
	
	// State variables
	typedef enum logic [2:0] { outsides=3'b101, 
										middle=3'b010, 
										left=3'b100, 
										right=3'b001,
										none=3'b000 } states;
	states ps;
	states ns;
	
	always_comb begin
		ns = ps;
		case (ps)
		
			outsides: 	begin
								case (wind)
									2'b00:		ns = middle;
									2'b01:		ns = right;
									2'b10:		ns = left;
									2'b11:		ns = none; // default if wind == 2'b11
								endcase
							end
			
			middle:		begin
								case (wind)
									2'b00:		ns = outsides;
									2'b01:		ns = left;
									2'b10:		ns = right;
									2'b11:		ns = none; // default if wind == 2'b11
								endcase
							end
			
			left:			begin
								case (wind)
									2'b00:		ns = outsides;
									2'b01:		ns = right;
									2'b10:      ns = middle;
									2'b11:		ns = none; // default if wind == 2'b11
								endcase
							end
			
			right: 		begin
								case (wind)
									2'b00:		ns = outsides;
									2'b01:		ns = middle;
									2'b10:		ns = left;
									2'b11:		ns = none; // default if wind == 2'b11
								endcase
							end
					
			none: 		begin
								case (wind)
									2'b00:		ns = outsides;
									2'b01:		ns = right;
									2'b10:		ns = left;
									2'b11:		ns = none; // default if wind == 2'b11
								endcase
							end
		endcase
	end


	
	// Output logic 
		assign out = ps;
	
	// DFFs
	always_ff @(posedge clk) begin
		if (reset)
			ps <= none;
		else
			ps <= ns;
	end
endmodule


module landing_lights_testbench();
	logic clk;
	logic reset;
	logic [1:0] wind;
	logic [2:0] out;
	landing_lights dut (clk, reset, wind, out);
	
	// Set up a simulated clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
	end
	
	// Set up the inputs to the design. Each line is a clock cycle.
	integer i;
	initial begin
										@(posedge clk);
		reset <= 1; 				@(posedge clk); // Always reset FSMs at start
		reset <= 0; 
		for (i = 0; i < 3; i++) begin  //for each wind type
			wind <= i; repeat(6) @(posedge clk);
		end

		$stop; // End the simulation.
	end
endmodule
