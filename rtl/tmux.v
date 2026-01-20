`timescale 1ns / 1ps
module tmux(a,b,s,o);
input [2:0]a,b;
input s;
output [2:0]o;

assign o = s ? a : b;
endmodule
