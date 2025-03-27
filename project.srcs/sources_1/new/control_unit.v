`timescale 1ns / 1ps
module control_unit(opcode,funct,we,we3,sel1,sel2,sel3,j,bc,alc,ofs);
input [5:0]opcode,funct;
output we,we3,sel1,sel2,sel3,j,bc,ofs;
output [2:0]alc;
wire [2:0]t1;

main_decoder M1 (.opcode(opcode),.sel1(sel1),.sel2(sel2),.sel3(sel3),.we(we),.we3(we3),.br(bc),.j(j),.op(t1),.ofs(ofs));
alu_decoder A1 (.funct(funct),.op(t1),.alc(alc));
endmodule
