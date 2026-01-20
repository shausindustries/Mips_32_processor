`timescale 1ns / 1ps
module alu_behaviour(a,b,o,op,zf,of);
input [31:0]a;
input [31:0]b;
input [2:0]op;
output reg zf,of;
output reg [31:0]o;

always@ (*)
begin
    o = 8'h00000000;
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
end
always@ (*)
begin
    zf = 1'b0;
    if (o == 32'h00000000)
        zf = 1'b1;
    else
        zf = 1'b0;
end

always@ (*)
begin
    of = 1'b0;
    if (o > 32)
        of = 1'b1;
    else
        of = 1'b0;
end
endmodule
