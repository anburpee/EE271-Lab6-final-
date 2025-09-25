module all_lights (clk, reset, l_player, r_player, LEDR, L_won, R_won);
	output logic [8:0] LEDR;
	output logic L_won, R_won;
	input logic clk, reset, l_player, r_player;
	
	// State variables
	enum bit[3:0] {L5=4'b0000, L1=4'b0001, L2=4'b0010, L3=4'b0011, L4=4'b0100, L6=4'b0110,
						L7=4'b0111, L8=4'b1000, L9=4'b1001, l_won=4'b1011, r_won=4'b1100} ps, ns;
	
	always_comb begin
		ns = L5; // ns for l_won and r_won will be L5 (automatically resets after each win)
		case (ps)
		
			L1: 	if(r_player) 				ns = r_won;
					else if(l_player) 		ns = L2;
					else							ns = L1;
			
			L2:	if(r_player) 				ns = L1;
					else if(l_player) 		ns = L3;	
					else							ns = L2;
				
			L3:	if(r_player) 				ns = L2;
					else if(l_player) 		ns = L4;
					else							ns = L3;	
					
			L4:	if(r_player) 				ns = L3;
					else if(l_player) 		ns = L5;	
					else							ns = L4;
					
			L5:	if(r_player) 				ns = L4;
					else if(l_player) 		ns = L6;	
					else							ns = L5;
					
			L6:	if(r_player) 				ns = L5;
					else if(l_player) 		ns = L7;	
					else							ns = L6;
					
			L7:	if(r_player) 				ns = L6;
					else if(l_player) 		ns = L8;	
					else							ns = L7;
					
			L8:	if(r_player) 				ns = L7;
					else if(l_player) 		ns = L9;	
					else							ns = L8;
					
			L9:	if(r_player) 				ns = L8;
					else if(l_player) 		ns = l_won;	
					else							ns = L9;
					
			default:								ns = L5;
			
		endcase
	end

	
	// DFFs
	always_ff @(posedge clk) begin
		if (reset)
			ps <= L5;
		else
			ps <= ns;
	end

	
	always_comb begin
		LEDR[8:0] = 9'b000000000;
		L_won = 0;
		R_won = 0;
		case (ps)
			L1: 	LEDR[0] = 1;
			
			L2:	LEDR[1] = 1;
				
			L3:	LEDR[2] = 1;
			
			L4:	LEDR[3] = 1;
					
			L5:	LEDR[4] = 1;
					
			L6:	LEDR[5] = 1;
					
			L7:	LEDR[6] = 1;
					
			L8:	LEDR[7] = 1;
					
			L9:	LEDR[8] = 1;
			
			l_won: L_won = 1;
			
			r_won: R_won = 1;
		endcase
	end
endmodule



module all_lights_testbench();
	logic clk, reset, l_player, r_player;
	logic [8:0] LEDR;
	logic L_won, R_won;
	all_lights dut (clk, reset, l_player, r_player, LEDR, L_won, R_won);
	
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
		reset <= 1; 					  @(posedge clk); // Always reset FSMs at start
		reset <= 0; 
		for (i=0; i<35; i++) begin
			r_player <= 1;	 repeat(1) @(posedge clk); 
			r_player <= 0;	 repeat(1) @(posedge clk); 
		end
		
		for (i=0; i<35; i++) begin
			l_player <= 1;	 repeat(1) @(posedge clk); 
			l_player <= 0;	 repeat(1) @(posedge clk); 
		end
								 repeat(5) @(posedge clk)
		

		$stop; // End the simulation.
	end
endmodule
