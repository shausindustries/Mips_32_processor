`timescale 1ns / 1ps
module main_decoder(opcode,sel1,sel2,sel3,we,we3,br,op,j,ofs,mrd);
input [5:0]opcode;
output reg sel1,sel2,sel3,we,we3,br,j,ofs,mrd;
output reg [2:0]op;

always@ (*)
begin
sel1 = 1'b0;
sel2 = 1'b0;
sel3 = 1'b0;
we = 1'b0;
we3 = 1'b0;
br = 1'b0;
j = 1'b0;
ofs = 1'b0;
op = 3'b000;
mrd = 1'b0;
case (opcode)
        0 : begin
                we3 = 1'b1;
                sel3 = 1'b1;
                sel1 = 1'b0;
                br = 1'b0;
                we = 1'b0;
                sel2 = 1'b0;
                op = 3'b010;
                j = 1'b0;
                ofs = 1'b0;
        end
        2 : begin
                we3 = 1'b0;
                sel3 = 1'bx;
                sel1 = 1'bx;
                br = 1'bx;
                we = 1'b0;
                sel2 = 1'bx;
                op = 3'bxxx;
                j = 1'b1;
                ofs = 1'b0;
        end
        4 : begin
                we3 = 1'b0;
                sel3 = 1'bx;
                sel1 = 1'b0;
                br = 1'b1;
                we = 1'b0;
                sel2 = 1'bx;
                op = 3'b001;
                j = 1'b0;
                ofs = 1'b0;
        end
        5 : begin
                we3 = 1'b0;
                sel3 = 1'bx;
                sel1 = 1'b0;
                br = 1'b1;
                we = 1'b0;
                sel2 = 1'bx;
                op = 3'b001;
                j = 1'b0;
                ofs = 1'b0;
        end
        8 : begin
                we3 = 1'b1;
                sel3 = 1'b0;
                sel1 = 1'b1;
                br = 1'b0;
                we = 1'b0;
                sel2 = 1'b0;
                op = 3'b000;
                j = 1'b0;
                ofs = 1'b1;
        end
        9 : begin
                we3 = 1'b1;
                sel3 = 1'b0;
                sel1 = 1'b1;
                br = 1'b0;
                we = 1'b0;
                sel2 = 1'b0;
                op = 3'b000;
                j = 1'b0;
                ofs = 1'b0;
        end
        12 : begin
                we3 = 1'b1;
                sel3 = 1'b0;
                sel1 = 1'b1;
                br = 1'b0;
                we = 1'b0;
                sel2 = 1'b0;
                op = 3'b100;
                j = 1'b0;
                ofs = 1'b0;
        end
        13 : begin
                we3 = 1'b1;
                sel3 = 1'b0;
                sel1 = 1'b1;
                br = 1'b0;
                we = 1'b0;
                sel2 = 1'b0;
                op = 3'b101;
                j = 1'b0;
                ofs = 1'b0;
        end
        14 : begin
                we3 = 1'b1;
                sel3 = 1'b0;
                sel1 = 1'b1;
                br = 1'b0;
                we = 1'b0;
                sel2 = 1'b0;
                op = 3'b110;
                j = 1'b0;
                ofs = 1'b0;
        end
        28 : begin
                we3 = 1'b1;
                sel3 = 1'b1;
                sel1 = 1'b0;
                br = 1'b0;
                we = 1'b0;
                sel2 = 1'b0;
                op = 3'b010;
                j = 1'b0;
                ofs = 1'b0;
        end
        35 : begin
                we3 = 1'b1;
                sel3 = 1'b0;
                sel1 = 1'b1;
                br = 1'b0;
                we = 1'b0;
                sel2 = 1'b1;
                op = 2'b000;
                j = 1'b0;
                ofs = 1'b0;
                mrd = 1'b1;
        end
        43 : begin
                we3 = 1'b0;
                sel3 = 1'bx;
                sel1 = 1'b1;
                br = 1'b0;
                we = 1'b1;
                sel2 = 1'bx;
                op = 2'b000;
                j = 1'b0;
                ofs = 1'b0;
        end
        endcase
end
endmodule
