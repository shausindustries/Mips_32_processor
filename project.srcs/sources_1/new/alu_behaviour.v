`timescale 1ns / 1ps
module alu_behaviour(a,b,o,op,zf);
input [31:0]a;
input [31:0]b;
input [2:0]op;
output reg zf;
output reg [31:0]o;

always@ (*)
    case (op)
        0 : o = a + b;
        1 : o = a - b;
        2 : o = a * b;
        3 : o = a / b;
        4 : o = a & b;
        5 : o = a | b;
        6 : o = a ^ b;
        7 : o = ~a & ~b;
    endcase
always@ (*)
    if (o == 32'h00000000)
        zf = 1'b1;
    else
        zf = 1'b1;
endmodule
