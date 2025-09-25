module detect_end(win, loss, clk, reset, green, red);
	output logic win, loss; //trigger jason derulo sound when finished
	input logic clk, reset;
	input logic [15:0][15:0] green, red;

	
	typedef enum logic [1:0] {neither, success, failure} states;
	states ns, ps;
	

	function automatic states check_status (input logic [15:0][15:0] green, red);
		int i, j;
			
		for (i=0; i<16; i++) begin			
			for (j=0; j<16; j++) begin
							
				if (green[i][j])	begin // if green light is active
					if (i == 0)				// in top row
						return success;
								
					// check if there's overlap of active red and green lights
					else if (red[i][j])  // if red light is also active
						return failure;
				end
							
			end
		end
			
		return neither;
		
	endfunction
	
	
	// next state logic
	always_comb begin
		case (ps)
			success: ns = success;
			failure: ns = failure;
			neither: ns = check_status(green, red);
		endcase
	end
			
			
		
		
	always_ff @(posedge clk) begin
		if(reset)
			ps <= neither;
		else
			ps <= ns;
	end
	
	
	always_comb begin
		case (ps)
		
			neither: begin
				win = 0;
				loss = 0;
			end
						
			success: begin
				win = 1;
				loss = 0;
			end	
					
			failure: begin
				win = 0;
				loss = 1;
			end
			
		endcase
	end
		
endmodule 




module detect_end_testbench();
   logic win, loss;
	logic clk, reset;
	logic [15:0][15:0] green, red;

    detect_end dut (win, loss, clk, reset, green, red); 
    
parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
	end
	
	
	// Test the design.
	initial begin
									repeat(1) @(posedge clk);	
		reset <= 1;				repeat(1) @(posedge clk);
		reset <= 0;				repeat(1) @(posedge clk);
		
		red 			<= '0;
		red[14] 		<= 16'b0011000110000110;	
		green 		<= '0; 
		green[15] 	<= 16'b0000000010000000;// neither
		
		repeat(5) @(posedge clk);
		
		
		red 			<= '0;
		red[1] 		<= 16'b0011000110000110;
		green 		<= '0;
		green[1]		<= 16'b0000000010000000; //failure
		
		repeat(5) @(posedge clk);	
		
		
		
		// reset game
		red 			<= '0;
		red[14] 		<= 16'b0011000110000110;	
		green 		<= '0; 
		green[15] 	<= 16'b0000000010000000;
		reset <= 1;				repeat(1) @(posedge clk); 
		reset <= 0;				repeat(5) @(posedge clk); // neither
		
		
		red 			<= '0;
		red[1] 		<= 16'b0011000110000110;
		green 		<= '0;
		green[0]		<= 16'b0010000000000000; //success
		
		repeat(5) @(posedge clk);

		$stop; // End the simulation.
	end
endmodule






	
//	enum {neither, success, failure} ps, ns;
	
//	integer i, j;
//	always_comb begin
//		ns = ps;
//		case (ps)
//			success: ns = success;
//			failure: ns = failure;
//		
//			neither: 
//				check_status: begin // name of block
//					for (i=0; i<16; i++) begin			
//						for (j=0; j<16; j++) begin
//							
//							if (green[i][j])	begin // if green light is active
//								if (i == 0)	begin			// in top row
//									ns = success;
//									disable check_status; // <---- breaks out of all loops
//								end
//								
//								// check if there's overlap of active red and green lights
//								else if (red[i][j]) begin // if red light is also active
//									ns = failure;
//									disable check_status;
//								end
//								
//								else begin				  // no red/green overlap AND not success
//									ns = neither;
//									disable check_status;
//								end
//							end
//							
//						end
//					end
//					
//					ns = neither;
//					
//				end
//			
//		endcase
//	end
		
				
	
//	integer i;
//	integer j;
//	always_ff @(posedge clk) begin
//	
//		win = 0;
//		loss = 0;
//	
//		for (i=0; i<16; i++) begin			
//			for (j=0; j<16; j++) begin
//				
//				if (green[i][j] == 1)	// if green light is active
//					if (i == 0)				// in top row
//						win = 1;
//						break;
//						
//					// check if there's overlap of active red and green lights
//					if (red[i][j] == 1) // if red light is also active
//						loss = 1;
//						break;
//					
//			end
//		end
//		
//	end	

		
	