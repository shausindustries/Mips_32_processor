`timescale 1ns / 1ps
module l_shift(in,out);
input [31:0]in;
output [31:0]out;

assign out = in << 2;
endmodule
