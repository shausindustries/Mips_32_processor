`timescale 1ns / 1ps
module tmux(a,s,o);
input [2:0]a;
input s;
output [2:0]o;

assign o = s ? a : 3'b000;
endmodule
