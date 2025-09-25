// Controls red LEDs
module auto_kill(out, clk, reset);
	output logic [15:0][15:0] red;
	input logic clk, reset, win, loss;
	input logic[9:0] LFSR_out; // assign each bit as the clk speed(enable) for the shift_obst modules
										// 0=slow clock,  1=fast clock (use as index to which_clk)
	
	logic [15:0] basic_seq;
//	logic [9:0] directions;
	logic [15:0] blank_row;
	
	
	assign basic_seq = 16'b1100001100011000;
	
//	assign directions = 10'b0110101001; // arbitraty combination--5 rows go left, 5 rows go right
//													// 0=left, 1=right
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
			if (counter1 >= 30000000) begin	// for board
//			if (counter1 >= 2) begin  // for testing
				counter1 <= 0;
				fast_enable <= 1;
			end
			else begin
				counter1 <= counter1 + 1;
				fast_enable <= 0;
			end
		
			if (counter2 >= 25000000) begin	// for board
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
	
	
	// assign each shift_obst module a row 
	// change game so that the rows are assigned randomly later
	always_ff @(posedge clk) begin // should only be triggered on enable
	
		if (reset)
			red <= '0;
			
		else 
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
endmodule