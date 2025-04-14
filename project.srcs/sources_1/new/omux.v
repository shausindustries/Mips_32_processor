`timescale 1ns / 1ps
module omux(a,b,s,o);
input a,b,s;
output o;

assign o = s ? a : b;
endmodule
