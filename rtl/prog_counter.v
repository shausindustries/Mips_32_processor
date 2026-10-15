`timescale 1ns / 1ps
module prog_counter(pci,pco,clk,stl,rst);
input [31:0]pci;
input clk,stl,rst;
output reg [31:0]pco;

always@ (posedge clk)
    begin
        if (rst == 1'b1) begin
            pco <= 32'b0;
        end
        else begin
            if (stl != 1'b1) begin
                pco <= pci;
            end
        end
    end
endmodule
