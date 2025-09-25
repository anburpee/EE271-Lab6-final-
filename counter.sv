module counter (clk, reset, w, HEX);
	output logic [6:0] HEX;
	input logic clk, reset, w;
	
	// state variables
	typedef enum bit[2:0] {zero=3'b000, one=3'b001, two=3'b010, three=3'b011, 
								  four=3'b100, five=3'b101, six=3'b110, seven=3'b111} states;
	states ps, ns;
						
	// next state logic
	always_comb begin
		ns = ps;
		case (ps)
			zero: 	if (w) 	ns = one;
			one: 		if (w) 	ns = two;
			two: 		if (w) 	ns = three;
			three: 	if (w) 	ns = four;
			four: 	if (w) 	ns = five;
			five:	 	if (w) 	ns = six;
			six: 		if (w) 	ns = seven;
			default: 			ns = ps;
		endcase
	end
	
	// DFFs
	always_ff @(posedge clk) begin
		if (reset)
			ps <= zero;
		else
			ps <= ns;
	end
	
	
	// output logic
	always_comb begin
		case (ps)
			zero: 	HEX = 7'b1000000;
			one: 		HEX = 7'b1111001;
			two: 		HEX = 7'b0100100;
			three:	HEX = 7'b0110000;
			four: 	HEX = 7'b0011001;
			five: 	HEX = 7'b0010010;
			six: 		HEX = 7'b0000010;
			seven: 	HEX = 7'b1011000;
		endcase
	end
endmodule 