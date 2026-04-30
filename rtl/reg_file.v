`timescale 1ns / 1ps
module reg_file(a1,a2,a3,wd3,rd1,rd2,clk,we3,rst,q1,q2);
input [4:0]a1,a2,a3;
input [31:0]wd3;
input clk,we3,rst;
output reg [31:0]rd1;
output reg [31:0]rd2;
output reg [31:0]q1;
output reg [31:0]q2;

reg [31:0] mem [0:31];
reg [2:0] qi [0:31];
integer i;


always@ (negedge clk)
    begin
        if (rst == 1'b1) begin
            for (i=0; i<33; i = i + 1) begin
                mem[i] <= 32'b0;
                qi[i] <= 32'b0;
            end
            end
        else begin
            if (we3)
                mem[a3] <= wd3;
    end
    end

//we can reduce wires by using a qi = 0 signal for a mux
always @(*) begin
    if (a1 == 5'd0) begin
        rd1 = 32'b0;
    end
    else begin
        if (qi[a1] == 3'b000) begin
            rd1 = mem[a1];
        end
        else begin
            q1 = qi[a1];
        end
    end
    if (a2 == 5'd0) begin
        rd2 = 32'b0;
    end
    else begin
        if (qi[a2] == 32'b0) begin
            rd2 = mem[a2];
        end
        else begin
            q2 = qi[a2];
        end
    end
end
endmodule
