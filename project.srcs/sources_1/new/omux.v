`timescale 1ns / 1ps
module omux(a,s,o);
input a,s;
output o;

assign o = s ? a : 1'b0;
endmodule
