`timescale 1ns / 1ps
module reg_file(a1,a2,a3,wq3,wd3,rd1,rd2,clk,we3,rst,q1,q2,wqe);
input [4:0]a1,a2,a3;
input [31:0]wd3;
input [3:0]wq3;
input clk,we3,rst,wqe;
output reg [31:0]rd1;
output reg [31:0]rd2;
output reg [3:0]q1;
output reg [3:0]q2;

reg [31:0] mem [0:31];
reg [3:0] qi [0:31];
integer i;


always@ (negedge clk)
    begin
        if (rst == 1'b1) begin
            for (i=0; i<33; i = i + 1) begin
                mem[i] <= 32'b0;
                qi[i] <= 4'b0;
            end
            end
        else begin
            if (we3 == 1'b1 && wqe == 1'b0 || we3 == 1'b1 && wqe == 1'b1) begin
                mem[a3] <= wd3; 
                qi[a3] <= 4'b0000; end
            else if (we3 == 1'b0 && wqe == 1'b1) begin
                qi[a3] <= wq3; end
            else if (we3 == 1'b0 && wqe == 1'b0) begin
                if (a1 == 5'd0) begin
                    rd1 = 32'b0;
                end
                else begin
                    if (qi[a1] == 4'b0000) begin
                        rd1 = mem[a1];
                    end
                    else if (qi[a1] < 4'b1001 && qi[a1] != 4'b0000) begin
                        q1 = qi[a1];
                    end
                end
                if (a2 == 5'd0) begin
                    rd2 = 32'b0;
                end
                else begin
                    if (qi[a2] == 4'b0000) begin
                        rd2 = mem[a2];
                    end
                    else if (qi[a2] < 4'b1001 && qi[a2] != 4'b0000) begin
                        q2 = qi[a2];
                    end
                end
            end
        end
    end
endmodule