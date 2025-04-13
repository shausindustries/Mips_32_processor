`timescale 1ns / 1ps
module bit32x4(a,b,c,o,sel);
input [31:0]a,b,c;
input sel;
output reg [31:0]o;

always@ (*)
    case (sel)
        0 : o = a;
        1 : o = b;
        2 : o = c;
    endcase
endmodule
