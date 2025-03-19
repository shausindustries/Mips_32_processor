`timescale 1ns / 1ps
module ins_mem(a,rd);
input [31:0]a;
output [31:0]rd;
reg [31:0] mem [4294967295:0];
assign rd = mem[a];
endmodule
