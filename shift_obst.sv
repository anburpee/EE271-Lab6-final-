module shift_obst(out_seq, clk, reset, enable, in_seq, direction, win, loss); 
	output logic [15:0] out_seq;
	input logic clk, reset, enable, direction, win, loss; 
	input logic [15:0] in_seq;
	
	always_ff @(posedge clk) begin 
	
		if (reset) 
			out_seq <= in_seq;
			
		else begin // IF ENABLE
			if (enable && ~win && ~loss) begin
				if (direction) 
					out_seq <= {out_seq[0], out_seq[15:1]}; 	// direction==1, go right
				else 										
					out_seq <= {out_seq[14:0], out_seq[15]};	// direction==0, go left
			end
		end
		
	end
		
endmodule
		

module shift_obst_testbench();
   logic [15:0] out_seq;
	logic clk, reset, enable, direction; 
	logic [15:0] in_seq;

    shift_obst dut(out_seq, clk, reset, enable, in_seq, direction); 
    
parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
	end
	
	// Test the design.
	initial begin
									repeat(1) @(posedge clk);	
		in_seq <= 10'b0000000001;
		reset <= 1;				repeat(1) @(posedge clk);
		reset <= 0;				repeat(4) @(posedge clk);
		
		enable <= 1;			
		
		direction <= 0;		repeat(16) @(posedge clk);
		

		direction <= 1;		repeat(16) @(posedge clk);

		$stop; // End the simulation.
	end
endmodule  