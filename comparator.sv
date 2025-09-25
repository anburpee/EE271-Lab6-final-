module comparator (A, B, out);
	output logic out;
	input logic [9:0] A, B;
	
	always_comb begin
		out = 0;
		for (int i=9; i>=0; i--) begin
		
			if (A[i] != B[i]) begin
				out = (A[i] == 1);
				break;
			end
				
		end
	end
endmodule 


module comparator_testbench();
	logic [9:0] A,B;
	logic out; 
	comparator dut (A,B, out);
	
	// Test the design.
	initial begin
	A=10'b0000000000; B=10'b0000000001; #10 // false
	A=10'b0000011000; B=10'b0000000001; #10 // true
	A=10'b0000000000; B=10'b0000000000; #10 // false
	A=10'b0000001100; B=10'b0000001101; #10 // false
	A=10'b1101000011; B=10'b1101000010; #10 // true
	
	

		$stop; // End the simulation.
	end
endmodule

