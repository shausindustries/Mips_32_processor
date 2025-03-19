`timescale 1ns / 1ps
module prog_counter(pci,pco,clk);
input [31:0]pci;
input clk;
output reg [31:0]pco;

always@ (posedge clk)
    begin
        pco <= pco + 4;
    end
endmodule
