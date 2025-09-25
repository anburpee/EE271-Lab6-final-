// Controls red LEDs
// ADD FUNCTION FOR WHEN IN PLACE TOO LONG
module control_red(red, clk, reset, LFSR_out, win, loss, movement, SW);
	output logic [15:0][15:0] red;
	input logic clk, reset, win, loss, movement;
	input logic [2:0] SW;
	input logic [9:0] LFSR_out; // assign each bit as the clk speed(enable) for the shift_obst modules
										// 0=slow clock,  1=fast clock (use as index to which_clk)
	
	logic [15:0] basic_seq;
	logic [15:0] blank_row;
	
	
	assign basic_seq = 16'b1100001100011000;
	
	assign blank_row = '0;
	
	
	
	logic [31:0] counter1;
	logic [31:0] counter2;
	logic slow_enable; 
	logic fast_enable;
	
	
	always_ff @(posedge clk) begin
		if(reset) begin
			counter1 <= 0; // fast
			counter2 <= 0; // slow
			fast_enable <= 1;
			slow_enable <= 1;
		end
		
		else begin
			if (SW[0]) begin // easy, medium
				if (counter1 >= 25000000) begin	// for board
	//			if (counter1 >= 2) begin  // for testing
					counter1 <= 0;
					fast_enable <= 1;
				end
				else begin
					counter1 <= counter1 + 1;
					fast_enable <= 0;
				end
			
				if (counter2 >= 20000000) begin	// for board
	//			if (counter2 >= 3) begin  // for testing
					counter2 <= 0;
					slow_enable <= 1;
				end
				else begin
					counter2 <= counter2 + 1;
					slow_enable <= 0;
				end
			end
			
			else if (SW[1]) begin // medium -- obstacles move faster
				if (counter1 >= 20000000) begin	// for board
	//			if (counter1 >= 2) begin  // for testing
					counter1 <= 0;
					fast_enable <= 1;
				end
				else begin
					counter1 <= counter1 + 1;
					fast_enable <= 0;
				end
			
				if (counter2 >= 15000000) begin	// for board
	//			if (counter2 >= 3) begin  // for testing
					counter2 <= 0;
					slow_enable <= 1;
				end
				else begin
					counter2 <= counter2 + 1;
					slow_enable <= 0;
				end
			end
			
			else if (SW[2]) begin // hard -- obstacles move even faster
				if (counter1 >= 15000000) begin	// for board
	//			if (counter1 >= 2) begin  // for testing
					counter1 <= 0;
					fast_enable <= 1;
				end
				else begin
					counter1 <= counter1 + 1;
					fast_enable <= 0;
				end
			
				if (counter2 >= 10000000) begin	// for board
	//			if (counter2 >= 3) begin  // for testing
					counter2 <= 0;
					slow_enable <= 1;
				end
				else begin
					counter2 <= counter2 + 1;
					slow_enable <= 0;
				end
			end
				
		end
		
	end
	
	
	// logic to pick clock
	logic [1:0] which_enable; 						
	assign which_enable = {fast_enable, slow_enable};
	

	// Instantiate 10 obstacle rows
	logic [9:0][15:0] out_seq_arr;
	
	genvar i;
	generate
	
		for (i=0; i<10; i++) begin: row_arr // name of the array of shift_obst modules
														  // access to each module: row_arr[0].row, row_array[1].row, etc.
			shift_obst row (
								 .out_seq(out_seq_arr[i]),
								 .clk(clk), 
								 .reset(reset),
								 .enable(which_enable[LFSR_out[i]]),
								 .in_seq({basic_seq[i:0], basic_seq[15:(i+1)]}), // staggers starting position by row
								 .direction(LFSR_out[i]), // direction pseudo randomized
								 .win(win),
							    .loss(loss)
								 );
		end
	endgenerate 
	
	
	
	// auto kill counter---automatic kill if in place for too long
	logic [31:0] counter3;
	logic auto_kill_enable;
	
	
	always_ff @(posedge clk) begin
		if(reset || movement) begin
			counter3 <= 0;
			auto_kill_enable <= 0;
		end
		
		else begin
			if (~win && ~loss) begin
				if (counter3 >= 500000000) begin	// for board -- 10 seconds
	//			if (counter3 >= 50) begin  // for testing
	//				counter3 <= 0; // unncessary
					auto_kill_enable <= 1;
				end
				else begin 
					counter3 <= counter3 + 1;
					auto_kill_enable <= 0;
				end
			end
		end
	end
	
	
	
	
	// assign each shift_obst module a row 
	// change game so that the rows are assigned randomly later
	always_ff @(posedge clk) begin // should only be triggered on enable
	
		if (reset)
			red <= '0;
			
		else begin
			if (auto_kill_enable) begin
				red <= '1;
			end
			
			else begin
				if (SW[0]) // level 1 (easy) --- fewer rows with obstacles
					red <= {
							  blank_row,
							  blank_row,
							  out_seq_arr[0],
							  blank_row,
							  out_seq_arr[1],
							  blank_row,
							  out_seq_arr[2],
							  blank_row,
							  out_seq_arr[3],
							  blank_row,
							  out_seq_arr[4],
							  blank_row,
							  out_seq_arr[5],
							  blank_row,
							  out_seq_arr[6],
							  blank_row
							  };
							  
				else if (SW[1]) // level 2 (medium)
					red <= {
							  blank_row,
							  out_seq_arr[0],
							  out_seq_arr[1],
							  blank_row,
							  out_seq_arr[2],
							  blank_row,
							  out_seq_arr[3],
							  blank_row,
							  out_seq_arr[4],
							  out_seq_arr[5],
							  blank_row,
							  out_seq_arr[6],
							  blank_row,
							  out_seq_arr[7],
							  out_seq_arr[8],
							  blank_row
							  };

				else if (SW[2]) // level 3 (hard)
					red <= {
							  blank_row,
							  out_seq_arr[0],
							  out_seq_arr[1],
							  blank_row,
							  out_seq_arr[2],
							  blank_row,
							  out_seq_arr[3],
							  blank_row,
							  out_seq_arr[4],
							  out_seq_arr[5],
							  blank_row,
							  out_seq_arr[6],
							  out_seq_arr[7],
							  out_seq_arr[8],
							  out_seq_arr[9],
							  blank_row
							  };
							  
			end
		end
	end
endmodule
	
	
	
module control_red_testbench();
   logic [15:0][15:0] red;
	logic clk, reset, win, loss, movement;
	logic[9:0] LFSR_out;

    control_red dut (red, clk, reset, LFSR_out, win, loss, movement);
    
	parameter CLOCK_PERIOD=100;
	//main clock
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
	end
	
	
	// Test the design.
	initial begin
			

		LFSR_out <= 10'b0000011111; 
		reset <= 0;							repeat(1) @(posedge clk);
	
		reset <= 1;							repeat(5) @(posedge clk);
		reset <= 0;							repeat(100) @(posedge clk);
		
		


		$stop; // End the simulation.
	end
endmodule
	