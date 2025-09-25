// hex displays for items
module hex_displays (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, SW); 
output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5; 
input logic [9:0] SW;

always_comb begin
case (SW[9:7])


3'b000: begin
//HEX5 = 7'b0100100; // S
//HEX4 = 7'b1001000; // H
//HEX3 = 7'b0000001; // O
//HEX2 = 7'b0110000; // E
//HEX1 = 7'b0100100; // S
//HEX0 = 7'b1111111; // off
HEX5 = 7'b0010010; // S
HEX4 = 7'b0001001; // H
HEX3 = 7'b1000000; // O
HEX2 = 7'b0000110; // E
HEX1 = 7'b0010010; // S
HEX0 = 7'b1111111; // off
end

3'b001: begin
//HEX5 = 7'b1000011; // J
//HEX4 = 7'b0110000; // E
//HEX3 = 7'b1000001; // W
//HEX2 = 7'b0110000; // E
//HEX1 = 7'b1110001; // L
//HEX0 = 7'b1111010; // R
HEX5 = 7'b1100001; // J
HEX4 = 7'b0000110; // E
HEX3 = 7'b0010101; // W
HEX2 = 7'b0000110; // E
HEX1 = 7'b1000111; // L
HEX0 = 7'b0101111; // R
end

3'b010: begin
//HEX5 = 7'b0000001; // O
//HEX4 = 7'b1111010; // R
//HEX3 = 7'b1101010; // N
//HEX2 = 7'b0001000; // A
//HEX1 = 7'b0101011; // M
//HEX0 = 7'b0110000; // E
HEX5 = 7'b1000000; // O
HEX4 = 7'b0101111; // R
HEX3 = 7'b0101011; // N
HEX2 = 7'b0001000; // A
HEX1 = 7'b0101010; // M
HEX0 = 7'b0000110; // E
end

3'b100: begin
//HEX5 = 7'b0100100; // S
//HEX4 = 7'b0111110; // U
//HEX3 = 7'b1111001; // I
//HEX2 = 7'b1110000; // T
//HEX1 = 7'b1111111; // off
//HEX0 = 7'b1111111; // off
HEX5 = 7'b0010010; // S
HEX4 = 7'b1000001; // U
HEX3 = 7'b1001111; // I
HEX2 = 7'b0000111; // T
HEX1 = 7'b1111111; // off
HEX0 = 7'b1111111; // off
end

3'b101: begin
//HEX5 = 7'b0110000; // C
//HEX4 = 7'b0000001; // O
//HEX3 = 7'b0001000; // A
//HEX2 = 7'b1110000; // T
//HEX1 = 7'b1111111; // off
//HEX0 = 7'b1111111; // off
HEX5 = 7'b1000110; // C
HEX4 = 7'b1000000; // O
HEX3 = 7'b0001000; // A
HEX2 = 7'b0000111; // T
HEX1 = 7'b1111111; // off
HEX0 = 7'b1111111; // off
end

3'b111: begin
//HEX5 = 7'b0100100; // S
//HEX4 = 7'b0000001; // O
//HEX3 = 7'b0110000; // C
//HEX2 = 7'b0001001; // K
//HEX1 = 7'b0100100; // S
//HEX0 = 7'b1111111; // off
HEX5 = 7'b0010010; // S
HEX4 = 7'b1000000; // O
HEX3 = 7'b1000110; // C
HEX2 = 7'b0001001; // K
HEX1 = 7'b0010010; // S
HEX0 = 7'b1111111; // off
end

default: begin
HEX5 = 7'b1111111; // off
HEX4 = 7'b1111111; 
HEX3 = 7'b1111111; 
HEX2 = 7'b1111111; 
HEX1 = 7'b1111111; 
HEX0 = 7'b1111111;
end

endcase
end
endmodule


module hex_displays_testbench(); 
logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5; 
logic [9:0] SW;
hex_displays dut
(.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .SW);

// Try all combinations of inputs. 
integer i; 
initial begin
SW[6] = 1'b0;
SW[5] = 1'b0;
SW[4] = 1'b0;
SW[3] = 1'b0;
SW[2] = 1'b0;
SW[1] = 1'b0;
SW[0] = 1'b0;
for(i = 0; i < 8; i++) begin
{SW[9:7]} = i; #10;
end
end
endmodule 