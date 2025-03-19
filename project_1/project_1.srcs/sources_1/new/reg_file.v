`timescale 1ns / 1ps
module reg_file(a1,a2,a3,wd3,rd1,rd2,clk,we3);
input [4:0]a1;
input [4:0]a2;
input [4:0]a3;
input [31:0]wd3;
input clk,we3;
output reg [31:0]rd1;
output reg [31:0]rd2;

reg [31:0] mem [31:0];

always@ (posedge clk)
    begin
        if (we3)
            mem[a3] <= wd3;
        
        rd1 <= mem[a1];
        rd2 <= mem[a2];
    end
endmodule
