// Top-level module that defines the I/Os for the DE-1 SoC board
module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, SW, LEDR, GPIO_1, CLOCK_50);
    output logic [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	 output logic [9:0]  LEDR;
    input  logic [3:0]  KEY;
    input  logic [9:0]  SW;
    output logic [35:0] GPIO_1;
    input logic CLOCK_50;

	 // Turn off HEX displays
//    assign HEX0 = '1;
//    assign HEX1 = '1;
//    assign HEX2 = '1;
//    assign HEX3 = '1;
//    assign HEX4 = '1;
//    assign HEX5 = '1;
	 
	 logic reset;
	 assign reset = SW[0];
	 
	 
	 
	 
	 	 /* Set up system base clock to 1526 Hz (50 MHz / 2**(14+1))
	    ===========================================================*/
//	 logic [31:0] clk;
	 logic SYSTEM_CLOCK;
//	 
//	 clock_divider divider (.clock(CLOCK_50), .reset(reset), .divided_clocks(clk));
//	 
	 assign SYSTEM_CLOCK = CLOCK_50; // 1526 Hz clock signal	 
//	 
//	 /* If you notice flickering, set SYSTEM_CLOCK faster.
//	    However, this may reduce the brightness of the LED board. */
//		
//	 logic faster_clk;
//	 logic slower_clk;
//	
//	 assign faster_clk = clk[1];
//	 assign slower_clk = clk[2];
//	 
//	 
//	 // Slow clock enable
//	 logic slow_enable;
//	 input_conversion slow (.clk(SYSTEM_CLOCK), .reset(reset), .player_input(slower_clk), .out(slow_enable));
//	 
//	 // Fast clock enable
//	 logic fast_enable;
//	 input_conversion fast (.clk(SYSTEM_CLOCK), .reset(reset), .player_input(faster_clk), .out(fast_enable));
	/* ================================================================== */
	 
	 
	 
	// Put all KEYs through 2 FFs and an input conversion module
	// -- RIGHT ------------------
	logic right_raw;	
	anti_metastability anti0 (.clk(SYSTEM_CLOCK), .in(~KEY[0]), .out(right_raw));
	logic right_converted;							
	input_conversion conv0 (.clk(SYSTEM_CLOCK), .reset(reset), .player_input(right_raw), .out(right_converted));
	 
	// -- DOWN -------------------
	logic down_raw;	
	anti_metastability anti1 (.clk(SYSTEM_CLOCK), .in(~KEY[1]), .out(down_raw)); 
	logic down_converted;							
	input_conversion conv1 (.clk(SYSTEM_CLOCK), .reset(reset), .player_input(down_raw), .out(down_converted));
	
	// -- UP ---------------------
	logic up_raw;	
	anti_metastability anti2 (.clk(SYSTEM_CLOCK), .in(~KEY[2]), .out(up_raw)); 
	logic up_converted;							
	input_conversion conv2 (.clk(SYSTEM_CLOCK), .reset(reset), .player_input(up_raw), .out(up_converted));
	
	// -- LEFT -------------------
	logic left_raw;	
	anti_metastability anti3 (.clk(SYSTEM_CLOCK), .in(~KEY[3]), .out(left_raw)); 
	logic left_converted;							
	input_conversion conv3 (.clk(SYSTEM_CLOCK), .reset(reset), .player_input(left_raw), .out(left_converted));
	
	
	
	/* ================================================================== */
	
	
	// Set up enable
	logic sw_raw;	
	anti_metastability anti4 (.clk(SYSTEM_CLOCK), .in(SW[0]), .out(sw_raw)); 
	logic enable;							
	input_conversion conv4 (.clk(SYSTEM_CLOCK), .reset(reset), .player_input(sw_raw), .out(enable));
	
	
	
	// Set up color arrays for LEDDriver inputs
	logic [9:0] LFSR_out;
	LFSR_10b lfsr (.out(LFSR_out), .clk(SYSTEM_CLOCK), .enable(enable)); // only generates new number on reset
	
	
	// outputs to detect_end
	 logic win;
	 logic loss;
	
	
	
	logic [15:0][15:0] frog;
	logic [3:0] inputs;
	logic movement;
	assign inputs = {left_converted, up_converted, down_converted, right_converted};
	control_green grn (.green(frog), .movement(movement), .clk(SYSTEM_CLOCK), .reset(reset),
							 .key(inputs), .win(win), .loss(loss));
	
	logic [15:0][15:0] obstacles;
	control_red rd (.red(obstacles), .clk(SYSTEM_CLOCK), .reset(reset), .LFSR_out(LFSR_out), 
						 .win(win), .loss(loss), .movement(movement), .SW(SW[3:1]));

						  
								  
	 /* Set up LED board driver
	    ================================================================== */

	 
	 /* Standard LED Driver instantiation - set once and 'forget it'. 
	    See LEDDriver.sv for more info. Do not modify unless you know what you are doing! */
		 
	logic enable_count;
	assign enable_count = 1'b1;
	 LEDDriver #(.FREQDIV(14)) Driver (.CLK(SYSTEM_CLOCK), .RST(reset), .EnableCount(enable_count),
					 .RedPixels(obstacles), .GrnPixels(frog), .GPIO_1(GPIO_1));
	
//	assign LEDR[0] = enable_count;
	 
	 /* ================================================================== */
	
	
	 detect_end detector (.win(win), .loss(loss), .clk(SYSTEM_CLOCK),
								 .reset(reset), .green(frog), .red(obstacles));

	 
	 victory_display vict (.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, 
								  .clk(SYSTEM_CLOCK), .reset, .win, .loss);
	 
	 
	 
	 
endmodule 





module DE1_SoC_testbench();
	logic [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0]  LEDR;
   logic [3:0]  KEY;
   logic [9:0]  SW;
   logic [35:0] GPIO_1;
   logic CLOCK_50;
	
	
	DE1_SoC dut (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, SW, LEDR, GPIO_1, CLOCK_50); 
	
	// Set up a simulated clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50; // Forever toggle the clock
	end
	
	
	// Test the design.
	integer i;
	initial begin
								
		SW[0] <= 1;			repeat(5) @(posedge CLOCK_50);	// reset
		SW[0] <= 0;
		SW[1] <= 1; //easy
		KEY[0] <= 1;
		KEY[1] <= 1;
		KEY[2] <= 1;
		KEY[3] <= 1;
								repeat(1) @(posedge CLOCK_50);
		
		
		
		for (i=0; i<10; i++) begin
			KEY[0] <= 0;		repeat(1) @(posedge CLOCK_50);
			KEY[0] <= 1;		repeat(1) @(posedge CLOCK_50);
		end
		
		for (i=0; i<20; i++) begin
			KEY[3] <= 0;		repeat(1) @(posedge CLOCK_50);
			KEY[3] <= 1;		repeat(1) @(posedge CLOCK_50);
		end
		
		for (i=0; i<5; i++) begin
			KEY[1] <= 1;		repeat(1) @(posedge CLOCK_50);
			KEY[1] <= 0;		repeat(1) @(posedge CLOCK_50);
		end
		
		for (i=0; i<20; i++) begin
			KEY[2] <= 0;		repeat(1) @(posedge CLOCK_50);
			KEY[2] <= 1;		repeat(1) @(posedge CLOCK_50);
		end

		
		SW[0] <= 1;			repeat(5) @(posedge CLOCK_50);	// reset
		SW[0] <= 0;			repeat(60) @(posedge CLOCK_50);
	
		
		$stop; // End the simulation.
	end
endmodule

			