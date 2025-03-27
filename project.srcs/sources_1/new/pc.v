`timescale 1ns / 1ps
module pc(addr_in,addr_out,clk);
input clk;
input [7:0]addr_in;
output reg [7:0]addr_out;

always@ (posedge clk)
addr_out <= addr_in + 8'b00000001;
endmodule
