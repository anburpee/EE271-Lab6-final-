// Controls green LEDs
// MAKE IT SO THAT LIGHTS CAN'T WRAP AROUND
module control_green(green, movement, clk, reset, key, win, loss);
	output logic [15:0][15:0] green;
	output logic movement;
	input logic clk, reset, win, loss;
	input logic [3:0] key;
	
	
	logic [3:0] horiz_position = 4'd8;
	logic [3:0] vert_position = 4'd15;
	logic [3:0] next_horiz_position;
	logic [3:0] next_vert_position;
	
	logic moved;

   // Combinational logic for movement & movement detection
   always_comb begin
		// Default to staying in same position
      next_horiz_position = horiz_position; // x
      next_vert_position  = vert_position;  // y
		moved = 1'b0;

      if (~win && ~loss) begin
		
			if (key[0] && horiz_position > 0) begin
				next_horiz_position = 4'(horiz_position - 1); // shift right
				moved = 1'b1;
			end
				
         else if (key[3] && horiz_position < 15) begin
				next_horiz_position = 4'(horiz_position + 1); // shift left
				moved = 1'b1;
			end
			
         else if (key[2] && vert_position > 0) begin
				next_vert_position = 4'(vert_position - 1);   // shift up
				moved = 1'b1;
			end
				
         else if (key[1] && vert_position < 15) begin
				next_vert_position = 4'(vert_position + 1);   // shift down
				moved = 1'b1;
			end
     end
	end
	
	
	integer i;
	always_ff @(posedge clk) begin 
	
		if (reset) begin
			horiz_position <= 4'd8;
			vert_position <= 4'd15;
			movement <= 0;
		end
			
		else begin 
			horiz_position <= next_horiz_position;
			vert_position <= next_vert_position;
			movement <= moved;
		end
		
		green <= '0;
		green[vert_position][horiz_position] <= 1'b1;
		
		
	end
	
endmodule
			

			
			
			
module control_green_testbench();
	logic [15:0][15:0] green;
	logic movement;
	logic clk, reset, win, loss;
	logic [3:0] key;
	control_green dut (green, clk, reset, key, win, loss); 
	
	// Set up a simulated clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
	end
	
	// Test the design.
	integer i;
	initial begin
								repeat(1) @(posedge clk);
		reset <= 1;			repeat(1) @(posedge clk);
		reset <= 0;
	// set up win/loss
		key[0] <= 0;
		key[1] <= 0;
		key[2] <= 0;
		key[3] <= 0;
								repeat(1) @(posedge clk);
		
		
		
		for (i=0; i<20; i++) begin //right
			key[0] <= 1;		repeat(1) @(posedge clk);
			key[0] <= 0;		repeat(1) @(posedge clk);
		end
		
		for (i=0; i<20; i++) begin // down
			key[1] <= 1;		repeat(1) @(posedge clk);
			key[1] <= 0;		repeat(1) @(posedge clk);
		end
		
		for (i=0; i<20; i++) begin // up
			key[2] <= 1;		repeat(1) @(posedge clk);
			key[2] <= 0;		repeat(1) @(posedge clk);
		end
		
		for (i=0; i<20; i++) begin // left
			key[3] <= 1;		repeat(1) @(posedge clk);
			key[3] <= 0;		repeat(1) @(posedge clk);
		end
		
		for (i=0; i<20; i++) begin // down
			key[1] <= 1;		repeat(1) @(posedge clk);
			key[1] <= 0;		repeat(1) @(posedge clk);
		end
		

		$stop; // End the simulation.
	end
endmodule

			