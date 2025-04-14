`timescale 1ns / 1ps
module bit32x4(a,b,c,d,o,sel);
input [31:0]a,b,c,d;
input [1:0]sel;
output reg [31:0]o;

always@ (*)
    begin
        case (sel)
            0 : o = a;
            1 : o = b;
            2 : o = c;
            default: o = a;
        endcase
    end
endmodule
