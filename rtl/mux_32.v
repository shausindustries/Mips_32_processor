`timescale 1ns / 1ps
module mux_32(a,b,sel,o);
    input [31:0]a,b;
    input sel;
    output reg [31:0]o;
    
    assign o = sel ? a : b;
endmodule           