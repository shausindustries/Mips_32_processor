`timescale 1ns / 1ps
module alu_decoder(funct,op,alc);
input [5:0]funct;
input [2:0]op;
output reg [2:0]alc;

always@ (*)
begin
    alc = 3'b000;
    case (op)
        3'b000 : alc = 3'b000;
        3'b001 : alc = 3'b001;
        3'b010 : begin
                    alc = 3'b000;
                    case (funct)
                        2 : alc = 3'b010;
                        32 : alc = 3'b000;
                        34 : alc = 3'b001;
                        36 : alc = 3'b100;
                        35 : alc = 3'b101;
                    endcase
                end
        3'b011 : alc = 3'b010;
        3'b100 : alc = 3'b100;
        3'b101 : alc = 3'b101;
        3'b110 : alc = 3'b110;
    endcase
end
endmodule
