`timescale 1ns / 1ps
module control_unit(opcode,funct,we,we3,sel1,sel2,sel3,j,br,alc);
input [5:0]opcode,funct;
output we,we3,sel1,sel2,sel3,j,br;
output [2:0]alc;
wire [2:0]t1;

main_decoder M1 (.opcode(opcode),.sel1(sel1),.sel2(sel2),.sel3(sel3),.we(we),.we3(we3),.br(br),.j(j),.alc(alc),.op(t1));
alu_decoder A1 (.funct(funct),.op(t1),.alc(alc));
endmodule
