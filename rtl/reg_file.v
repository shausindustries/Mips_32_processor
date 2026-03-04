`timescale 1ns / 1ps
module reg_file(a1,a2,a3,wd3,rd1,rd2,clk,we3,rst);
input [4:0]a1,a2,a3;
input [31:0]wd3;
input clk,we3,rst;
output reg [31:0]rd1;
output reg [31:0]rd2;

reg [31:0] mem [0:31];
integer i;


always@ (negedge clk)
    begin
        if (rst == 1'b1) begin
            for (i=0; i<32; i = i + 1) begin
                mem[i] <= 32'b0;
            end
            end
        else begin
            if (we3)
                mem[a3] <= wd3;
    end
    end

always @(*) begin
    rd1 = (a1 == 5'd0) ? 32'b0 : mem[a1];
    rd2 = (a2 == 5'd0) ? 32'b0 : mem[a2];
end
endmodule
