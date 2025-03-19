`timescale 1ns / 1ps
module data_mem(a,rd,we,clk,wd);
input clk,we;
input [31:0]a,wd;
output reg [31:0]rd;

reg [31:0] mem [31:0];

always@ (posedge clk)
    begin
        if (we)
            mem[a] <= wd;
        rd <= mem[a];
    end
endmodule
