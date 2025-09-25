//module win_sound(HEX, clk, reset, win, loss);
//	output logic [6:0] HEX;
//	input logic clk, reset, win, loss;
//	
//	enum {neither, success, failure} ps, ns;
//	
//	always_ff @(posedge clk) begin
//		if (reset)
//			