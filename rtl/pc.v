`timescale 1ns / 1ps
module pc(
    input clk,
    input [7:0]addr_in,
    output reg [7:0]addr_out
);

always@ (posedge clk)
begin
    addr_out <= addr_in + 8'b00000001;
end
endmodule
