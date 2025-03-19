`timescale 1ns / 1ps
module alu_behaviour(a,b,o,op);
input [31:0]a;
input [31:0]b;
input [2:0]op;
output reg [31:0]o;

always@ (*)
if (op == 3'b000)
o = a + b;
else if (op == 3'b001)
o = a - b;
else if (op == 3'b010)
o = a * b;
else if (op == 3'b011)
o = a / b;
else if (op == 3'b100)
o = a & b;
else if (op == 3'b101)
o = a | b;
else if (op == 3'b110)
o = a ^ b;
else if (op == 3'b111)
o = a << b;

endmodule
