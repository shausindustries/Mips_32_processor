`timescale 1ns / 1ps
module prog_counter(pci,pco,clk,stl);
input [31:0]pci;
input clk,stl;
output reg [31:0]pco;

always@ (posedge clk)
    begin
        if (stl != 1'b1) begin
            pco <= pci;
        end
    end
endmodule
