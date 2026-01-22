`timescale 1ns / 1ps
module control_unit(opcode,funct,we,we3,sel1,sel2,sel3,j,beq,bne,alc,ofs,mrd);
input [5:0]opcode,funct;
output we,we3,sel1,sel2,sel3,j,beq,bne,ofs,mrd;
output [2:0]alc;
wire [2:0]t1;

main_decoder M1 (.opcode(opcode),.sel1(sel1),.sel2(sel2),.sel3(sel3),.we(we),.we3(we3),
.bre(beq),.j(j),.op(t1),.ofs(ofs),.mrd(mrd),.brn(bne));
alu_decoder A1 (.funct(funct),.op(t1),.alc(alc));
endmodule
